import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../features/home/home_page.dart';
import '../features/library/library_page.dart';
import '../features/media/media_detail_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/search/search_page.dart';
import '../features/settings/settings_page.dart';
import '../widgets/empty_state.dart';
import '../widgets/scena_logo.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final onboardingCompleted = ref.watch(
    preferencesProvider.select(
      (value) => value.value?.onboardingCompleted ?? false,
    ),
  );

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final path = state.uri.path;
      final onOnboarding = path == '/onboarding';
      if (!onboardingCompleted && !onOnboarding) return '/onboarding';
      if (onboardingCompleted && onOnboarding) return '/';
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/library',
                name: 'library',
                builder: (context, state) => const LibraryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: 'search',
                builder: (context, state) {
                  final query = state.uri.queryParameters['q'];
                  final type = state.uri.queryParameters['type'];
                  return SearchPage(
                    initialQuery: query,
                    initialType: type,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/media/:type/:tmdbId',
        name: 'media',
        builder: (context, state) {
          return MediaDetailPage(
            typeValue: state.pathParameters['type'] ?? 'movie',
            tmdbId:
                int.tryParse(state.pathParameters['tmdbId'] ?? '') ?? 0,
          );
        },
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Pagina non trovata')),
      body: Center(
        child: ErrorView(
          title: 'Questa scena non esiste',
          message: 'Il collegamento che hai aperto non porta a nessuna pagina.',
          onRetry: () => context.go('/'),
          retryLabel: 'Torna alla home',
        ),
      ),
    ),
  );
});

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    _ShellDestination(
      label: 'Stasera',
      icon: Icons.nightlight_outlined,
      selectedIcon: Icons.nightlight_round,
    ),
    _ShellDestination(
      label: 'Libreria',
      icon: Icons.video_library_outlined,
      selectedIcon: Icons.video_library_rounded,
    ),
    _ShellDestination(
      label: 'Cerca',
      icon: Icons.search_rounded,
      selectedIcon: Icons.search_rounded,
    ),
    _ShellDestination(
      label: 'Impostazioni',
      icon: Icons.tune_rounded,
      selectedIcon: Icons.tune_rounded,
    ),
  ];

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompact = MediaQuery.sizeOf(context).width < 700;
    final isExpanded = MediaQuery.sizeOf(context).width >= 1100;
    final currentIndex = navigationShell.currentIndex;

    final body = Row(
      children: [
        if (!isCompact) ...[
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: _goBranch,
            extended: isExpanded,
            labelType: isExpanded
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.selected,
            groupAlignment: -0.65,
            leading: Padding(
              padding: EdgeInsets.fromLTRB(
                isExpanded ? 20 : 0,
                18,
                isExpanded ? 20 : 0,
                26,
              ),
              child: isExpanded
                  ? const ScenaLogo(size: 34)
                  : const ScenaLogo(size: 34, showWordmark: false),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: isExpanded
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.keyboard_command_key_rounded,
                                size: 16,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ctrl / ⌘ + K per cercare',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : Tooltip(
                          message: 'Cerca (Ctrl/⌘ + K)',
                          child: IconButton(
                            onPressed: () => _goBranch(2),
                            icon: const Icon(Icons.search_rounded),
                          ),
                        ),
                ),
              ),
            ),
            destinations: [
              for (final destination in _destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(destination.label),
                ),
            ],
          ),
          VerticalDivider(
            width: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ],
        Expanded(
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.keyK, control: true):
                  () => _goBranch(2),
              const SingleActivator(LogicalKeyboardKey.keyK, meta: true):
                  () => _goBranch(2),
            },
            child: Focus(
              autofocus: true,
              child: navigationShell,
            ),
          ),
        ),
      ],
    );

    if (!isCompact) {
      return Scaffold(body: body);
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: _goBranch,
        destinations: [
          for (final destination in _destinations)
            NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label,
            ),
        ],
      ),
    );
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
