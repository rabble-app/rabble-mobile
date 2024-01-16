
abstract class RabbleEnum<T> {
  final T value;

  const RabbleEnum(this.value);

  @override
  bool operator ==(dynamic other) {
    if (other is RabbleEnum<T>) {
      return value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
