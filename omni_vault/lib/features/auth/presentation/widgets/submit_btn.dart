import 'package:flutter/material.dart';
import 'package:omni_vault/core/theme/pallete.dart';

class SubmitBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const SubmitBtn({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
