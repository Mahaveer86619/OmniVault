import 'package:flutter/material.dart';
import 'package:omni_vault/core/theme/pallete.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
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
    actions.add(const SizedBox(width: 12));
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        top: 12.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.0),
          color: Pallete.appBarColor,
        ),
        padding: const EdgeInsets.only(top: 2.0, left: 12.0),
        child: AppBar(
          backgroundColor: Pallete.transparentColor,
          title: title,
          actions: actions,
          leading: leading,
          leadingWidth: 18,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);
}
