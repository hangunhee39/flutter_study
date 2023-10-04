extension ListExtension<T> on List<T> {
  void swap(int origin, int target){
    final temp = this[target];
    this[target] = this[origin];
    this[origin] = temp;
  }

  //iterable -> stream
  Stream<T> toStream() => Stream.fromIterable(this);
}