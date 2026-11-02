import 'package:flutter/material.dart';

/// Solea voice input ("Listening…") screen.
class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _darkGreen = Color(0xFF2B4A34);
  static const _subtitle = Color(0xFF5B5F66);

  static const _languages = ['English', 'Français', 'Kinyarwanda'];

  // Static waveform heights (no animation to keep it simple).
  static const _bars = [
    14.0, 22.0, 34.0, 26.0, 44.0, 30.0, 52.0, 40.0, 64.0, 48.0, 70.0,
    54.0, 60.0, 42.0, 50.0, 34.0, 44.0, 28.0, 36.0, 22.0, 26.0, 16.0,
  ];

  String _language = 'Kinyarwanda';
  bool _muted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.lock_outline, size: 18, color: _subtitle),
                      SizedBox(width: 8),
                      Text(
                        'Voice is not stored',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _subtitle,
                        ),
                      ),
                    ],
                  ),
                  _CircleButton(
                    icon: Icons.close,
                    onTap: () => Navigator.maybePop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _languages.map((lang) {
                    final selected = lang == _language;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: _LanguageChip(
                        label: lang,
                        selected: selected,
                        onTap: () => setState(() => _language = lang),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(flex: 2),
              const _VoiceOrb(),
              const SizedBox(height: 40),
              const Text(
                'Listening...',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 28),
              _Waveform(bars: _bars),
              const Spacer(),
              const _TranscriptCard(),
              const Spacer(flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _RoundControl(
                    icon: _muted ? Icons.mic_off : Icons.mic_none,
                    background: Colors.white,
                    iconColor: _ink,
                    size: 64,
                    onTap: () => setState(() => _muted = !_muted),
                  ),
                  _RoundControl(
                    icon: Icons.close,
                    background: const Color(0xFFC25C72),
                    iconColor: Colors.white,
                    size: 76,
                    onTap: () => Navigator.maybePop(context),
                  ),
                  _RoundControl(
                    icon: Icons.keyboard_outlined,
                    background: Colors.white,
                    iconColor: _ink,
                    size: 64,
                    onTap: () => Navigator.maybePop(context),
                  ),
                ],
              ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TranscriptCard extends StatelessWidget {
  const _TranscriptCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'YOU SAID',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: _VoiceScreenState._ink,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '"Mfite ububabare bwinshi mu nda iyo ndi mu mihango..."',
            style: TextStyle(
                fontSize: 22, height: 1.35, color: _VoiceScreenState._ink),
          ),
          SizedBox(height: 12),
          Text(
            '"I have a lot of stomach pain during my period..."',
            style: TextStyle(
                fontSize: 17, color: _VoiceScreenState._subtitle),
          ),
        ],
      ),
    );
  }
}

/// Green 3D-looking orb with a soft glow.
class _VoiceOrb extends StatelessWidget {
  const _VoiceOrb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 215,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.4),
          radius: 0.95,
          colors: [
            Color(0xFFD3E6CC),
            Color(0xFF7FA878),
            Color(0xFF3E6B46),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: _VoiceScreenState._brandGreen.withValues(alpha: 0.35),
            blurRadius: 70,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform({required this.bars});

  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: bars.map((h) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 7,
            height: h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6FA06A), Color(0xFF2B4A34)],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _VoiceScreenState._darkGreen : Colors.white,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : _VoiceScreenState._ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _RoundControl extends StatelessWidget {
  const _RoundControl({
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.size,
    required this.onTap,
  });

  final IconData icon;
  final Color background;
  final Color iconColor;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, size: size * 0.4, color: iconColor),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, size: 22, color: _VoiceScreenState._ink),
        ),
      ),
    );
  }
}
