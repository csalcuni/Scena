import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';

class ScenaLogo extends StatelessWidget {
  const ScenaLogo({
    super.key,
    this.size = 36,
    this.showWordmark = true,
    this.subtitle,
  });

  final double size;
  final bool showWordmark;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mark = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: context.scenaColors.gold,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: context.scenaColors.glow.withValues(alpha: 0.45),
            blurRadius: size * 0.42,
            offset: Offset(0, size * 0.1),
          ),
        ],
      ),
      child: Icon(
        Icons.local_movies_rounded,
        size: size * 0.62,
        color: theme.colorScheme.surface,
      ),
    );

    if (!showWordmark) return mark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        SizedBox(width: size * 0.32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Scena',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontFamily: 'Fraunces',
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 3),
              Text(
                subtitle!,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
