import 'package:rabble/core/config/export.dart';


class RabbleTheme extends InheritedWidget {
  /// Constructor for creating a [RabbleTheme]
  const RabbleTheme({
    super.key,
    required this.data,
    required super.child,
  });

  static final RabbleThemeData themeData = RabbleThemeData(
    primary: APPColors.appWhite.value,
    secondary: APPColors.appWhite.value,
    tertiary: APPColors.appWhite.value,
    textPrimary: APPColors.appWhite.value,
    textSecondary: APPColors.appWhite.value,
    fontFamily: cUrbanist,
  );

  /// Theme data
  final RabbleThemeData data;

  static ThemeData generateThemeDataFromrabbleThemeData(
    RabbleThemeData data,
  ) {
    final RabbleColor backgroundColor = data.colorTheme.primary;
    final ThemeData original = ThemeData.light();
    return ThemeData(
      fontFamily: data.fontFamily,
      brightness: data.brightness,
      canvasColor: APPColors.appPrimaryColor,
      scaffoldBackgroundColor: backgroundColor,
      dividerColor: const Color(0xffF9F8F4),
      primaryColor: original.primaryColor,
      cardColor: APPColors.appPrimaryColor,
      appBarTheme: data.appBarTheme,
      textSelectionTheme: original.textSelectionTheme
          .copyWith(cursorColor: data.colorTheme.secondary),
      textTheme: original.textTheme.copyWith(
        // Currently used for Meetup/Event title and discovery cards
        headlineLarge: data.textTheme.headingLarge,
        // I use this for card headers such as on meetup details
        headlineMedium: data.textTheme.bodyMedium,
        // Used in signup headers
        headlineSmall: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          letterSpacing: 0,
        ),

        bodySmall: data.textTheme.bodySmall
            .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
        bodyMedium: data.textTheme.bodyMedium,
      ),
      buttonTheme: original.buttonTheme.copyWith(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        // minWidth: 100,
        textTheme: ButtonTextTheme.normal,
      ),
      inputDecorationTheme: original.inputDecorationTheme.copyWith(
        contentPadding: data.padding.inputFieldPadding,
        errorMaxLines: 3,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: data.colorTheme.secondary, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: data.secondaryTextTheme.bodySmall,
        filled: true,
        fillColor: data.colorTheme.tertiary,
        iconColor: data.colorTheme.textPrimary,
        errorStyle: data.errorTextTheme.bodySmall.copyWith(
          overflow: TextOverflow.ellipsis,
        ),
        // Note careful: using fill messes up the Stream chat
        // filled: true,
        // fillColor: Colors.white,
      ),
      sliderTheme: original.sliderTheme.copyWith(
        activeTrackColor: data.colorTheme.secondary,
        inactiveTrackColor: data.colorTheme.secondary,
        trackHeight: 2,
        thumbColor: data.colorTheme.secondary,
      ),
      buttonBarTheme: const ButtonBarThemeData(
        buttonPadding: EdgeInsets.symmetric(horizontal: 15),
        layoutBehavior: ButtonBarLayoutBehavior.constrained,
      ),
      iconTheme: IconThemeData(
        color: data.colorTheme.icon,
        size: 22, //16
      ),
      snackBarTheme: original.snackBarTheme.copyWith(
        actionTextColor: const Color(0xFFe1e1e1),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF42434A),
        thickness: 1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      bottomNavigationBarTheme: original.bottomNavigationBarTheme.copyWith(
        backgroundColor: data.bottomNavigationBarTheme.backgroundColor,
        selectedIconTheme: data.bottomNavigationBarTheme.selectedIconTheme,
        unselectedIconTheme: data.bottomNavigationBarTheme.unselectedIconTheme,
      ),
    );
  }

  @override
  bool updateShouldNotify(RabbleTheme oldWidget) => data != oldWidget.data;

  /// Use this method to get the current [StreamChatThemeData] instance
  static RabbleThemeData of(BuildContext context) {
    final RabbleTheme? rabbleTheme =
        context.dependOnInheritedWidgetOfExactType<RabbleTheme>();

    assert(
      rabbleTheme != null,
      'You must have a rabbleTheme password at the top of your password tree',
    );

    return rabbleTheme!.data;
  }
}

class RabbleThemeData {
  final Brightness brightness;
  final int primary;
  final int secondary;
  final int tertiary;
  final int textPrimary;
  final int textSecondary;
  final String fontFamily;

  /// Create a theme from scratch
  RabbleThemeData({
    this.brightness = Brightness.dark,
    this.primary = 0xFF1A1B22,
    this.secondary = 0xFF1DA1F2,
    this.tertiary = 0xFF23252F,
    this.textPrimary = 0xFFFFFFFF,
    this.textSecondary = 0xFF8C8D90,
    this.fontFamily = cUrbanist,
  });

  final ThemeData original = ThemeData.light();

  final Color color = const Color(0xFF009DFF);
  late final ColorTheme colorTheme = ColorTheme(
      brightness: brightness,
      primary: RabbleColor(primary),
      secondary: RabbleColor(secondary),
      tertiary: RabbleColor(tertiary),
      textPrimary: RabbleColor(textPrimary),
      textSecondary: RabbleColor(textSecondary));

  late final RabbleTextTheme textTheme =
      RabbleTextTheme(textColor: colorTheme.textPrimary);

  late final RabbleTextTheme secondaryTextTheme =
      RabbleTextTheme(textColor: colorTheme.textSecondary);

  late final RabbleTextTheme errorTextTheme =
      RabbleTextTheme(textColor: colorTheme.error);

  late final IconThemeData primaryIconTheme =
      IconThemeData(color: colorTheme.icon);

  late final RabbleBottomNavigationBarTheme bottomNavigationBarTheme =
      RabbleBottomNavigationBarTheme(colorTheme: colorTheme);

  late final RabbleButtonTheme buttonTheme =
      RabbleButtonTheme(color: colorTheme.primary);

  late final RabbleButtonTheme secondaryButtonTheme =
      RabbleButtonTheme(color: colorTheme.buttonSecondary);

  late final ProgressIndicatorThemeData progressIndicatorThemeData =
      ProgressIndicatorThemeData(
    color: colorTheme.secondary,
    linearTrackColor: colorTheme.secondary.shade100,
  );

  //BottomSheet Theming

  // late final B

  //Material Theming
  late final AppBarTheme appBarTheme = AppBarTheme(
    //systemOverlayStyle: defaultSystemOverlayStyle,
    color: colorTheme.primary,
    centerTitle: false,
    elevation: 0,
    titleTextStyle:
        textTheme.headingMedium.copyWith(color: colorTheme.textPrimary),
    iconTheme: IconThemeData(color: colorTheme.icon, size: 22, opacity: 1),
  );

  late final RabblePaddingData padding = RabblePaddingData();
}

class ColorTheme {
  final Brightness brightness;
  final RabbleColor primary;
  final RabbleColor secondary;
  final RabbleColor tertiary;
  final RabbleColor textPrimary;
  final RabbleColor textSecondary;
  final RabbleColor icon;

  ColorTheme({
    this.brightness = Brightness.dark,
    this.primary = const RabbleColor(0xFF009444),
    this.secondary = const RabbleColor(0xFF1DA1F2),
    this.tertiary = const RabbleColor(0xFF23252F),
    this.textPrimary = const RabbleColor(0xFFFFFFFF),
    this.textSecondary = const RabbleColor(0xFF8C8D90),
    this.icon = const RabbleColor(0xFFFFFFFF),
  });

  late final RabbleColor buttonPrimary = primary;
  late final RabbleColor buttonSecondary = secondary;

  late final RabbleColor error = const RabbleColor(0xFFFF6188);
  late final RabbleColor success = const RabbleColor(0xFFBAD761);
}

class RabbleColor extends ColorSwatch<int> {
  final int value;

  const RabbleColor(this.value) : super(value, const <int, Color>{});

  Color get shade500 => withOpacity(.8);

  Color get shade400 => withOpacity(.6);

  Color get shade300 => withOpacity(.4);

  Color get shade100 => withOpacity(.2);
}

class RabblePaddingData {
  //defaults
  final EdgeInsets inputFieldPadding = const EdgeInsets.all(12);
  final EdgeInsets screenPadding =
      const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
}

class RabbleButtonTheme {
  final RabbleColor color;

  RabbleButtonTheme({required this.color});

  late final ButtonStyle outlinedButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(const Color(0xff58585B)),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return Colors.white;
      }
      return color;
    }),
    overlayColor: WidgetStateProperty.all<Color>(Colors.white),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
    ),
    side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return BorderSide(
            color: color.shade400, width: 1, style: BorderStyle.solid);
      }
      return BorderSide(color: color, width: 1, style: BorderStyle.solid);
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle filledButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return const Color(0xffE8E7EC);
      }
      return color;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle textButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle filledIconButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle outlinedIconButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return color.shade400;
      }
      return color;
    }),
    overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    side: WidgetStateProperty.resolveWith<BorderSide>((Set<WidgetState> states) {
      if (states.any(_disabledStates.contains)) {
        return BorderSide(
            color: color.shade400, width: 1, style: BorderStyle.solid);
      }
      return BorderSide(color: color, width: 1, style: BorderStyle.solid);
    }),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );

  late final ButtonStyle flatIconButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
    foregroundColor: WidgetStateProperty.all<Color>(color),
    // overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
    shape: WidgetStateProperty.all<CircleBorder>(
      const CircleBorder(),
    ),
    elevation: WidgetStateProperty.all<double>(4),
    shadowColor: WidgetStateProperty.all<Color>(Colors.black),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(8),
    ),
  );


  static const Set<WidgetState> _disabledStates = <WidgetState>{
    WidgetState.disabled,
    WidgetState.error,
  };
}

class RabbleBottomNavigationBarTheme {
  final ColorTheme colorTheme;
  final Brightness brightness;

  RabbleBottomNavigationBarTheme({
    this.brightness = Brightness.dark,
    required this.colorTheme,
  });

  late final IconThemeData selectedIconTheme =
      IconThemeData(color: colorTheme.secondary, size: 32);

  late final IconThemeData unselectedIconTheme =
      IconThemeData(color: colorTheme.tertiary, size: 28);

  late final RabbleColor backgroundColor = const RabbleColor(0xB11A1B22);

  late final BorderRadius borderRadius = BorderRadius.circular(32);
}

class RabbleTextTheme {
  final String fontFamily;
  final RabbleColor textColor;

  RabbleTextTheme({
    this.fontFamily = cUrbanist,
    required this.textColor,
  });

  late final TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.5,
    color: textColor,
  );
  late final TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -1.5,
  );

  late final TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: textColor,
  );
  late final TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: textColor,
    letterSpacing: -1,
  );
  late final TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -0.25,
  );
  late final TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
    letterSpacing: -0.25,
  );
  late final TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
  );
  late final TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: textColor,
  );
  late final TextStyle labelSmall = TextStyle(
      fontSize: 8,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      color: textColor);
  late final TextStyle labelGrayLarge = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
  late final TextStyle labelGrayMedium = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
  late final TextStyle labelGraySmall = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: APPColors.grey,
  );
}
