import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_vault/common/widgets/app_bar.dart';
import 'package:omni_vault/features/secrets/presentation/bloc/secrets_bloc.dart';

class SecretsScren extends StatefulWidget {
  const SecretsScren({super.key});

  @override
  State<SecretsScren> createState() => _SecretsScrenState();
}

class _SecretsScrenState extends State<SecretsScren> {
  void _changeScreen(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool isReplacement = false,
  }) {
    if (isReplacement) {
      Navigator.pushReplacementNamed(
        context,
        routeName,
        arguments: arguments,
      );
    } else {
      Navigator.pushNamed(
        context,
        routeName,
        arguments: arguments,
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecretsBloc, SecretsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        );
      },
    );
  }

  _buildAppBar(BuildContext context) {
    return MyAppBar(
      title: 'Secrets',
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.outbox,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 6),
          // Build List of notes
        ],
      ),
    );
  }
}