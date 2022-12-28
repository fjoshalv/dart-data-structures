class Array<T> {
  Array() : this.capacity(16);
  Array.capacity(this.capacity)
      : assert(capacity < 0, 'Illegal Capacity: $capacity'),
        arr = List.filled(capacity, null);

  List<T?> arr;
  int length = 0; // Length user thinks array is
  int capacity = 0; // Actual array size

  int size() => length;
  bool isEmpty() => size() == 0;

  T get(int index) {
    throwIfOutOfBounds(index);
    return arr[index]!;
  }

  void set(int index, T elem) {
    throwIfOutOfBounds(index);
    arr[index] = elem;
  }

  void clear() {
    for (var i = 0; i < capacity; ++i) {
      arr[i] = null;
    }
    length = 0;
  }

  void add(T element) {
    if (length + 1 >= capacity) {
      _extendCapacity();
    }
    arr[length++] = element;
  }

  T removeAt(int indexToRemove) {
    throwIfOutOfBounds(indexToRemove);

    T data = arr[indexToRemove]!;
    List<T?> newArr = List.filled(length - 1, null);
    for (var i = 0, j = 0; i < length; i++, j++) {
      if (i == indexToRemove) {
        --j; // Skip over indexToRemove by fixing j temporarily
      } else {
        newArr[j] = arr[i];
      }
      arr = newArr;
      capacity = --length;
    }
    return data;
  }

  /// This relies on the equality of the object
  bool remove(T obj) {
    for (var i = 0; i < length; i++) {
      if (arr[i] == obj) {
        removeAt(i);
        return true;
      }
    }
    return false;
  }

  /// Returns -1 if element is not found
  int indexOf(T obj) {
    for (var i = 0; i < length; i++) {
      if (arr[i] == obj) {
        return i;
      }
    }
    return -1;
  }

  bool contains(T obj) {
    return indexOf(obj) != -1;
  }

  // Check if this is the same
  Iterable<T?> iterator() {
    return Iterable<T?>.generate(length, (i) => arr[i]);
  }

  @override
  String toString() {
    if (length == 0) {
      return "[]";
    } else {
      final buffer = StringBuffer()..write('[');
      for (var i = 0; i < length; i++) {
        buffer.write("${arr[i]}, ");
      }
      buffer.write("]");
      return buffer.toString();
    }
  }

  void _extendCapacity() {
    if (capacity == 0) {
      capacity = 1;
    } else {
      capacity *= 2;
    }

    List<T?> newArr = List.filled(capacity, null);
    for (var i = 0; i < length; ++i) {
      newArr[i] = arr[i];
    }
    arr = newArr;
  }

  void throwIfOutOfBounds(int index) {
    if (index >= length || index < 0) {
      throw ArgumentError(
        'Index: "$index" out of bounds',
        'index',
      );
    }
  }
}
