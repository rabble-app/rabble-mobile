import 'package:rabble/core/config/export.dart';

extension BuildContextExtensions<T> on BuildContext {
  double get allWidth => MediaQuery.of(this).size.width;

  double get allHeight => MediaQuery.of(this).size.height;

  double get viewInsets => MediaQuery.of(this).viewInsets.bottom;
}
