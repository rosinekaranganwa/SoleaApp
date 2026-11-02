import 'dart:ui';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'signup_screen.dart';

/// Solea login screen.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);

  final _phoneController = TextEditingController(text: '780022601');
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _MeshBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleBackButton(onTap: () => Navigator.maybePop(context)),
                      const _LanguagePill(),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const _Logo(),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Log in to continue your wellness journey.',
                    style: TextStyle(fontSize: 18, color: _subtitle),
                  ),
                  const SizedBox(height: 28),

                  // Phone number or email.
                  const _FieldLabel('Phone number or email'),
                  const SizedBox(height: 10),
                  _FieldBox(
                    child: Row(
                      children: [
                        const Icon(Icons.phone_outlined,
                            color: _subtitle, size: 24),
                        const SizedBox(width: 12),
                        const Text(
                          '+250',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _ink,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: _fieldDecoration('780022601'),
                            style: _inputTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Password (active / focused state with green border).
                  const _FieldLabel('Password'),
                  const SizedBox(height: 10),
                  _FieldBox(
                    borderColor: _brandGreen,
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outline,
                            color: _subtitle, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: _fieldDecoration('Enter your password'),
                            style: _inputTextStyle,
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: _subtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Remember me / forgot password.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _RememberMe(
                        value: _rememberMe,
                        onChanged: (v) => setState(() => _rememberMe = v),
                      ),
                      _LinkText('Forgot password?', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Primary CTA.
                  _LoginButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const _OrDivider(),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'Google',
                          icon: const _GoogleGlyph(),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          label: 'Apple',
                          icon: const Icon(Icons.apple, size: 26, color: _ink),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),

                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 16, color: _subtitle),
                        ),
                        _LinkText(
                          'Sign up',
                          onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _inputTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: _ink,
  );

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(color: _subtitle, fontWeight: FontWeight.w400),
      );
}

/// Soft, blurred mesh-gradient background.
class _MeshBackground extends StatelessWidget {
  const _MeshBackground();

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
      child: Stack(
        children: const [
          _Blob(
            alignment: Alignment(-1.1, -1.0),
            color: Color(0xFF8FC08C),
            size: 420,
          ),
          _Blob(
            alignment: Alignment(1.2, -0.8),
            color: Color(0xFFEBA9C6),
            size: 460,
          ),
          _Blob(
            alignment: Alignment(-1.1, 0.5),
            color: Color(0xFFB2A2E6),
            size: 460,
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.alignment,
    required this.color,
    required this.size,
  });

  final Alignment alignment;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// Rounded-square app logo with the "S" monogram.
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: BoxDecoration(
        color: const Color(0xFFDDEAD9),
        borderRadius: BorderRadius.circular(26),
      ),
      alignment: Alignment.center,
      child: const Text(
        'S',
        style: TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.w800,
          color: _LoginScreenState._brandGreen,
        ),
      ),
    );
  }
}

/// Section label above an input field.
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: _LoginScreenState._ink,
      ),
    );
  }
}

/// Rounded container used by every input field.
class _FieldBox extends StatelessWidget {
  const _FieldBox({required this.child, this.borderColor});

  final Widget child;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.6)
            : null,
      ),
      child: child,
    );
  }
}

/// "Remember me" checkbox + label.
class _RememberMe extends StatelessWidget {
  const _RememberMe({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: value
                  ? _LoginScreenState._brandGreen
                  : Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: value
                    ? _LoginScreenState._brandGreen
                    : const Color(0xFFB7BAB3),
                width: 1.6,
              ),
            ),
            child: value
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          const Text(
            'Remember me',
            style: TextStyle(fontSize: 16, color: _LoginScreenState._ink),
          ),
        ],
      ),
    );
  }
}

/// Underlined green tappable link.
class _LinkText extends StatelessWidget {
  const _LinkText(this.text, {required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: _LoginScreenState._brandGreen,
          decoration: TextDecoration.underline,
          decorationColor: _LoginScreenState._brandGreen,
        ),
      ),
    );
  }
}

/// Circular back button.
class _CircleBackButton extends StatelessWidget {
  const _CircleBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.arrow_back_ios_new,
              size: 20, color: _LoginScreenState._ink),
        ),
      ),
    );
  }
}

/// Top-right language selector pill.
class _LanguagePill extends StatelessWidget {
  const _LanguagePill();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF6EFF2),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, size: 20, color: _LoginScreenState._ink),
              SizedBox(width: 8),
              Text(
                'EN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _LoginScreenState._ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dark primary call-to-action with trailing arrow.
class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _LoginScreenState._ink,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log in',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, size: 22),
          ],
        ),
      ),
    );
  }
}

/// "or continue with" divider.
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFCFD2CB), thickness: 1)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyle(fontSize: 15, color: _LoginScreenState._subtitle),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFCFD2CB), thickness: 1)),
      ],
    );
  }
}

/// Google / Apple social sign-in button.
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.6),
          foregroundColor: _LoginScreenState._ink,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple "G" glyph for the Google button (no asset needed).
class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(0xFF4285F4),
      ),
    );
  }
}
