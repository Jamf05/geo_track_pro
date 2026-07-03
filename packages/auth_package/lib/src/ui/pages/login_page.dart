import 'package:commons_package/common_package.dart' hide State;
import 'package:flutter/material.dart';

import '../../generated/auth_localizations.dart';

typedef LoginCallback = Future<void> Function({
  required String email,
  required String password,
});

class LoginPage extends StatefulWidget {
  final LoginCallback onLogin;
  final VoidCallback? onAuthenticated;

  const LoginPage({
    super.key,
    required this.onLogin,
    this.onAuthenticated,
  });

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AuthLocalizations.of(context);
    final fonts = FontsFoundation.of(Brightness.light);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.authPageTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: ColorsFoundation.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.loginWelcome,
                  style: fonts.title.h1B24,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.loginSubtitle,
                  style: fonts.paragraph.b2R16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.loginEmailLabel,
                    hintText: l10n.loginEmailHint,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.loginEmailRequired;
                    }
                    if (!value.contains('@')) {
                      return l10n.loginEmailInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.loginPasswordRequired;
                    }
                    if (value.length < 6) {
                      return l10n.loginPasswordMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage!,
                      style: FontsFoundation.of(Brightness.light)
                          .paragraph
                          .b2R14
                          .copyWith(
                            color: ColorsFoundation.action.negative,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _onLogin,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.loginButton),
                ),
                const SizedBox(height: 16),
                _buildMockUsersInfo(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMockUsersInfo(AuthLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.loginTestUsers,
              style: FontsFoundation.of(Brightness.light).subtitle.h2Sb14,
            ),
            const Divider(),
            _mockUserTile('admin@example.com', 'admin123'),
            _mockUserTile('user@example.com', 'user123'),
            _mockUserTile('test@example.com', 'test123'),
            const Divider(),
            Text(
              l10n.loginSimulatedErrors,
              style: FontsFoundation.of(Brightness.light).subtitle.h2Sb14,
            ),
            _mockUserTile('error@example.com', l10n.loginServerError),
            _mockUserTile('wrong@example.com', l10n.loginInvalidCredentials),
          ],
        ),
      ),
    );
  }

  Widget _mockUserTile(String email, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$email — $description',
        style: FontsFoundation.of(Brightness.light).paragraph.b2R12,
      ),
    );
  }
}
