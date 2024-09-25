
import 'package:flutter/material.dart';
import 'package:omni_vault/common/auth_gate/auth_gate.dart';
import 'package:omni_vault/common/widgets/splash_screen.dart';

final routes = <String, WidgetBuilder>{
  //* Auth Gate & Splash Screen
  '/': (context) => const SplashScreen(),
  '/auth-gate': (context) => const AuthGate(),

  // //* Home Routes
  // '/profile': (context) => const ProfileScreen(),

  // //* Videos Routes
  // '/videos/add': (context) => const AddVideosScreen(),
  // '/videos/play': (context) => const VideoPlayerScreen(),
};
