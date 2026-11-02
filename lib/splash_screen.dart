import 'dart:ui';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

/// Solea onboarding / splash screen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Brand palette.
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF55615A);
  static const _bodyText = Color(0xFF5B5F66);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _MeshBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: _LanguagePill(),
                  ),
                  const Spacer(flex: 3),
                  const _Logo(),
                  const SizedBox(height: 24),
                  Text(
                    'Sōlea',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your wellness sanctuary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: _subtitle,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _PageDots(count: 3, activeIndex: 0),
                  const Spacer(flex: 4),
                  const Text(
                    'Track your cycle, eat and train for your phase, '
                    'and talk to a doctor from home.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: _bodyText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PrimaryButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SignupScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: _ink,
                      minimumSize: const Size(0, 44),
                    ),
                    child: const Text(
                      'I already have an account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
            alignment: Alignment(1.2, -0.9),
            color: Color(0xFFEBA9C6),
            size: 460,
          ),
          _Blob(
            alignment: Alignment(-1.0, 0.35),
            color: Color(0xFFB2A2E6),
            size: 440,
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
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F4),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        'S',
        style: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w800,
          color: SplashScreen._brandGreen,
        ),
      ),
    );
  }
}

/// Page indicator with an elongated active dot.
class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? SplashScreen._brandGreen
                : const Color(0xFFC3C6BF),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
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
              Icon(Icons.language, size: 20, color: SplashScreen._ink),
              SizedBox(width: 8),
              Text(
                'EN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: SplashScreen._ink,
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
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SplashScreen._ink,
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
              'Get started',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward, size: 22),
          ],
        ),
      ),
    );
  }
}
