import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3, milliseconds: 725), () {
      Navigator.pushReplacementNamed(context, '/auth-gate');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildLoading(48.0),
      ),
    );
  }

  _buildLoading(double textSize) {
    return Text(
      'OmniVault',
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onBackground,
      ),
    )
        .animate()
        .fadeIn(duration: Durations.long1)
        .fadeOut(duration: Durations.long1, delay: const Duration(seconds: 3));
  }
}
