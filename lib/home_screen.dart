import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

/// Solea home screen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);

  static const _moods = [
    'Happy',
    'Energetic',
    'Calm',
    'Tired',
    'Cramps',
    'Strong',
    'Motivated',
    'Headache',
  ];

  String _selectedMood = 'Tired';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        children: [
          const _MeshBackground(),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Header(),
                  const SizedBox(height: 20),
                  const _WeekStrip(),
                  const SizedBox(height: 24),
                  const _GoalCard(),
                  const SizedBox(height: 28),

                  const _SectionTitle('How I feel today'),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _moods.map((mood) {
                      return _MoodChip(
                        label: mood,
                        selected: mood == _selectedMood,
                        onTap: () => setState(() => _selectedMood = mood),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  const _DoctorCard(),
                  const SizedBox(height: 28),

                  const _SectionTitle('Recommended for today'),
                  const SizedBox(height: 16),
                  const _ChatRecommendationCard(),
                  const SizedBox(height: 20),

                  const _TimelineTile(
                    done: true,
                    isFirst: true,
                    child: _TaskContent(
                      meta: '07:30 · 15 min',
                      title: 'Restorative stretch',
                      strikethrough: true,
                      note: 'You said: stiff after bad sleep',
                    ),
                  ),
                  _TimelineTile(
                    done: false,
                    child: const _WaterTaskContent(),
                  ),
                  const _TimelineTile(
                    done: false,
                    isLast: true,
                    child: _TaskContent(
                      meta: '21:30 · 5 min',
                      title: 'Wind-down breathing',
                      note: 'You said: poor sleep',
                    ),
                  ),
                  const SizedBox(height: 8),

                  const _TellSoleaButton(),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.verified_user_outlined,
                          size: 18, color: _subtitle),
                      SizedBox(width: 8),
                      Text(
                        'Updates after every chat · Not a diagnosis',
                        style: TextStyle(fontSize: 14, color: _subtitle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _BottomNav(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Background
// ---------------------------------------------------------------------------

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
              size: 420),
          _Blob(
              alignment: Alignment(1.2, -0.9),
              color: Color(0xFFEBA9C6),
              size: 460),
          _Blob(
              alignment: Alignment(-1.2, 0.2),
              color: Color(0xFFB2A2E6),
              size: 440),
          _Blob(
              alignment: Alignment(1.1, 0.9),
              color: Color(0xFFF0D98A),
              size: 460),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob(
      {required this.alignment, required this.color, required this.size});

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
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header + calendar
// ---------------------------------------------------------------------------

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Thursday, 12 Feb · Cycle day 14',
                style: TextStyle(fontSize: 15, color: _HomeScreenState._subtitle),
              ),
              SizedBox(height: 4),
              Text(
                'Hello, Rosine',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: _HomeScreenState._ink,
                ),
              ),
            ],
          ),
        ),
        _CircleIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: () {},
        ),
        const SizedBox(width: 12),
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9FC79A), Color(0xFFE7A9C5)],
            ),
          ),
          child: const Text(
            'R',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.6),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, size: 24, color: _HomeScreenState._ink),
        ),
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  @override
  Widget build(BuildContext context) {
    const days = <_Day>[
      _Day('M', 9, state: _DayState.past),
      _Day('T', 10, state: _DayState.past),
      _Day('W', 11, state: _DayState.past),
      _Day('T', 12, state: _DayState.selected),
      _Day('F', 13, state: _DayState.future),
      _Day('S', 14, state: _DayState.future),
      _Day('S', 15, state: _DayState.future),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) => _DayItem(day: d)).toList(),
    );
  }
}

enum _DayState { past, selected, future }

class _Day {
  const _Day(this.label, this.date, {required this.state});

  final String label;
  final int date;
  final _DayState state;
}

class _DayItem extends StatelessWidget {
  const _DayItem({required this.day});

  final _Day day;

  @override
  Widget build(BuildContext context) {
    final isSelected = day.state == _DayState.selected;
    return Column(
      children: [
        Text(
          day.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? _HomeScreenState._ink
                : _HomeScreenState._subtitle,
          ),
        ),
        const SizedBox(height: 10),
        _buildCircle(),
        const SizedBox(height: 6),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: day.state == _DayState.past
                ? _HomeScreenState._brandGreen
                : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _buildCircle() {
    final number = Text(
      '${day.date}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: day.state == _DayState.selected
            ? Colors.white
            : _HomeScreenState._ink,
      ),
    );

    switch (day.state) {
      case _DayState.selected:
        return Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: _HomeScreenState._ink,
          ),
          child: number,
        );
      case _DayState.past:
        return Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.5),
            border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
          ),
          child: number,
        );
      case _DayState.future:
        return _DashedBorder(
          radius: 24,
          color: const Color(0xFFA9ADA4),
          child: SizedBox(
            width: 48,
            height: 48,
            child: Center(child: number),
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Goal card with segmented progress ring
// ---------------------------------------------------------------------------

class _GoalCard extends StatelessWidget {
  const _GoalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: CustomPaint(
              painter: _SegmentedRingPainter(progress: 0.8),
              child: const Center(
                child: Text(
                  '80%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _HomeScreenState._ink,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Weekly goal progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _HomeScreenState._ink,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "8 of 10 habits done. You're doing amazing.",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    color: _HomeScreenState._subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedRingPainter extends CustomPainter {
  _SegmentedRingPainter({required this.progress});

  final double progress;
  static const _segments = 12;
  static const _active = _HomeScreenState._brandGreen;
  static const _inactive = Color(0xFFE2E4DD);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = size.width / 2 - 7;

    final sweep = (2 * math.pi) / _segments;
    const gapFraction = 0.32;
    final arc = sweep * (1 - gapFraction);
    final filled = (progress * _segments).round();

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < _segments; i++) {
      paint.color = i < filled ? _active : _inactive;
      final start = -math.pi / 2 + i * sweep + (sweep - arc) / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        arc,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SegmentedRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ---------------------------------------------------------------------------
// Mood chips
// ---------------------------------------------------------------------------

class _MoodChip extends StatelessWidget {
  const _MoodChip({
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
      color: selected
          ? _HomeScreenState._ink
          : Colors.white.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : _HomeScreenState._ink,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cards
// ---------------------------------------------------------------------------

class _DoctorCard extends StatelessWidget {
  const _DoctorCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEABF9F),
                ),
                child: const Icon(Icons.medical_services_outlined,
                    color: Color(0xFF8A5A3E), size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Need a doctor's opinion?",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: _HomeScreenState._ink,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ask Sōlea · video, voice or chat consults',
                      style: TextStyle(
                        fontSize: 15,
                        color: _HomeScreenState._subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: _HomeScreenState._subtitle, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatRecommendationCard extends StatelessWidget {
  const _ChatRecommendationCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFC9A8E6), Color(0xFFE7A9C5)],
                  ),
                ),
                child: const Icon(Icons.auto_awesome,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.35,
                      color: _HomeScreenState._ink,
                    ),
                    children: [
                      TextSpan(
                        text: 'From your chat yesterday: ',
                        style: TextStyle(color: _HomeScreenState._subtitle),
                      ),
                      TextSpan(
                        text: '"I feel tired and my cramps are bad."',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right,
                  color: _HomeScreenState._subtitle, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Timeline
// ---------------------------------------------------------------------------

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.done,
    required this.child,
    this.isFirst = false,
    this.isLast = false,
  });

  final bool done;
  final Widget child;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                _node(),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFF3B6B44).withValues(alpha: 0.4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _node() {
    if (done) {
      return Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: _HomeScreenState._brandGreen,
        ),
        child: const Icon(Icons.check, size: 20, color: Colors.white),
      );
    }
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: _HomeScreenState._brandGreen, width: 2),
      ),
    );
  }
}

class _TaskContent extends StatelessWidget {
  const _TaskContent({
    required this.meta,
    required this.title,
    required this.note,
    this.strikethrough = false,
  });

  final String meta;
  final String title;
  final String note;
  final bool strikethrough;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          meta,
          style: const TextStyle(fontSize: 15, color: _HomeScreenState._subtitle),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: strikethrough
                ? _HomeScreenState._subtitle
                : _HomeScreenState._ink,
            decoration:
                strikethrough ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        const SizedBox(height: 8),
        _TaskNote(note),
      ],
    );
  }
}

class _WaterTaskContent extends StatelessWidget {
  const _WaterTaskContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        const Text(
          'All day',
          style: TextStyle(fontSize: 15, color: _HomeScreenState._subtitle),
        ),
        const SizedBox(height: 4),
        const Text(
          'Drink 2L water',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _HomeScreenState._ink,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Container(
                      height: 10,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        height: 10,
                        color: const Color(0xFF6C8BCB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Text(
              '1.2 / 2L',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _HomeScreenState._ink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const _TaskNote('Helps with cramps and tiredness'),
      ],
    );
  }
}

class _TaskNote extends StatelessWidget {
  const _TaskNote(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.chat_bubble_outline,
            size: 16, color: _HomeScreenState._brandGreen),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _HomeScreenState._brandGreen,
            ),
          ),
        ),
      ],
    );
  }
}

class _TellSoleaButton extends StatelessWidget {
  const _TellSoleaButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: _DashedBorder(
        radius: 30,
        color: const Color(0xFFA9ADA4),
        child: const SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, size: 20, color: _HomeScreenState._ink),
              SizedBox(width: 10),
              Text(
                'Not right for you? Tell Sōlea',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _HomeScreenState._ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation
// ---------------------------------------------------------------------------

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: _NavItem(
                icon: Icons.home_filled, label: 'Home', selected: true),
          ),
          const Expanded(
            child: _NavItem(
                icon: Icons.medication_outlined, label: 'Cycle'),
          ),
          const Expanded(
            child: _NavItem(
                icon: Icons.auto_awesome, label: 'Wellness hub'),
          ),
          const Expanded(
            child: _NavItem(icon: Icons.forest_outlined, label: 'Community'),
          ),
          const SizedBox(width: 6),
          _AskButton(onTap: () {}),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? _HomeScreenState._brandGreen : Colors.transparent,
            border: selected
                ? null
                : Border.all(color: _HomeScreenState._ink, width: 1.4),
          ),
          child: Icon(
            icon,
            size: 22,
            color: selected ? Colors.white : _HomeScreenState._ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: _HomeScreenState._ink,
          ),
        ),
      ],
    );
  }
}

class _AskButton extends StatelessWidget {
  const _AskButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 66,
        height: 66,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFB07257),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.auto_awesome, size: 22, color: Colors.white),
            SizedBox(height: 2),
            Text(
              'Ask',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: _HomeScreenState._ink,
      ),
    );
  }
}

/// Draws a dashed border (rounded rectangle) around its child.
class _DashedBorder extends StatelessWidget {
  const _DashedBorder({
    required this.radius,
    required this.color,
    required this.child,
  });

  final double radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(radius: radius, color: color),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.radius, required this.color});

  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(radius),
      ));

    const dash = 6.0;
    const gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dash),
          paint,
        );
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.color != color;
}
