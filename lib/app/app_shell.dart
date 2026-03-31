import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/chat_page.dart';
import '../features/superchat/super_chat_page.dart';
import '../features/membership/membership_page.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/viewers/viewer_search_page.dart';
import '../features/settings/settings_page.dart';
import '../l10n/app_localizations.dart';

/// Fully responsive shell:
/// - Desktop (>=600): NavigationRail with collapse/expand toggle
///   - Collapsed: icon-only buttons
///   - Expanded: icons + text labels
/// - Mobile (<600): Bottom NavigationBar
class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 600;
    final l = AppLocalizations.of(context)!;

    final destinations = [
      NavigationRailDestination(
        icon: const Icon(Icons.chat_outlined),
        selectedIcon: const Icon(Icons.chat),
        label: Text(l.chatTab),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.monetization_on_outlined),
        selectedIcon: const Icon(Icons.monetization_on),
        label: Text(l.superChatTab),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.card_membership_outlined),
        selectedIcon: const Icon(Icons.card_membership),
        label: Text(l.membershipTab),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.dashboard_outlined),
        selectedIcon: const Icon(Icons.dashboard),
        label: Text(l.dashboardTab),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.people_outlined),
        selectedIcon: const Icon(Icons.people),
        label: Text(l.viewerSearchTab),
      ),
      NavigationRailDestination(
        icon: const Icon(Icons.settings_outlined),
        selectedIcon: const Icon(Icons.settings),
        label: Text(l.settingsTab),
      ),
    ];

    return Scaffold(
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: navigationShell.currentIndex,
                  onDestinationSelected: (index) =>
                      navigationShell.goBranch(index),
                  labelType: NavigationRailLabelType.all,
                  minWidth: 56,
                  destinations: destinations,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: navigationShell),
              ],
            )
          : navigationShell,
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) =>
                  navigationShell.goBranch(index),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.chat_outlined),
                  selectedIcon: const Icon(Icons.chat),
                  label: l.chatTab,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.monetization_on_outlined),
                  selectedIcon: const Icon(Icons.monetization_on),
                  label: l.superChatTab,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.card_membership_outlined),
                  selectedIcon: const Icon(Icons.card_membership),
                  label: l.membershipTab,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: const Icon(Icons.dashboard),
                  label: l.dashboardTab,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.people_outlined),
                  selectedIcon: const Icon(Icons.people),
                  label: l.viewerSearchTab,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: l.settingsTab,
                ),
              ],
            ),
    );
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/chat',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/superchat',
              builder: (context, state) => const SuperChatPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/membership',
              builder: (context, state) => const MembershipPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/viewers',
              builder: (context, state) => const ViewerSearchPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
