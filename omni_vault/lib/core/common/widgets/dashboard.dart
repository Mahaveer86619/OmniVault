import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_vault/core/common/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:omni_vault/core/common/bottom_app_bar/widgets/my_bottom_app_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> pages = [
    const Placeholder(), // notes
    const Placeholder(), // tasks
    const Placeholder(), // secrets
    const Placeholder(), // voice
  ];

  BottomNavigationBarItem _createBottomNavItem({
    required String assetName,
    required bool isActive,
    required String label,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetName,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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

            final List<BottomNavigationBarItem> bottomNavItems = [
              _createBottomNavItem(
                assetName: 'assets/svg/krida_home.svg',
                isActive: currentIndex == 0,
                context: context,
                label: 'Home',
              ),
              _createBottomNavItem(
                assetName: 'assets/svg/krida_teams.svg',
                isActive: currentIndex == 1,
                context: context,
                label: 'Teams',
              ),
              _createBottomNavItem(
                assetName: 'assets/svg/krida_playground.svg',
                isActive: currentIndex == 2,
                context: context,
                label: 'Playground',
              ),
              _createBottomNavItem(
                assetName: 'assets/svg/krida_videos.svg',
                isActive: currentIndex == 3,
                context: context,
                label: 'Videos',
              ),
              _createBottomNavItem(
                assetName: 'assets/svg/krida_events.svg',
                isActive: currentIndex == 4,
                context: context,
                label: 'Events',
              ),
              _createBottomNavItem(
                assetName: 'assets/svg/krida_shop.svg',
                isActive: currentIndex == 5,
                context: context,
                label: 'Shop',
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
