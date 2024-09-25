import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_vault/common/bottom_app_bar/bloc/navigation_bloc.dart';

class MyBottomAppBar extends StatelessWidget {
  final List<NavigationDestination> items;
  final int currentIndex;

  const MyBottomAppBar({
    super.key,
    required this.items,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight + 12,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        child: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          destinations: items,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            context.read<NavigationBloc>().add(NavigateTo(index: index));
          },
        ),
      ),
    );
  }
}
