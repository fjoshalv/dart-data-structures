import 'package:data_structures/doubly_linked_list.dart';

class Queue<T> {
  final _list = DoublyLinkedList<T>();
  Queue({T? firstElement}) {
    if (firstElement != null) {
      offer(firstElement);
    }
  }

  int get size => _list.size;

  bool get isEmpty => size == 0;

  /// Returns last element in the queue
  T peek() {
    _throwIfEmpty();
    return _list.peekFirst();
  }

  /// Remove last element in the queue
  T poll() {
    _throwIfEmpty();
    return _list.removeFirst();
  }

  void offer(T element) {
    _list.addLast(element);
  }

  // TODO: Add iterator

  void _throwIfEmpty() {
    if (isEmpty) {
      throw RangeError('Queue is empty');
    }
  }
}
