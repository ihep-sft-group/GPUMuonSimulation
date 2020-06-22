#include "GPUSvc/NPU.hh"

template<> const char Desc<float>::code = 'f' ; 
template<> const char Desc<double>::code = 'f' ; 

template<> const char Desc<char>::code = 'i' ; 
template<> const char Desc<short>::code = 'i' ; 
template<> const char Desc<int>::code = 'i' ; 
template<> const char Desc<long>::code = 'i' ; 
template<> const char Desc<long long>::code = 'i' ; 

template<> const char Desc<unsigned char>::code = 'u' ; 
template<> const char Desc<unsigned short>::code = 'u' ; 
template<> const char Desc<unsigned int>::code = 'u' ; 
template<> const char Desc<unsigned long>::code = 'u' ; 
template<> const char Desc<unsigned long long>::code = 'u' ; 

template<> const char Desc<std::complex<float> >::code = 'c' ; 
template<> const char Desc<std::complex<double> >::code = 'c' ; 

const char* NPU::MAGIC = "\x93NUMPY" ; 
const bool NPU::fortran_order = false ;

char Endian::detect()
{
    u16c2_t one ;
    one.u16 = 1 ;   // use the union to detect endianness and do the split 
 
    bool little_endian = one.c[0] == 1 && one.c[1] == 0 ; 
    bool big_endian = one.c[0] == 0 && one.c[1] == 1 ; 
    assert( little_endian ^ big_endian ); 

    return little_endian ? LITTLE : BIG ;  
}
std::string NPU::xxdisplay(const std::string& hdr, int width, char non_printable)
{
    std::stringstream ss ; 
    for(int i=0 ; i < hdr.size() ; i++) 
    {   
        char c = hdr[i] ; 
        bool printable = c >= ' ' && c <= '~' ;  // https://en.wikipedia.org/wiki/ASCII
        ss << ( printable ? c : non_printable )  ;
        if((i+1) % width == 0 ) ss << "\n" ; 
   }   
   return ss.str(); 
}

int NPU::_parse_header_length(const std::string& hdr )
{
/*
Extract from the NPY format specification
-------------------------------------------

* https://github.com/numpy/numpy/blob/master/doc/neps/nep-0001-npy-format.rst
   
1. The first 6 bytes are a magic string: exactly "x93NUMPY".
2. The next 1 byte is an unsigned byte: the major version number of the file format, e.g. x01.
3. The next 1 byte is an unsigned byte: the minor version number of the file format, e.g. x00. 
   Note: the version of the file format is not tied to the version of the numpy package.

4. The next 2 bytes form a little-endian unsigned short int: the length of the header data HEADER_LEN.

The next HEADER_LEN bytes form the header data describing the array's format.
It is an ASCII string which contains a Python literal expression of a
dictionary. It is terminated by a newline ('n') and padded with spaces ('x20')
to make the total length of the magic string + 4 + HEADER_LEN be evenly
divisible by 16 for alignment purposes.

Example Headers
----------------

Created by commands like::

    python -c "import numpy as np ; np.save('/tmp/z0.npy', np.zeros((10,4), dtype=np.float64)) "


Older NumPy does not add padding::

    epsilon:np blyth$ xxd /tmp/z.npy
    00000000: 934e 554d 5059 0100 4600 7b27 6465 7363  .NUMPY..F.{'desc
    00000010: 7227 3a20 273c 6638 272c 2027 666f 7274  r': '<f8', 'fort
    00000020: 7261 6e5f 6f72 6465 7227 3a20 4661 6c73  ran_order': Fals
    00000030: 652c 2027 7368 6170 6527 3a20 2831 302c  e, 'shape': (10,
    00000040: 2034 292c 207d 2020 2020 2020 2020 200a   4), }         .
    00000050: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000070: 0000 0000 0000 0000 0000 0000 0000 0000  ................


Newer NumPy adds a little padding to the header::

    epsilon:np blyth$ xxd /tmp/z0.npy
    00000000: 934e 554d 5059 0100 7600 7b27 6465 7363  .NUMPY..v.{'desc
    00000010: 7227 3a20 273c 6638 272c 2027 666f 7274  r': '<f8', 'fort
    00000020: 7261 6e5f 6f72 6465 7227 3a20 4661 6c73  ran_order': Fals
    00000030: 652c 2027 7368 6170 6527 3a20 2831 302c  e, 'shape': (10,
    00000040: 2034 292c 207d 2020 2020 2020 2020 2020   4), }          
    00000050: 2020 2020 2020 2020 2020 2020 2020 2020                  
    00000060: 2020 2020 2020 2020 2020 2020 2020 2020                  
    00000070: 2020 2020 2020 2020 2020 2020 2020 200a                 .
    00000080: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000090: 0000 0000 0000 0000 0000 0000 0000 0000  ................


Parsing the header
-------------------

The preamble is first 8 bytes, 6 bytes for the magic then 2 bytes for the version, 
followed by 2 bytes with the header length : making 10 bytes which are always present.
The header length does not include these first 10 bytes.  The header is padded with x20
to make (hlen+10)%16 == 0 and it is terminated with a newline hex:0a dec:10  


NumPy np.save / np.load
-------------------------

* https://github.com/numpy/numpy/blob/master/numpy/lib/npyio.py
* https://github.com/numpy/numpy/blob/master/numpy/lib/format.py


*/
    std::string preamble = hdr.substr(0,8) ;  
    std::string PREAMBLE = _make_preamble(); 
    assert( preamble.compare(PREAMBLE) == 0 );  

    char hlen_lsb = hdr[8] ;  
    char hlen_msb = hdr[9] ;  
    int hlen = hlen_msb << 8 | hlen_lsb ; 
    assert( (hlen+10) % 16 == 0 ) ;  
    assert( hlen+10 == hdr.size() ) ; 

#ifdef NPU_DEBUG
    std::cout 
        << " _parse_header_length  "  << std::endl 
        << " hdr               " << std::endl << xxdisplay(hdr, 16, '.' ) << std::endl  
        << " preamble          " << preamble << std::endl 
        << " hlen_lsb(hex)     " << std::hex << int(hlen_lsb) << std::endl 
        << " hlen_msb(hex)     " << std::hex << int(hlen_msb) << std::endl 
        << " hlen(hex)         " << std::hex << hlen << std::endl 
        << " hlen_lsb(dec)     " << std::dec << int(hlen_lsb) << std::endl 
        << " hlen_msb(dec)     " << std::dec << int(hlen_msb) << std::endl 
        << " hlen(dec)         " << std::dec << hlen << std::endl 
        << " hlen+10(dec)      " << std::dec << hlen+10 << std::endl 
        << " (hlen+10)%16(dec) " << (hlen+10)%16 << std::endl 
        << " hdr.size() (dec)  " << std::dec << hdr.size() << std::endl 
        << " preamble.size()   " << std::dec << preamble.size() << std::endl 
        << std::endl 
        ; 

#endif
    return hlen ; 
}
std::string NPU::_make_preamble( int major, int minor )
{
    std::string preamble(MAGIC) ; 
    preamble.push_back((char)major); 
    preamble.push_back((char)minor); 
    return preamble ; 
}
void NPU::_parse_tuple(std::vector<int>& shape, const std::string& sh )
{
    std::istringstream f(sh);
    std::string s;

    char delim = ',' ; 
    const char* trim = " " ;  

    int ival(0) ; 

    while (getline(f, s, delim)) 
    {
       s.erase(0, s.find_first_not_of(trim));  // left trim
       s.erase(s.find_last_not_of(trim) + 1);   // right trim 
       if( s.size() == 0 ) continue ; 

       std::istringstream ic(s) ;
       ic >> ival ; 

       shape.push_back(ival) ; 
 
#ifdef NPU_DEBUG
       std::cout << "[" << s << "] -> " << ival << std::endl ;
#endif

    }

#ifdef NPU_DEBUG
    std::cout << " parse_tuple " 
              << " sh  [" << sh << "]" 
              << " shape " << shape.size()
              << std::endl
              ;

#endif
}
std::string NPU::check(const char* path) 
{
    std::stringstream ss ; 
    ss << "python -c \"import numpy as np ; print(np.load('" 
       << path 
       << "')) \" && xxd " 
       << path 
       ; 
    return ss.str(); 
}
std::string NPU::_make_header(const std::vector<int>& shape, const char* descr )
{
    std::string dict = _make_dict( shape, descr ); 
    std::string header = _make_header( dict ); 
    return header ; 
}
std::string NPU::_make_dict(const std::vector<int>& shape, const char* descr )
{
    std::stringstream ss ; 
    ss << "{" ; 
    ss << "'descr': '" << descr << "', " ; 
    ss << "'fortran_order': " << ( fortran_order ? "True" : "False" ) << ", " ; 
    ss << "'shape': " ; 
    ss << _make_tuple( shape ) ; 
    ss << "}" ;  
    return ss.str(); 
} 

std::string NPU::_make_tuple( const std::vector<int>& shape )
{
    int ndim = shape.size() ;
    std::stringstream ss ; 
    ss << "(" ; 

    if( ndim == 1)
    {
        ss << shape[0] << "," ; 
    }
    else
    {
        for(int i=0 ; i < ndim ; i++ ) ss << shape[i] << ( i == ndim - 1 ? "" : ", " )  ; 
    }
    ss << "), " ;
    return ss.str(); 
}
std::string NPU::_little_endian_short_string( uint16_t dlen )
{
    // https://github.com/numpy/numpy/blob/master/doc/neps/nep-0001-npy-format.rst
    // The next 2 bytes form a little-endian unsigned short int: the length of the header data HEADER_LEN

    u16c2_t len ; 
    len.u16 = dlen ; 

    char e = Endian::detect() ; 
    std::string hlen(2, ' ') ;
    hlen[0] = e == Endian::LITTLE ? len.c[0] : len.c[1] ;  
    hlen[1] = e == Endian::LITTLE ? len.c[1] : len.c[0] ; 

#ifdef NPU_DEBUG
    std::cout << " dlen " << dlen << std::endl ; 
    std::cout << " len.c[0] " << len.c[0] << std::endl ; 
    std::cout << " len.c[1] " << len.c[1] << std::endl ; 
    std::cout << ( e == Endian::LITTLE ? "little_endian" : "big_endian" ) << std::endl ; 
#endif

    return hlen ; 
}

std::string NPU::_make_header(const std::string& dict)
{
    uint16_t dlen = dict.size() ;
    uint16_t padding = 16 - ((10 + dlen ) % 16 ) - 1 ;
    padding += 3*16 ; // adhoc extra padding for bit-perfect matching to NumPy (for test array anyhow)
    uint16_t hlen = dlen + padding + 1 ; 

#ifdef NPU_DEBUG
    std::cout 
        << " dlen " << dlen 
        << " padding " << padding
        << " hlen " << hlen 
        << std::endl 
        ; 
#endif

    assert( (hlen + 10) % 16 == 0 );  
    std::stringstream ss ; 
    ss << _make_preamble() ;  
    ss << _little_endian_short_string( hlen ) ; 
    ss << dict ; 
 
    for(int i=0 ; i < padding ; i++ ) ss << " " ; 
    ss << "\n" ;  

    return ss.str(); 
}