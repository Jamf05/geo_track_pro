import 'dart:async' show unawaited;
import 'package:commons_package/common_package.dart' hide State;
import 'package:flutter/material.dart';

import '../../generated/auth_localizations.dart';

typedef LoginCallback =
    Future<void> Function({required String email, required String password});

class LoginPage extends StatefulWidget {
  final LoginCallback onLogin;
  final VoidCallback? onAuthenticated;

  const LoginPage({super.key, required this.onLogin, this.onAuthenticated});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  static const double _iconSize = 80.0;
  static const double _spacingExtraLarge = 32.0;
  static const double _spacingLarge = 24.0;
  static const double _spacingMedium = 16.0;
  static const double _spacingSmall = 8.0;
  static const double _strokeWidth = 2.0;
  static const double _progressIndicatorSize = 24.0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AuthLocalizations.of(context);
    final fonts = FontsFoundation.of(context.brightness).theme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authPageTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(_spacingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: _spacingExtraLarge),
                const Icon(
                  Icons.lock_outline,
                  size: _iconSize,
                  color: ColorsFoundation.primary,
                ),
                const SizedBox(height: _spacingLarge),
                Text(
                  l10n.loginWelcome,
                  style: fonts.title.h1B24,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: _spacingSmall),
                Text(
                  l10n.loginSubtitle,
                  style: fonts.paragraph.b2R16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: _spacingExtraLarge),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.loginEmailLabel,
                    hintText: l10n.loginEmailHint,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: _spacingMedium),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: l10n.loginPasswordLabel,
                    hintText: l10n.loginPasswordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _toggleObscurePassword,
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: _spacingLarge),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: _spacingMedium),
                    child: Text(
                      _errorMessage ?? '',
                      style: fonts.paragraph.b2R14.copyWith(
                        color: ColorsFoundation.action.negative,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () => unawaited(_onLoginPressed()),
                  child: _isLoading
                      ? const SizedBox(
                          height: _progressIndicatorSize,
                          width: _progressIndicatorSize,
                          child: CircularProgressIndicator(
                            strokeWidth: _strokeWidth,
                          ),
                        )
                      : Text(l10n.loginButton),
                ),
                const SizedBox(height: _spacingMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await widget.onLogin(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) {
        widget.onAuthenticated?.call();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AuthLocalizations.of(context).loginEmailRequired;
    }
    if (!value.contains('@')) {
      return AuthLocalizations.of(context).loginEmailInvalid;
    }

    return null;
  }

  static const int _minPasswordLength = 6;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AuthLocalizations.of(context).loginPasswordRequired;
    }
    if (value.length < _minPasswordLength) {
      return AuthLocalizations.of(context).loginPasswordMinLength;
    }

    return null;
  }
}
