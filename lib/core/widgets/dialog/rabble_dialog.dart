import 'package:markdown/markdown.dart' as md;

import 'package:rabble/config/export.dart';

enum DialogButtonTypes {
  PRIMARY,
  SECONDARY,
  SECONDARY_FILLED,
  SECONDARY_OUTLINE,
}

/// Priority
/// 1. child
/// 2. label
/// 3 icon
class RabbleDialogButton<T> {
  final String? label;
  final IconData? icon;
  final BehaviorSubject<bool>? disabledSubject;
  final Function? onPressed;
  final bool dismisses;
  final DialogButtonTypes dialogButtonType;
  final BehaviorSubject<T>? data$;

  final T? value;

  /// Dialog button [dismisses] the dialog by default.
  /// set [dismisses] to false to keep the dialog open.
  const RabbleDialogButton({
    this.label,
    this.value,
    this.icon,
    this.onPressed,
    this.data$,
    this.dismisses = true,
    this.disabledSubject,
    this.dialogButtonType = DialogButtonTypes.SECONDARY,
  });
}

abstract class RabbleDialog<T> extends StatelessWidget {
  final String? title;
  final List<RabbleDialogButton>? actions;
  final EdgeInsets margin;

  const RabbleDialog({super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 36.0, vertical: 52.0),
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: APPColors.appPrimaryColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Container(
        margin: margin,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildContent(context),
            distanceBetweenContentAndActionButtons,
            ...buildActions(context)
                .map(
                  (RabbleDialogButton action) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: createActionButton(context, action),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  SizedBox get distanceBetweenContentAndActionButtons =>
      const SizedBox(height: 24.0);

  RabbleDialogButton dismissButton({String? message}) {
    return RabbleDialogButton(
      label: message ?? 'GREAT',
      dismisses: true,
    );
  }

  Widget createActionButton(BuildContext context, RabbleDialogButton action) {
    switch (action.dialogButtonType) {
      case DialogButtonTypes.PRIMARY:
        return RabbleButton.tertiaryFilled(
          label: action.label,
          bgColor: APPColors.appWhite,
          icon: action.icon != null ? Icon(action.icon) : null,
          disabledSubject: action.disabledSubject,
          iconPosition: RabbleBaseButtonIconPosition.RIGHT,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );

      case DialogButtonTypes.SECONDARY:
        return RabbleButton.secondaryBorderless(
          label: action.label,
          icon: action.icon != null ? Icon(action.icon) : null,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
      case DialogButtonTypes.SECONDARY_FILLED:
        return RabbleButton.secondaryFilled(
          label: action.label,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
      case DialogButtonTypes.SECONDARY_OUTLINE:
        return RabbleButton.secondaryOutlined(
          label: action.label,
          disabledSubject: action.disabledSubject,
          onPressed: () {
            if (action.dismisses) Navigator.of(context).pop();
            if (action.onPressed != null) action.onPressed!();
          },
        );
    }
  }

  Widget buildContent(BuildContext context);

  MarkdownStyleSheet getMarkdownStyle(BuildContext context) =>
      MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: RabbleTheme.of(context).textTheme.bodyMedium,
        textAlign: WrapAlignment.center,
        h1: RabbleTheme.of(context)
            .textTheme
            .bodyMedium
            .copyWith(fontWeight: FontWeight.bold),
        a: RabbleTheme.of(context)
            .textTheme
            .bodyMedium
            .copyWith(color: RabbleTheme.of(context).colorTheme.secondary),
      );

  Widget buildMarkdown(
      BuildContext context, {
        required String data,
        MarkdownTapLinkCallback? onTapLink,
      }) =>
      Markdown(
        extensionSet: md.ExtensionSet.gitHubWeb,
        padding: EdgeInsets.zero,
        styleSheet: getMarkdownStyle(context),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        data: data,
        onTapLink: onTapLink,
      );

  Widget buildTitle(BuildContext context) {
    final rabbleTheme = RabbleTheme.of(context);
    return title != null && title != ''
        ? Column(
            children: [
              Text(
                title!,
                style: rabbleTheme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          )
        : const Empty();
  }

  List<RabbleDialogButton> buildActions(BuildContext context) {
    return actions ?? [];
  }

  Future<T?> show({dismissible: true}) {
    return globalBloc.showRabbleDialog(this, dismissible: dismissible);
  }
}



/// Right now very much the same as RabbleErrorDialog
class RabbleInfoDialog<T> extends RabbleDialog<T> {
  final Widget content;
  final List<RabbleDialogButton<T>>? actions;

  const RabbleInfoDialog({
    required this.content,
    this.actions = const [],
  })  : assert((content != null), "One of them should be non null"),
        super(
          actions: actions,
        );

  const RabbleInfoDialog.small({
    required this.content,
    this.actions = const [],
  })  : assert((content != null), "One of them should be non null"),
        super(
          actions: actions,
          margin: const EdgeInsets.all(36.0),
        );

  @override
  List<RabbleDialogButton> buildActions(BuildContext context);

  @override
  Widget buildContent(BuildContext context) {
    return content;
  }
}
