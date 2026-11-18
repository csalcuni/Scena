import 'package:material_ui/material_ui.dart';

abstract final class AppTheme {
  static const Color _gold = Color(0xFFB98918);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _gold,
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF6C4F00),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFF8E3A3),
      onPrimaryContainer: const Color(0xFF231A00),
      secondary: const Color(0xFF4A5E8A),
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFDCE4FF),
      onSecondaryContainer: const Color(0xFF021A42),
      tertiary: const Color(0xFF8A4B3C),
      surface: const Color(0xFFFCFAF5),
      onSurface: const Color(0xFF1C1B18),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF7F3EA),
      surfaceContainer: const Color(0xFFF1ECE1),
      surfaceContainerHigh: const Color(0xFFEAE4D8),
      outline: const Color(0xFF7A7468),
      outlineVariant: const Color(0xFFD6D0C2),
    );
    return _build(scheme, const ScenaColors(
      gold: Color(0xFF9A7416),
      glow: Color(0xFFE8C96C),
      success: Color(0xFF246B45),
      warning: Color(0xFF8A5B00),
      posterFallback: Color(0xFFE9E0CE),
    ));
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _gold,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFFF0C75E),
      onPrimary: const Color(0xFF3D2E00),
      primaryContainer: const Color(0xFF5A4500),
      onPrimaryContainer: const Color(0xFFFFE9A8),
      secondary: const Color(0xFFB7C9F5),
      onSecondary: const Color(0xFF1C2E53),
      tertiary: const Color(0xFFFFB4A3),
      surface: const Color(0xFF121419),
      onSurface: const Color(0xFFEAE6DC),
      surfaceContainerLowest: const Color(0xFF0B0D11),
      surfaceContainerLow: const Color(0xFF171A20),
      surfaceContainer: const Color(0xFF1C2027),
      surfaceContainerHigh: const Color(0xFF252A32),
      outline: const Color(0xFF958F82),
      outlineVariant: const Color(0xFF3A3F47),
    );
    return _build(scheme, const ScenaColors(
      gold: Color(0xFFEAC35D),
      glow: Color(0xFFF8DE93),
      success: Color(0xFF85D6A8),
      warning: Color(0xFFF3C96B),
      posterFallback: Color(0xFF252A32),
    ));
  }

  static ThemeData _build(ColorScheme scheme, ScenaColors scenaColors) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'DMSans',
      visualDensity: VisualDensity.standard,
    );
    final textTheme = base.textTheme
        .apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
          fontFamily: 'DMSans',
        )
        .copyWith(
          displayLarge: base.textTheme.displayLarge?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
            letterSpacing: -1.4,
          ),
          displayMedium: base.textTheme.displayMedium?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
          ),
          displaySmall: base.textTheme.displaySmall?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
          ),
          headlineLarge: base.textTheme.headlineLarge?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
          ),
          headlineMedium: base.textTheme.headlineMedium?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.3,
          ),
          headlineSmall: base.textTheme.headlineSmall?.copyWith(
            fontFamily: 'Fraunces',
            fontWeight: FontWeight.w600,
          ),
          titleLarge: base.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
          titleMedium: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.45),
          bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.4),
          labelLarge: base.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1,
          ),
        );

    return base.copyWith(
      textTheme: textTheme,
      extensions: [scenaColors],
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.55)),
        ),
      ),
      chipTheme: ChipThemeData(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        side: BorderSide(color: scheme.outlineVariant),
        selectedColor: scheme.primaryContainer,
        checkmarkColor: scheme.onPrimaryContainer,
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle: textTheme.labelLarge,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: BorderSide(color: scheme.outlineVariant),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 44),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: scheme.surfaceContainerLow,
        indicatorColor: scheme.primaryContainer,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        selectedIconTheme: IconThemeData(color: scheme.onPrimaryContainer),
        selectedLabelTextStyle: textTheme.labelLarge,
        unselectedLabelTextStyle: textTheme.labelMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.6),
        thickness: 1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      focusColor: scheme.primary.withValues(alpha: 0.18),
    );
  }
}

@immutable
class ScenaColors extends ThemeExtension<ScenaColors> {
  const ScenaColors({
    required this.gold,
    required this.glow,
    required this.success,
    required this.warning,
    required this.posterFallback,
  });

  final Color gold;
  final Color glow;
  final Color success;
  final Color warning;
  final Color posterFallback;

  @override
  ScenaColors copyWith({
    Color? gold,
    Color? glow,
    Color? success,
    Color? warning,
    Color? posterFallback,
  }) {
    return ScenaColors(
      gold: gold ?? this.gold,
      glow: glow ?? this.glow,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      posterFallback: posterFallback ?? this.posterFallback,
    );
  }

  @override
  ScenaColors lerp(ScenaColors? other, double t) {
    if (other == null) return this;
    return ScenaColors(
      gold: Color.lerp(gold, other.gold, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      posterFallback: Color.lerp(posterFallback, other.posterFallback, t)!,
    );
  }
}

extension ScenaThemeContext on BuildContext {
  ScenaColors get scenaColors =>
      Theme.of(this).extension<ScenaColors>() ??
      const ScenaColors(
        gold: Color(0xFF9A7416),
        glow: Color(0xFFE8C96C),
        success: Color(0xFF246B45),
        warning: Color(0xFF8A5B00),
        posterFallback: Color(0xFFE9E0CE),
      );
}
