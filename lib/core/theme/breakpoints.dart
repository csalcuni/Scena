import 'package:flutter/widgets.dart';

/// Breakpoint Material semplificati e condivisi da shell e griglie.
abstract final class Breakpoints {
  static const double medium = 700;
  static const double expanded = 1024;
  static const double contentMaxWidth = 1240;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isCompact => screenWidth < Breakpoints.medium;
  bool get isMedium =>
      screenWidth >= Breakpoints.medium && screenWidth < Breakpoints.expanded;
  bool get isExpanded => screenWidth >= Breakpoints.expanded;

  int get gridColumns {
    if (isExpanded) return 4;
    if (isMedium) return 3;
    if (screenWidth >= 520) return 2;
    return 1;
  }

  EdgeInsets get pagePadding {
    if (isExpanded) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 32);
    }
    if (isMedium) {
      return const EdgeInsets.symmetric(horizontal: 28, vertical: 24);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  }
}
