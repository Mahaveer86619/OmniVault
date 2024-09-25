import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late double _scale;

  @override
  void initState() {
    super.initState();

    _scale = 0;

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _scale = 1;
      });
    }).then((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacementNamed(context, '/auth-gate');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 1000),
            child: SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/gifs/logo_animation.gif',
                  height: 300,
                  width: 300,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          AnimatedScale(
            scale: _scale,
            duration: const Duration(milliseconds: 1000),
            child: Text(
              'krida.',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
