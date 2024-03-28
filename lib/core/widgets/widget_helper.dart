import 'package:rabble/core/config/export.dart';

class WidgetHelper {
  static List<Widget> intersperse(
    List<Widget> widgets,
    Widget divider, {
    bool leading = false,
    bool trailing = false,
  }) {
    if (widgets.isEmpty) return [];
    return [
      if (leading) divider,
      ...widgets
          .take(widgets.length - 1)
          .map((child) => [child, divider])
          // Flattens
          .expand((element) => element)
          .toList(),
      widgets.last,
      if (trailing) divider,
    ];
  }

  static List<Widget> widgetMap<T>(
    List<T> widgets,
    List<Widget> Function(T) mapFunc,
  ) {
    return [
      ...widgets
          .map(mapFunc)
          // Flattens
          .expand((element) => element)
          .toList(),
    ];
  }
}
