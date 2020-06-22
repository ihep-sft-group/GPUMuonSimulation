#ifndef FORWARDLISTNODE_HPP
#define FORWARDLISTNODE_HPP

#include <boost/shared_ptr.hpp>

namespace Util {
template<class T> class forward_list;
template<class T> class forward_list_const_iterator;
template<class T> class forward_list_iterator;

/**
 * Node of a forward_list.
 *
 * @ingroup primitive_container
 *
 * @tparam T Value type.
 */
template<class T>
class forward_list_node {
  friend class forward_list<T> ;
  friend class forward_list_const_iterator<T> ;
  friend class forward_list_iterator<T> ;
public:
  /**
   * Constructor.
   */
  forward_list_node();

  /**
   * Constructor.
   */
  forward_list_node(const T& value);

private:
  /**
   * Value.
   */
  T value;

  /**
   * Next node in list.
   */
  boost::shared_ptr<forward_list_node<T> > next;
};
}

template<class T>
inline Util::forward_list_node<T>::forward_list_node() {
  //
}

template<class T>
inline Util::forward_list_node<T>::forward_list_node(const T& value) :
    value(value) {
  //
}

#endif