import 'dart:ui';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

/// Solea sign-up screen.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Brand palette (kept consistent with the splash screen).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);

  final _nameController = TextEditingController(text: 'Rosine Karanganwa');
  final _phoneController = TextEditingController(text: '780022601');
  final _passwordController = TextEditingController(text: 'password12');

  bool _obscurePassword = true;
  bool _agreed = true;

  @override
  void dispose() {
    _nameController.dispose();
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
                  const Text(
                    'Join our sanctuary',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create your account to get started.',
                    style: TextStyle(fontSize: 18, color: _subtitle),
                  ),
                  const SizedBox(height: 28),

                  // Full name.
                  const _FieldLabel('Full name'),
                  const SizedBox(height: 10),
                  _FieldBox(
                    child: Row(
                      children: [
                        const Icon(Icons.person_outline,
                            color: _subtitle, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: _fieldDecoration('Full name'),
                            style: _inputTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Phone number or email (active / valid state with green border).
                  const _FieldLabel('Phone number or email'),
                  const SizedBox(height: 10),
                  _FieldBox(
                    borderColor: _brandGreen,
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

                  // Password.
                  const _FieldLabel('Password'),
                  const SizedBox(height: 10),
                  _FieldBox(
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outline,
                            color: _subtitle, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: _fieldDecoration('Password'),
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
                  const _PasswordStrength(filled: 3, total: 4, label: 'Strong'),
                  const SizedBox(height: 20),

                  // Terms agreement.
                  _AgreementRow(
                    value: _agreed,
                    onChanged: (v) => setState(() => _agreed = v),
                  ),
                  const SizedBox(height: 24),

                  // Primary CTA.
                  _CreateAccountButton(
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
                          'Already have an account? ',
                          style: TextStyle(fontSize: 16, color: _subtitle),
                        ),
                        _LinkText(
                          'Log in',
                          onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
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
        color: _SignupScreenState._ink,
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

/// Four-segment password strength meter with a trailing label.
class _PasswordStrength extends StatelessWidget {
  const _PasswordStrength({
    required this.filled,
    required this.total,
    required this.label,
  });

  final int filled;
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: List.generate(total, (i) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i == total - 1 ? 0 : 10),
                  height: 6,
                  decoration: BoxDecoration(
                    color: i < filled
                        ? _SignupScreenState._brandGreen
                        : Colors.white.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _SignupScreenState._brandGreen,
          ),
        ),
      ],
    );
  }
}

/// Checkbox + terms / privacy agreement line.
class _AgreementRow extends StatelessWidget {
  const _AgreementRow({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: value
                  ? _SignupScreenState._brandGreen
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: value
                    ? _SignupScreenState._brandGreen
                    : const Color(0xFFB7BAB3),
                width: 1.6,
              ),
            ),
            child: value
                ? const Icon(Icons.check, size: 18, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'I agree to the ',
                  style: TextStyle(fontSize: 16, color: _SignupScreenState._ink),
                ),
                _LinkText('Terms of Service', onTap: () {}),
                const Text(
                  ' and ',
                  style: TextStyle(fontSize: 16, color: _SignupScreenState._ink),
                ),
                _LinkText('Privacy Policy', onTap: () {}),
              ],
            ),
          ),
        ),
      ],
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
          color: _SignupScreenState._brandGreen,
          decoration: TextDecoration.underline,
          decorationColor: _SignupScreenState._brandGreen,
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
              size: 20, color: _SignupScreenState._ink),
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
              Icon(Icons.language, size: 20, color: _SignupScreenState._ink),
              SizedBox(width: 8),
              Text(
                'EN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _SignupScreenState._ink,
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
class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _SignupScreenState._ink,
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
              'Create account',
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
            style: TextStyle(fontSize: 15, color: _SignupScreenState._subtitle),
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
          foregroundColor: _SignupScreenState._ink,
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

/// Simple multi-colour "G" glyph for the Google button (no asset needed).
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
