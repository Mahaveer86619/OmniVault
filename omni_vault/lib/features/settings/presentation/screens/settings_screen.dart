import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_vault/common/app_constants/app_constants.dart';
import 'package:omni_vault/common/widgets/app_bar.dart';
import 'package:omni_vault/common/widgets/text_field.dart';
import 'package:omni_vault/core/theme/pallete.dart';
import 'package:omni_vault/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _searchController = TextEditingController();

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
    return BlocConsumer<SettingsBloc, SettingsState>(
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
      leading: GestureDetector(
        onTap: () {},
        child: const Icon(Icons.menu),
      ),
      title: MySearchBar(
        hintText: 'Search your settings',
        controller: _searchController,
        validator: (value) {
          return null;
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/other/menu_dark.svg',
            width: 22,
            height: 22,
            theme: SvgTheme(
              currentColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          width: 1,
          height: 38,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Pallete.greyColor.withAlpha(70),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          width: 38,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(defaultAvatarUrl),
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
