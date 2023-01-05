import 'package:data_structures/doubly_linked_list.dart';

class Stack<T> {
  Stack({
    T? firstElement,
  }) {
    if (firstElement != null) {
      push(firstElement);
    }
  }

  final DoublyLinkedList<T> _list = DoublyLinkedList<T>();

  int get size => _list.size;

  bool get isEmpty => size == 0;

  void push(T element) {
    _list.add(element);
  }

  T pop() {
    _throwIfEmpty();
    return _list.removeLast();
  }

  T peek() {
    _throwIfEmpty();
    return _list.peekLast();
  }

  // TODO: Implement iterator

  void _throwIfEmpty() {
    if (isEmpty) {
      throw RangeError("Stack is empty");
    }
  }
}
