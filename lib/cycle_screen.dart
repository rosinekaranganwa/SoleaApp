import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'ask_ai_screen.dart';

/// Solea cycle-tracking screen.
class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);

  // Phase colours.
  static const _menstrual = Color(0xFFDD6B86);
  static const _follicular = Color(0xFF8CBF8A);
  static const _ovulatory = Color(0xFFB7A4E6);
  static const _luteal = Color(0xFFE6CE8E);

  static const _symptoms = ['Cramps', 'Headache', 'Bloating', 'Nausea', 'Back pain'];
  static const _moods = ['Calm', 'Tired', 'Irritable', 'Happy'];

  final Set<String> _selectedSymptoms = {'Cramps'};
  int _flow = 1; // 0 spotting, 1 light, 2 medium, 3 heavy
  String _mood = 'Tired';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        children: [
          const _MeshBackground(),
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
              children: [
                const _Header(),
                const SizedBox(height: 18),
                const _WeekStrip(),
                const SizedBox(height: 20),
                const _CycleRingCard(),
                const SizedBox(height: 18),
                const _PredictionCard(),
                const SizedBox(height: 18),
                const _CalendarCard(),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Expanded(child: _SectionTitle('Log symptoms')),
                    Text(
                      'Today · Thu 12 Feb',
                      style: TextStyle(fontSize: 15, color: _subtitle),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildLogCard(),
              ],
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

  Widget _buildLogCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _MiniTitle('Pain & symptoms'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: _symptoms.map((s) {
              return _SelectableChip(
                label: s,
                selected: _selectedSymptoms.contains(s),
                onTap: () => setState(() {
                  _selectedSymptoms.contains(s)
                      ? _selectedSymptoms.remove(s)
                      : _selectedSymptoms.add(s);
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          const _MiniTitle('Flow'),
          const SizedBox(height: 12),
          Row(
            children: List.generate(4, (i) {
              const labels = ['Spotting', 'Light', 'Medium', 'Heavy'];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 3 ? 0 : 10),
                  child: _FlowOption(
                    label: labels[i],
                    drops: i == 0 ? 1 : i + 1,
                    selected: _flow == i,
                    onTap: () => setState(() => _flow = i),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 22),
          const _MiniTitle('Mood'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: _moods.map((m) {
              return _SelectableChip(
                label: m,
                selected: _mood == m,
                onTap: () => setState(() => _mood = m),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 62,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _ink,
                foregroundColor: Colors.white,
                elevation: 0,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Save today's log"),
            ),
          ),
          const SizedBox(height: 16),
          const _AskPromptCard(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Background
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

// ---------------------------------------------------------------------------
// Header + week strip
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
                'Thursday, 12 Feb',
                style: TextStyle(fontSize: 16, color: _CycleScreenState._subtitle),
              ),
              SizedBox(height: 2),
              Text(
                'Cycle tracking',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: _CycleScreenState._ink,
                ),
              ),
            ],
          ),
        ),
        _CircleButton(icon: Icons.calendar_today_outlined, onTap: () {}),
        const SizedBox(width: 10),
        _CircleButton(icon: Icons.more_vert, onTap: () {}),
      ],
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  @override
  Widget build(BuildContext context) {
    const days = <_WeekDay>[
      _WeekDay('M', 9, color: Colors.white),
      _WeekDay('T', 10, color: Color(0xFFC7C9D2)),
      _WeekDay('W', 11, color: Color(0xFFD9D0EC)),
      _WeekDay('T', 12, color: _CycleScreenState._ink, light: true),
      _WeekDay('F', 13, color: Color(0xFFD4C7EC)),
      _WeekDay('S', 14, color: Color(0xFFD4C7EC)),
      _WeekDay('S', 15, color: Color(0xFF7C5CCB), light: true),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) => _WeekDayItem(day: d)).toList(),
    );
  }
}

class _WeekDay {
  const _WeekDay(this.label, this.date, {required this.color, this.light = false});

  final String label;
  final int date;
  final Color color;
  final bool light; // light = white text
}

class _WeekDayItem extends StatelessWidget {
  const _WeekDayItem({required this.day});

  final _WeekDay day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: day.date == 12 ? FontWeight.w800 : FontWeight.w500,
            color: _CycleScreenState._subtitle,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: day.color,
            border: day.color == Colors.white
                ? Border.all(color: const Color(0xFFCFD2CB))
                : null,
          ),
          child: Text(
            '${day.date}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: day.light ? Colors.white : _CycleScreenState._ink,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Cycle ring card
// ---------------------------------------------------------------------------

class _CycleRingCard extends StatelessWidget {
  const _CycleRingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: CustomPaint(
              painter: _CycleRingPainter(currentDay: 12, totalDays: 28),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'CYCLE DAY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: _CycleScreenState._subtitle,
                      ),
                    ),
                    Text(
                      '12',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        color: _CycleScreenState._ink,
                      ),
                    ),
                    Text(
                      'of 28 days',
                      style: TextStyle(
                        fontSize: 18,
                        color: _CycleScreenState._subtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: _CycleScreenState._follicular,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.eco, size: 20, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Follicular phase',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'High energy phase',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: _CycleScreenState._ink,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Oestrogen is rising. A great time for strength '
            'training and social plans.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              height: 1.4,
              color: _CycleScreenState._subtitle,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: _PhaseLegend(
                  color: _CycleScreenState._menstrual,
                  name: 'Menstrual',
                  range: 'Day 1–5',
                ),
              ),
              Expanded(
                child: _PhaseLegend(
                  color: _CycleScreenState._follicular,
                  name: 'Follicular',
                  range: 'Day 6–13',
                  highlighted: true,
                ),
              ),
              Expanded(
                child: _PhaseLegend(
                  color: _CycleScreenState._ovulatory,
                  name: 'Ovulatory',
                  range: 'Day 14–16',
                ),
              ),
              Expanded(
                child: _PhaseLegend(
                  color: _CycleScreenState._luteal,
                  name: 'Luteal',
                  range: 'Day 17–28',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.water_drop_outlined, size: 24),
              label: const Text('Log period'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 0,
                textStyle:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ).copyWith(
                backgroundColor:
                    const WidgetStatePropertyAll(Color(0xFFCF6480)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleRingPainter extends CustomPainter {
  _CycleRingPainter({required this.currentDay, required this.totalDays});

  final int currentDay;
  final int totalDays;

  Color _phaseColor(int day) {
    if (day <= 5) return _CycleScreenState._menstrual;
    if (day <= 13) return _CycleScreenState._follicular;
    if (day <= 16) return _CycleScreenState._ovulatory;
    return _CycleScreenState._luteal;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - 28;

    final sweep = (2 * math.pi) / totalDays;
    const gapFraction = 0.28;
    final arc = sweep * (1 - gapFraction);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    for (var day = 1; day <= totalDays; day++) {
      paint.color = _phaseColor(day);
      final start = -math.pi / 2 + (day - 1) * sweep + (sweep - arc) / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        arc,
        false,
        paint,
      );
    }

    // Draggable knob at the current day.
    final knobAngle = -math.pi / 2 + ((currentDay - 0.5) / totalDays) * 2 * math.pi;
    final knobCenter = center +
        Offset(math.cos(knobAngle), math.sin(knobAngle)) * radius;
    canvas.drawCircle(
        knobCenter, 20, Paint()..color = _CycleScreenState._follicular);
    canvas.drawCircle(knobCenter, 13, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_CycleRingPainter oldDelegate) =>
      oldDelegate.currentDay != currentDay;
}

class _PhaseLegend extends StatelessWidget {
  const _PhaseLegend({
    required this.color,
    required this.name,
    required this.range,
    this.highlighted = false,
  });

  final Color color;
  final String name;
  final String range;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: highlighted
          ? BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Column(
        children: [
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: highlighted ? FontWeight.w800 : FontWeight.w600,
              color: _CycleScreenState._ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            range,
            style: const TextStyle(
                fontSize: 13, color: _CycleScreenState._subtitle),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Prediction card
// ---------------------------------------------------------------------------

class _PredictionCard extends StatelessWidget {
  const _PredictionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  '17',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1,
                    color: _CycleScreenState._menstrual,
                  ),
                ),
                Text(
                  'days',
                  style: TextStyle(
                      fontSize: 13, color: _CycleScreenState._subtitle),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Period in 17 days',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _CycleScreenState._ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Expected around Sun 1 Mar · 28-day cycle',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: _CycleScreenState._subtitle,
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

// ---------------------------------------------------------------------------
// Calendar card
// ---------------------------------------------------------------------------

class _CalendarCard extends StatelessWidget {
  const _CalendarCard();

  // Day types for February 2026.
  static const _period = {1, 2, 3, 4, 5};
  static const _fertile = {10, 11, 13, 14, 16};
  static const _ovulation = {15};
  static const _today = 12;

  @override
  Widget build(BuildContext context) {
    // February 2026 starts on a Sunday (Mon-first grid → 6 leading blanks).
    final cells = <int?>[...List.filled(6, null), ...List.generate(28, (i) => i + 1)];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'February 2026',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _CycleScreenState._ink,
                  ),
                ),
              ),
              _CircleButton(icon: Icons.chevron_left, onTap: () {}),
              const SizedBox(width: 10),
              _CircleButton(icon: Icons.chevron_right, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                            fontSize: 15,
                            color: _CycleScreenState._subtitle,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          ...List.generate((cells.length / 7).ceil(), (row) {
            return Row(
              children: List.generate(7, (col) {
                final index = row * 7 + col;
                final day = index < cells.length ? cells[index] : null;
                return Expanded(child: _dayCell(day));
              }),
            );
          }),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFCFD2CB)),
          const SizedBox(height: 12),
          Row(
            children: const [
              _CalLegend(color: _CycleScreenState._menstrual, label: 'Period'),
              _CalLegend(
                  color: _CycleScreenState._ovulatory,
                  label: 'Fertile',
                  outlined: true),
              _CalLegend(color: Color(0xFF7C5CCB), label: 'Ovulation'),
              _CalLegend(
                  color: _CycleScreenState._brandGreen,
                  label: 'Today',
                  outlined: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayCell(int? day) {
    if (day == null) return const SizedBox(height: 44);

    final isToday = day == _today;
    Color? fill;
    if (_period.contains(day)) {
      fill = _CycleScreenState._menstrual;
    } else if (_ovulation.contains(day)) {
      fill = const Color(0xFF7C5CCB);
    } else if (_fertile.contains(day)) {
      fill = const Color(0xFFD4C7EC);
    }

    final isDarkFill = fill == _CycleScreenState._menstrual ||
        fill == const Color(0xFF7C5CCB);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fill,
            border: isToday
                ? Border.all(color: _CycleScreenState._brandGreen, width: 2)
                : null,
          ),
          child: Text(
            '$day',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
              color: isDarkFill ? Colors.white : _CycleScreenState._ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _CalLegend extends StatelessWidget {
  const _CalLegend({
    required this.color,
    required this.label,
    this.outlined = false,
  });

  final Color color;
  final String label;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: outlined ? Colors.transparent : color,
              border: outlined ? Border.all(color: color, width: 2) : null,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, color: _CycleScreenState._ink),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Symptom logger pieces
// ---------------------------------------------------------------------------

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
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
      color: selected ? _CycleScreenState._ink : Colors.white,
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(Icons.check, size: 18, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: selected ? Colors.white : _CycleScreenState._ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlowOption extends StatelessWidget {
  const _FlowOption({
    required this.label,
    required this.drops,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int drops;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : _CycleScreenState._ink;
    return Material(
      color: selected ? _CycleScreenState._ink : Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  drops,
                  (_) => Icon(Icons.water_drop_outlined, size: 16, color: fg),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AskPromptCard extends StatelessWidget {
  const _AskPromptCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(14),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Cramps 3 days in a row?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _CycleScreenState._ink,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Ask Sōlea what helps, or talk to a doctor',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        color: _CycleScreenState._subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right,
                  color: _CycleScreenState._subtitle, size: 26),
            ],
          ),
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
        color: _CycleScreenState._ink,
      ),
    );
  }
}

class _MiniTitle extends StatelessWidget {
  const _MiniTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: _CycleScreenState._ink,
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
          child: Icon(icon, size: 24, color: _CycleScreenState._ink),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation (Cycle selected)
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
          Expanded(
            child: _NavItem(
              icon: Icons.home_filled,
              label: 'Home',
              onTap: () => Navigator.maybePop(context),
            ),
          ),
          const Expanded(
            child: _NavItem(
                icon: Icons.medication_outlined,
                label: 'Cycle',
                selected: true),
          ),
          const Expanded(
            child: _NavItem(icon: Icons.auto_awesome, label: 'Wellness hub'),
          ),
          const Expanded(
            child: _NavItem(icon: Icons.forest_outlined, label: 'Community'),
          ),
          const SizedBox(width: 6),
          Builder(
            builder: (context) => _AskButton(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AskAiScreen()),
              ),
            ),
          ),
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
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  selected ? _CycleScreenState._brandGreen : Colors.transparent,
              border: selected
                  ? null
                  : Border.all(color: _CycleScreenState._ink, width: 1.4),
            ),
            child: Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : _CycleScreenState._ink,
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
              color: _CycleScreenState._ink,
            ),
          ),
        ],
      ),
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
