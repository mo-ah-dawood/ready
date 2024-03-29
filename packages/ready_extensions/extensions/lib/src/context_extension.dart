import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// When you are in sliver AppBar you may want to get current percent
  /// 0.0 -> Expanded
  /// 1.0 -> Collapsed to toolbar
  double get appBarExpansionPercent {
    final settings =
        dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    assert(settings != null);
    if (settings != null) {
      final deltaExtent = settings.maxExtent - settings.minExtent;

      return (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
          .clamp(0.0, 1.0);
    }
    return 0;
  }

  /// Get [FlexibleSpaceBarSettings]
  FlexibleSpaceBarSettings? get flexibleSpaceBarSettings {
    return dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
  }

  /// get current [ThemeData]
  ThemeData get theme => Theme.of(this);

  /// get textTheme property from text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// get bodyLarge property from text theme
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  /// get bodyMedium property from text theme
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  /// get bodySmall property from text theme
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  /// get labelLarge property from text theme
  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  /// get labelMedium property from text theme
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  /// get labelSmall property from text theme
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  /// get displayLarge property from text theme
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  /// get displayMedium property from text theme
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  /// get displaySmall property from text theme
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  /// get headlineLarge property from text theme
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  /// get headlineMedium property from text theme
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  /// get headlineSmall property from text theme
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  /// get titleLarge property from text theme
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  /// get titleMedium property from text theme
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  /// get titleSmall property from text theme
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  /// Check is current theme is dark
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Check is current theme is light

  bool get isLight => Theme.of(this).brightness == Brightness.light;

  /// Check if directionality is rtl

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  /// Check if directionality is ltr
  bool get isLtr => Directionality.of(this) == TextDirection.ltr;

  /// Get current [Locale] if exists
  Locale? get locale => Localizations.maybeLocaleOf(this);

  /// Get [ColorScheme] of current context
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get [Size] from [MediaQuery]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// get [ThemeExtension] of type [T] from current [ThemeData]
  T themeExtension<T extends ThemeExtension<T>>() =>
      Theme.of(this).extension<T>()!;
}
