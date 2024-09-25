import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_vault/common/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:omni_vault/common/bottom_app_bar/widgets/my_bottom_app_bar.dart';
import 'package:omni_vault/features/notes/presentation/screens/notes_screen.dart';
import 'package:omni_vault/features/secrets/presentation/screens/secrets_screen.dart';
import 'package:omni_vault/features/settings/presentation/screens/settings_screen.dart';
import 'package:omni_vault/features/tasks/presentation/screens/tasks_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> pages = [
    const NotesScreen(),
    const TasksScreen(),
    const SecretsScren(),
    const SettingsScreen(),
  ];

  NavigationDestination _createBottomNavItem({
    required String activeIcon,
    required String inactiveIcon,
    required bool isActive,
    required String label,
    required BuildContext context,
  }) {
    return NavigationDestination(
      icon: SvgPicture.asset(inactiveIcon),
      selectedIcon: SvgPicture.asset(activeIcon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationChanged) {
              return pages[state.index];
            }
            return pages[0];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            int currentIndex = 0;
            if (state is NavigationChanged) {
              currentIndex = state.index;
            }

            final List<NavigationDestination> bottomNavItems = [
              _createBottomNavItem(
                activeIcon: 'assets/icons/bottom_bar/selected_notes.svg',
                inactiveIcon: 'assets/icons/bottom_bar/unselected_notes.svg',
                isActive: currentIndex == 0,
                label: 'Notes',
                context: context,
              ),
              _createBottomNavItem(
                activeIcon: 'assets/icons/bottom_bar/selected_tasks.svg',
                inactiveIcon: 'assets/icons/bottom_bar/unselected_tasks.svg',
                isActive: currentIndex == 1,
                label: 'Tasks',
                context: context,
              ),
              _createBottomNavItem(
                activeIcon: 'assets/icons/bottom_bar/selected_secrets.svg',
                inactiveIcon: 'assets/icons/bottom_bar/unselected_secrets.svg',
                isActive: currentIndex == 2,
                label: 'Secrets',
                context: context,
              ),
              _createBottomNavItem(
                activeIcon: 'assets/icons/bottom_bar/selected_settings.svg',
                inactiveIcon: 'assets/icons/bottom_bar/unselected_settings.svg',
                isActive: currentIndex == 3,
                label: 'Settings',
                context: context,
              ),
            ];

            return MyBottomAppBar(
              items: bottomNavItems,
              currentIndex: currentIndex,
            );
          },
        ),
      ),
    );
  }
}
