import 'package:flutter/material.dart';
import '../../features/mood/presentation/pages/home_page.dart';
import '../../features/statistics/presentation/pages/statistics_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../l10n/app_localizations.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/digital-vector.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), // 90% transparent
                  BlendMode.dstATop,
                ),
              ),
            ),
          ),
          // Content
          IndexedStack(index: _currentIndex, children: _pages),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: AppLocalizations.of(context)!.statistics,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
