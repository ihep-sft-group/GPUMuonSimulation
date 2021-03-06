#ifndef FORWARDLISTITERATOR_HPP
#define FORWARDLISTITERATOR_HPP

#include "forward_list_node.hpp"

namespace Util {
template<class T> class forward_list;
template<class T> class forward_list_iterator;

/**
 * Iterator for a forward_list.
 *
 * @ingroup primitive_iterator
 *
 * @tparam T Value type.
 */
template<class T>
class forward_list_const_iterator {
  friend class forward_list<T>;
  friend class forward_list_iterator<T>;
public:
  forward_list_const_iterator();
  explicit forward_list_const_iterator(boost::shared_ptr<forward_list_node<T> >& node);
  const T& operator*() const;
  const T* operator->() const;
  forward_list_const_iterator<T>& operator++();
  forward_list_const_iterator<T> operator++(int);
  bool operator==(const forward_list_const_iterator<T>& o);
  bool operator!=(const forward_list_const_iterator<T>& o);

private:
  /**
   * Node.
   */
  boost::shared_ptr<forward_list_node<T> > node;
};
}

template<class T>
Util::forward_list_const_iterator<T>::forward_list_const_iterator() {
  //
}

template<class T>
Util::forward_list_const_iterator<T>::forward_list_const_iterator(
    boost::shared_ptr<forward_list_node<T> >& node) :
    node(node) {
  //
}

template<class T>
inline const T& Util::forward_list_const_iterator<T>::operator*() const {
  return node->value;
}

template<class T>
inline const T* Util::forward_list_const_iterator<T>::operator->() const {
  return &node->value;
}

template<class T>
inline Util::forward_list_const_iterator<T>& Util::forward_list_const_iterator<T>::operator++() {
  node = node->next;
  return *this;
}

template<class T>
inline Util::forward_list_const_iterator<T> Util::forward_list_const_iterator<T>::operator++(int) {
  Util::forward_list_const_iterator<T> result(*this);
  ++(*this);
  return result;
}

template<class T>
inline bool Util::forward_list_const_iterator<T>::operator==(const Util::forward_list_const_iterator<T>& o) {
  return node == o.node;
}

template<class T>
inline bool Util::forward_list_const_iterator<T>::operator!=(const Util::forward_list_const_iterator<T>& o) {
  return node != o.node;
}

#endif