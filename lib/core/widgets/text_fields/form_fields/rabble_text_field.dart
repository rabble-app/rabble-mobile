import 'package:rabble/core/config/export.dart';

class RabbleTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final bool? enabled;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;

  //Behavioural
  final FormFieldValidator<String>? validator;
  final Function(String?)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final Function()? onTap;
  //Decoration
  final String? errorText;
  final TextStyle? errorTextStyle;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onSuffixIconTap;
  final VoidCallback? onPrefixIconTap;
  final TextAlign textAlign;

  final bool isDense;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool readOnly;
  final AutovalidateMode autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final FloatingLabelBehavior floatingLabelBehavior;
  final TextStyle? labelTextStyle;
  final String? helpText;

  const RabbleTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.controller,
    this.initialValue,
    this.errorText,
    this.errorTextStyle,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.focusNode,
    this.suffixIcon,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.onSuffixIconTap,
    this.textAlign = TextAlign.start,
    this.isDense = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.readOnly = false,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.labelTextStyle,
    this.helpText,

    /// Added auto validate with default [AutovalidateMode.disabled] because
    /// it was being used previously,
    this.autoValidateMode = AutovalidateMode.disabled,

    /// Added inputFormatters, if someone wants to set otherwise will be null
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<RabbleTextField> createState() => _RabbleTextFieldState();
}

class _RabbleTextFieldState extends State<RabbleTextField> {
  late final FocusNode focusNode;
  late final BehaviorSubject<bool> _isFocused$;
  @override
  void initState() {
    super.initState();
    _isFocused$ = BehaviorSubject<bool>.seeded(false);
    focusNode = widget.focusNode ?? FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _isFocused$.add(true);
      } else {
        _isFocused$.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rabbleTheme = RabbleTheme.of(context);
    return BehaviorSubjectBuilder<bool>(
      subject: _isFocused$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Empty();
        final isFocused = snapshot.data ?? false;
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            readOnly: widget.readOnly,
            focusNode: focusNode,
            enabled: widget.enabled ?? true,
            obscureText: widget.obscureText,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign,
            autofocus: false,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            onTap: widget.onTap,
            decoration: InputDecoration(
              isDense: widget.isDense,
              hintText: this.widget.hintText ?? this.widget.labelText,
              labelText:
                  widget.floatingLabelBehavior != FloatingLabelBehavior.never
                      ? this.widget.labelText
                      : null,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      splashRadius: 0.3,
                      icon: Icon(
                        widget.suffixIcon,
                        color: isFocused
                            ? rabbleTheme.colorTheme.buttonPrimary
                            : Colors.white,
                      ),
                      onPressed: widget.onSuffixIconTap,
                    )
                  : null,
              prefixIcon: widget.prefixIcon != null
                  ? IconButton(
                      splashRadius: 0.3,
                      icon: Icon(
                        widget.prefixIcon,
                        color: isFocused
                            ? rabbleTheme.colorTheme.buttonPrimary
                            : Colors.white,
                      ),
                      onPressed: widget.onPrefixIconTap,
                    )
                  : null,
              fillColor: isFocused
                  ? rabbleTheme.colorTheme.buttonPrimary.withOpacity(0.1)
                  : rabbleTheme.colorTheme.tertiary,
              filled: true,
              errorText: widget.errorText,
              errorStyle: widget.errorTextStyle,
              counterText: '',
              floatingLabelBehavior: widget.floatingLabelBehavior,
            ),
            style: rabbleTheme.textTheme.bodySmall,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
          ),
        );
      },
    );
  }
}
