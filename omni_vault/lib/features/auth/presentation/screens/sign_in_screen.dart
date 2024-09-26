import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_vault/common/widgets/text_field.dart';
import 'package:omni_vault/core/helpers/extensions.dart';
import 'package:omni_vault/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:omni_vault/features/auth/presentation/widgets/submit_btn.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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

  void _onSubmit() {
    if (_formkey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            SignInEvent(
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: _buildBody(theme),
      ),
    );
  }

  _buildBody(ThemeData theme) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(theme),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildform(theme),
              ),
            ],
          ),
          const SizedBox(height: 220),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildSignInBtn(theme),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildToSignUpText(theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildHeader(ThemeData theme) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  _buildform(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Hi, Welcome back!',
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        Text(
          'Sign in to start collaborating today.',
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        // TextFields
        const SizedBox(
          height: 60,
        ),
        Form(
          key: _formkey,
          child: Column(
            children: [
              MyFormTextField(
                hintText: 'example@gmail.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'Email',
                keyboardAction: TextInputAction.next,
                validator: (val) {
                  if (!val!.isValidEmail) {
                    return 'Enter a valid email.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              MyFormTextField(
                hintText: 'password',
                controller: passwordController,
                keyboardType: TextInputType.text,
                label: 'Password',
                keyboardAction: TextInputAction.done,
                obscureText: true,
                validator: (val) {
                  if (!val!.isValidPassword) {
                    return 'Enter a valid password.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _changeScreen('/forgot-pass'),
                    child: Text(
                      'Forgot password?',
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSignInBtn(ThemeData theme) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          _changeScreen('/auth-gate', isReplacement: true);
        } else if (state is AuthError) {
          _showMessage(state.error);
        } else {
          _showMessage('Something went wrong');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SubmitBtn(
          onPressed: () {
            _onSubmit();
          },
          text: 'Sign In',
        );
      },
    );
  }

  _buildToSignUpText(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _changeScreen('/sign-up', isReplacement: true),
          child: RichText(
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                fontSize: theme.textTheme.titleMedium!.fontSize,
                color: theme.colorScheme.onBackground,
              ),
              children: [
                TextSpan(
                  text: 'Sign up',
                  style: TextStyle(
                    fontSize: theme.textTheme.titleMedium!.fontSize,
                    color: theme.colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}