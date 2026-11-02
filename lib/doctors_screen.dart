import 'package:flutter/material.dart';

import 'ask_ai_screen.dart';

/// Solea "Doctors" chat screen.
class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _darkGreen = Color(0xFF2B4A34);
  static const _subtitle = Color(0xFF5B5F66);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: _Header(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AskTabs(
                selected: 1,
                onSolea: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AskAiScreen()),
                ),
                onHistory: () {},
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                children: const [
                  _BookedCard(),
                  SizedBox(height: 16),
                  Center(child: _SharedChip()),
                  SizedBox(height: 16),
                  _DoctorBubble(
                      'Hi Rosine, I’ve read your summary. Thank you for '
                      'tracking so carefully, it really helps.'),
                  SizedBox(height: 14),
                  _DoctorBubble(
                      'Before our call, could you tell me if the pain starts '
                      'before or on the first day of bleeding?'),
                  SizedBox(height: 14),
                  _UserBubble("Usually a day before, and it’s worst on day 1."),
                  SizedBox(height: 14),
                  _FormBubble(),
                  SizedBox(height: 14),
                  _DoctorBubble(
                      'Perfect. See you at 16:30. If the pain becomes severe '
                      'before then, call 912.'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: AskInputBar(hint: 'Message Dr. Aline M....'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleButton(
          icon: Icons.arrow_back_ios_new,
          onTap: () => Navigator.maybePop(context),
        ),
        const SizedBox(width: 12),
        const _DoctorAvatar(size: 52),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr. Aline M.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: DoctorsScreen._ink,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Icon(Icons.circle, size: 9, color: DoctorsScreen._brandGreen),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Gynaecologist · online',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14, color: DoctorsScreen._subtitle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _CircleButton(icon: Icons.call_outlined, onTap: () {}),
        const SizedBox(width: 10),
        _CircleButton(icon: Icons.videocam_outlined, onTap: () {}),
      ],
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  const _DoctorAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDDD8F2),
      ),
      child: Text(
        'A',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w700,
          color: DoctorsScreen._ink,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Booked consultation card
// ---------------------------------------------------------------------------

class _BookedCard extends StatelessWidget {
  const _BookedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFBE8368), Color(0xFFD7AB92)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'VIDEO CONSULTATION · BOOKED',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Today, 16:30 · in 25 min',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.videocam, color: Colors.white, size: 28),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.videocam, size: 24),
              label: const Text('Join video call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7F1EC),
                foregroundColor: DoctorsScreen._ink,
                elevation: 0,
                textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SharedChip extends StatelessWidget {
  const _SharedChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.verified_user_outlined,
              size: 16, color: DoctorsScreen._subtitle),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'You shared your symptom summary and 6 cycles',
              style: TextStyle(fontSize: 15, color: DoctorsScreen._ink),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chat bubbles
// ---------------------------------------------------------------------------

class _DoctorBubble extends StatelessWidget {
  const _DoctorBubble(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _DoctorAvatar(size: 40),
        const SizedBox(width: 10),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.35,
                  color: DoctorsScreen._ink,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          decoration: BoxDecoration(
            color: DoctorsScreen._darkGreen,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 19,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _FormBubble extends StatelessWidget {
  const _FormBubble();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _DoctorAvatar(size: 40),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6E3D2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.assignment_turned_in_outlined,
                      size: 24, color: DoctorsScreen._brandGreen),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Pre-visit form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: DoctorsScreen._ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '3 questions · 1 min',
                        style: TextStyle(
                            fontSize: 15, color: DoctorsScreen._subtitle),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Fill in',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: DoctorsScreen._ink,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ),
      ],
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
          child: Icon(icon, size: 22, color: DoctorsScreen._ink),
        ),
      ),
    );
  }
}
