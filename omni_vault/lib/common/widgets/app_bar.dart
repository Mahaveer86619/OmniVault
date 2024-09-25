import 'package:flutter/material.dart';
import 'package:omni_vault/core/theme/pallete.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leading;

  const MyAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        color: Pallete.appBarColor,
      ),
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 8.0,
      ),
      child: AppBar(
        backgroundColor: Pallete.appBarColor,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: actions.map((child) => ActionsWrapper(child: child)).toList(),
        leading: leading,
        leadingWidth: 32,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);
}

class ActionsWrapper extends StatelessWidget {
  final Widget child;
  const ActionsWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
