class DoublyLinkedList<T> {
  int _size = 0;
  _Node<T>? _head;
  _Node<T>? _tail;

  int get size => _size;
  bool get isEmpty => size == 0;

  // Empty List O(n)
  void clear() {
    _Node<T>? traverser = _head;
    while (traverser != null) {
      _Node<T>? next = traverser.next;
      // In the case of Dart, garbage collector will take care of
      // the node's data as it is not going to be referenced anywhere anymore.
      traverser.prev = traverser.next = null;
      traverser = next;
    }
    _head = _tail = traverser = null;
    _size = 0;
  }

  // Add an element to the tail of the linked list, 0(1)
  void add(T elem) {
    addLast(elem);
  }

  // Add an element to the beginning of the linked list, 0(1)
  void addFirst(T elem) {
    if (isEmpty) {
      _head = _tail = _Node<T>(elem, null, null);
    } else {
      // As it is not empty, we already know the head node isn't going to be null
      _head!.prev = _Node<T>(elem, null, _head);
      // The previous of the past head, is the new head then
      _head = _head!.prev;
    }
    ++_size;
  }

  // Add a node to the tail of the linked list, 0(1)
  void addLast(T elem) {
    if (isEmpty) {
      _head = _tail = _Node<T>(elem, null, null);
    } else {
      // As it is not empty, we already know the tail node isn't going to be null
      _tail!.next = _Node<T>(elem, _tail, null);
      // The following of the past tail, is the new tail then
      _tail = _tail!.next;
    }
    ++_size;
  }

  // Check the value of the first node if exists, O(1)
  T peekFirst() {
    _throwIfEmpty();
    return _head!.data;
  }

  T peekLast() {
    _throwIfEmpty();
    return _tail!.data;
  }

  // Remove the first value at the head of the linked list, O(1)
  T removeFirst() {
    // Can't remove data from empty list
    _throwIfEmpty();

    // Extract the data at the head and move
    // the head pointer forwards one node
    T data = _head!.data;
    _head = _head!.next;
    --_size;

    // If the list is empty set tail as null
    if (isEmpty) {
      _tail = null;
    } else {
      // Do a memory clean of the previous node
      // (makes no sense to have a previous node in the head)
      _head!.prev = null;
    }

    // Return data
    return data;
  }

  // Remove the last value at the tail of the linked list, O(1)

  T removeLast() {
    // Can't remove data from empty list
    _throwIfEmpty();

    // Extract the data at the tail and move
    // the tail pointer backwards one node
    T data = _tail!.data;
    _tail = _tail!.prev;
    --_size;

    // If the list is empty set head as null
    if (isEmpty) {
      _head = null;
    } else {
      // Do a memory clean of the previous node
      // (makes no sense to have a following node in the tail)
      _tail!.next = null;
    }

    // Return data
    return data;
  }

  // Remove an arbitrary node from the linked list, O(1)
  T _remove(_Node<T> node) {
    // If the node to remove is somewhere either at the
    // head or the tail handle those independently

    // At head
    if (node.prev == null) {
      return removeFirst();
    }

    // At tail
    if (node.next == null) {
      return removeLast();
    }

    // Make the pointers of adjacent nodes skip over 'node'
    // (We already ensured node is not the head or tail)
    node.next!.prev = node.prev;
    node.prev!.next = node.next;

    // Temporary store the data we want to return
    T data = node.data;

    // Memory cleanup
    node.prev = node.next = null;
    --_size;

    // Return data at the node we just removed
    return data;
  }

  // Remove a node at a particular index, O(n)
  T removeAt(int index) {
    if (index < 0 || index >= size) {
      throw RangeError("Index $index is out of bounds");
    }

    int i;
    _Node<T>? traverser;

    // Search from the front of the list
    if (index < size / 2) {
      traverser = _head;
      for (i = 0; i != index; i++) {
        // No need to catch null value as we already did that at the start
        traverser = traverser!.next;
      }
    } else {
      traverser = _tail;
      for (i = size - 1; i != index; --i) {
        // No need to catch null value as we already did that at the start
        traverser = traverser!.prev;
      }
    }
    // Node can't be null as we already catch that at the start
    return _remove(traverser!);
  }

  // Remove particular value, O(n)
  bool remove(Object? obj) {
    // Support searching for null
    for (_Node<T>? traverser = _head; traverser != null; traverser.next) {
      if (traverser.data == obj) {
        _remove(traverser);
        return true;
      }
    }
    return false;
  }

  int indexOf(Object? obj) {
    int index = 0;

    for (_Node<T>? traverser = _head;
        traverser != null;
        traverser = traverser.next, index++) {
      if (traverser.data == obj) {
        return index;
      }
    }
    return -1;
  }

  bool contains(Object? obj) => indexOf(obj) != -1;

  // Check if this is the same
  // Iterator<T?> iterator() {
  //   return HasNextIterator();
  // }

  @override
  String toString() {
    final buffer = StringBuffer()..write('[');
    _Node<T>? traverser = _head;
    while (traverser != null) {
      buffer.write('${traverser.data}, ');
      traverser = traverser.next;
    }
    buffer.write(']');
    return buffer.toString();
  }

  void _throwIfEmpty() {
    if (isEmpty) {
      throw RangeError('Empty list');
    }
  }
}

class _Node<T> {
  _Node(this.data, this.prev, this.next);

  T data;
  _Node<T>? prev;
  _Node<T>? next;

  @override
  String toString() {
    return data.toString();
  }
}
