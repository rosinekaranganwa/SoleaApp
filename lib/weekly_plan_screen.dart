import 'dart:ui';
import 'package:flutter/material.dart';

/// Solea weekly training-plan screen.
class WeeklyPlanScreen extends StatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  State<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends State<WeeklyPlanScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);
  static const _pink = Color(0xFFC14D66);

  int _mode = 0; // 0 = On my own, 1 = With my trainer

  static const _sections = [
    _Section('WARM-UP · 8 MIN', [
      _Exercise('01', 'Hip circles + cat-cow', '2 rounds · 60 s'),
      _Exercise('02', 'Band glute walk', '2 × 12 each side'),
    ]),
    _Section('MAIN SET · 30 MIN', [
      _Exercise('03', 'Goblet squat', '4 × 10 · rest 90 s', weight: '16 kg'),
      _Exercise('04', 'Romanian deadlift', '4 × 8 · rest 90 s', weight: '20 kg'),
      _Exercise('05', 'Walking lunges', '3 × 12 / leg · rest 90 s',
          weight: 'Body'),
      _Exercise('06', 'Hip thrust', '3 × 12 · rest 90 s', weight: '30 kg'),
    ]),
    _Section('COOL-DOWN · 7 MIN', [
      _Exercise('07', 'Pigeon stretch', '60 s each side'),
      _Exercise('08', 'Box breathing', '3 min'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        children: [
          const _MeshBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                Row(
                  children: [
                    _CircleButton(
                      icon: Icons.arrow_back_ios_new,
                      onTap: () => Navigator.maybePop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: _HeaderPill('Week 5 · Follicular'),
                      ),
                    ),
                    _CircleButton(icon: Icons.ios_share, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your weekly plan',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    letterSpacing: -1,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Energy is rising, so this week goes heavier on lifts '
                  'with one HIIT day.',
                  style: TextStyle(fontSize: 18, height: 1.4, color: _subtitle),
                ),
                const SizedBox(height: 20),
                _ModeToggle(
                  selected: _mode,
                  onChanged: (v) => setState(() => _mode = v),
                ),
                const SizedBox(height: 18),
                const _WeekStrip(),
                const SizedBox(height: 20),
                _buildWorkoutCard(),
                const SizedBox(height: 18),
                const _CoachNote(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'THURSDAY · TODAY',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: _brandGreen,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Lower body strength',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '45 min',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final section in _sections) ...[
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 12),
              child: Text(
                section.label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: _subtitle,
                ),
              ),
            ),
            ...section.exercises.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ExerciseRow(exercise: e),
                )),
          ],
        ],
      ),
    );
  }
}

class _Section {
  const _Section(this.label, this.exercises);

  final String label;
  final List<_Exercise> exercises;
}

class _Exercise {
  const _Exercise(this.number, this.name, this.detail, {this.weight});

  final String number;
  final String name;
  final String detail;
  final String? weight;
}

class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({required this.exercise});

  final _Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              exercise.number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _WeeklyPlanScreenState._brandGreen,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: _WeeklyPlanScreenState._ink,
                  ),
                ),
                if (exercise.detail.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    exercise.detail,
                    style: const TextStyle(
                      fontSize: 15,
                      color: _WeeklyPlanScreenState._subtitle,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (exercise.weight != null) ...[
            const SizedBox(width: 10),
            Text(
              exercise.weight!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: _WeeklyPlanScreenState._pink,
              ),
            ),
            const SizedBox(width: 10),
          ] else
            const SizedBox(width: 10),
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _WeeklyPlanScreenState._ink,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          _half(Icons.person_outline, 'On my own', 0),
          _half(Icons.group_outlined, 'With my trainer', 1),
        ],
      ),
    );
  }

  Widget _half(IconData icon, String label, int index) {
    final isSelected = index == selected;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 20,
                  color: isSelected
                      ? _WeeklyPlanScreenState._ink
                      : _WeeklyPlanScreenState._subtitle),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: isSelected
                        ? _WeeklyPlanScreenState._ink
                        : _WeeklyPlanScreenState._subtitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  @override
  Widget build(BuildContext context) {
    const days = [
      ['M', '9'],
      ['T', '10'],
      ['W', '11'],
      ['T', '12'],
      ['F', '13'],
      ['S', '14'],
      ['S', '15'],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(days.length, (i) {
        final selected = i == 3;
        final done = i == 0 || i == 1;
        return _DayChip(
          label: days[i][0],
          date: days[i][1],
          selected: selected,
          dotColor: selected
              ? Colors.white
              : done
                  ? _WeeklyPlanScreenState._brandGreen
                  : Colors.transparent,
        );
      }),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.date,
    required this.selected,
    required this.dotColor,
  });

  final String label;
  final String date;
  final bool selected;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: selected
            ? _WeeklyPlanScreenState._ink
            : Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: selected
                  ? Colors.white70
                  : _WeeklyPlanScreenState._subtitle,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : _WeeklyPlanScreenState._ink,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
          ),
        ],
      ),
    );
  }
}

class _CoachNote extends StatelessWidget {
  const _CoachNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF5B8DEF), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF9FC79A), Color(0xFFDD8FA8)],
              ),
            ),
            child: const Text('R',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coach Rosine can see this plan',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _WeeklyPlanScreenState._pink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Keep 2 reps in reserve on squats. Try 18 kg next week '
                  'if your form stays clean.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: _WeeklyPlanScreenState._ink,
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

class _HeaderPill extends StatelessWidget {
  const _HeaderPill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: _WeeklyPlanScreenState._ink,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Background + helpers
// ---------------------------------------------------------------------------

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

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, size: 22, color: _WeeklyPlanScreenState._ink),
        ),
      ),
    );
  }
}
