import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';
import '../domain/entities/enums.dart';

class LibraryStatusPill extends StatelessWidget {
  const LibraryStatusPill({super.key, required this.status, this.dense = false});

  final LibraryStatus status;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final scena = context.scenaColors;
    final (background, foreground) = switch (status) {
      LibraryStatus.toWatch => (
          scheme.secondaryContainer,
          scheme.onSecondaryContainer,
        ),
      LibraryStatus.inProgress => (
          scheme.primaryContainer,
          scheme.onPrimaryContainer,
        ),
      LibraryStatus.paused => (
          scheme.tertiaryContainer,
          scheme.onTertiaryContainer,
        ),
      LibraryStatus.completed => (
          scena.success.withValues(alpha: 0.16),
          scena.success,
        ),
      LibraryStatus.abandoned => (
          scheme.errorContainer.withValues(alpha: 0.7),
          scheme.onErrorContainer,
        ),
    };
    return _Pill(
      label: status.label,
      background: background,
      foreground: foreground,
      dense: dense,
      icon: switch (status) {
        LibraryStatus.toWatch => Icons.bookmark_outline_rounded,
        LibraryStatus.inProgress => Icons.play_arrow_rounded,
        LibraryStatus.paused => Icons.pause_rounded,
        LibraryStatus.completed => Icons.check_rounded,
        LibraryStatus.abandoned => Icons.close_rounded,
      },
    );
  }
}

class SuggestionStatusPill extends StatelessWidget {
  const SuggestionStatusPill({super.key, required this.status});

  final SuggestionStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final scena = context.scenaColors;
    final (background, foreground, icon) = switch (status) {
      SuggestionStatus.inLibrary => (
          scheme.surfaceContainerHigh,
          scheme.onSurfaceVariant,
          Icons.bookmark_outline_rounded,
        ),
      SuggestionStatus.alreadyStarted => (
          scheme.primaryContainer,
          scheme.onPrimaryContainer,
          Icons.play_circle_outline_rounded,
        ),
      SuggestionStatus.newTitle => (
          scena.gold.withValues(alpha: 0.18),
          scena.gold,
          Icons.auto_awesome_rounded,
        ),
      SuggestionStatus.tooLong => (
          scena.warning.withValues(alpha: 0.16),
          scena.warning,
          Icons.schedule_rounded,
        ),
      SuggestionStatus.unknownDuration => (
          scheme.surfaceContainerHigh,
          scheme.onSurfaceVariant,
          Icons.help_outline_rounded,
        ),
    };
    return _Pill(
      label: status.label,
      background: background,
      foreground: foreground,
      icon: icon,
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
    required this.icon,
    this.dense = false,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData icon;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 10,
        vertical: dense ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: dense ? 12 : 14, color: foreground),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
