#ifndef FORWARDLISTCONSTITERATOR_HPP
#define FORWARDLISTCONSTITERATOR_HPP

#include "forward_list_const_iterator.hpp"

namespace Util {
template<class T> class forward_list;
template<class T> class forward_list_const_iterator;

/**
 * Iterator for forward_list.
 *
 * @ingroup primitive_iterator
 *
 * @tparam T Value type.
 */
template<class T>
class forward_list_iterator : public forward_list_const_iterator<T> {
  friend class forward_list<T>;
  friend class forward_list_const_iterator<T>;
public:
  forward_list_iterator();
  explicit forward_list_iterator(boost::shared_ptr<forward_list_node<T> >& node);
  T& operator*();
  T* operator->();
  forward_list_iterator<T>& operator++();
  forward_list_iterator<T> operator++(int);
};
}

template<class T>
Util::forward_list_iterator<T>::forward_list_iterator() {
  //
}

template<class T>
Util::forward_list_iterator<T>::forward_list_iterator(
    boost::shared_ptr<forward_list_node<T> >& node) :
    forward_list_const_iterator<T>(node) {
  //
}

template<class T>
inline T& Util::forward_list_iterator<T>::operator*() {
  return this->node->value;
}

template<class T>
inline T* Util::forward_list_iterator<T>::operator->() {
  return &this->node->value;
}

template<class T>
inline Util::forward_list_iterator<T>& Util::forward_list_iterator<T>::operator++() {
  this->node = this->node->next;
  return *this;
}

template<class T>
inline Util::forward_list_iterator<T> Util::forward_list_iterator<T>::operator++(int) {
  Util::forward_list_iterator<T> result(*this);
  ++(*this);
  return result;
}

#endif