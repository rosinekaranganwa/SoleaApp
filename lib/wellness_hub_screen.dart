import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'ask_ai_screen.dart';
import 'shopping_list_screen.dart';
import 'weekly_plan_screen.dart';

/// Solea Wellness Hub (Training + Nutrition tabs).
class WellnessHubScreen extends StatefulWidget {
  const WellnessHubScreen({super.key});

  @override
  State<WellnessHubScreen> createState() => _WellnessHubScreenState();
}

class _WellnessHubScreenState extends State<WellnessHubScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _cardGreen = Color(0xFF3E5E45);
  static const _subtitle = Color(0xFF5B5F66);
  static const _pink = Color(0xFFDD6B86);
  static const _maroon = Color(0xFF9E4B5A);

  int _tab = 0; // 0 = Training, 1 = Nutrition

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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
              children: _tab == 0 ? _training() : _nutrition(),
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

  Widget get _toggle => _TabToggle(
        selected: _tab,
        onChanged: (v) => setState(() => _tab = v),
      );

  // ----- Training tab -------------------------------------------------------

  List<Widget> _training() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: _TitleBlock(
              overline: 'Thursday · Cycle day 9',
              title: 'Personal Training',
            ),
          ),
          _Avatar(),
        ],
      ),
      const SizedBox(height: 20),
      _toggle,
      const SizedBox(height: 20),
      const _CoachCard(),
      const SizedBox(height: 18),
      const _ProgramCard(),
      const SizedBox(height: 18),
      _WeeklyPlanBanner(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const WeeklyPlanScreen()),
        ),
      ),
      const SizedBox(height: 24),
      Row(
        children: const [
          Expanded(child: _SectionTitle('Video library')),
          Text(
            'See all',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: _brandGreen,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const _FilterChips(),
      const SizedBox(height: 16),
      const _VideoRow(),
    ];
  }

  // ----- Nutrition tab ------------------------------------------------------

  List<Widget> _nutrition() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: _TitleBlock(
              overline: 'CYCLE DAY 15 · OVULATORY',
              title: 'Nutrition',
              subtitle: 'Fuel your body, honor your cycle',
            ),
          ),
          _Avatar(),
        ],
      ),
      const SizedBox(height: 20),
      _toggle,
      const SizedBox(height: 20),
      const _PeakEnergyCard(),
      const SizedBox(height: 18),
      const _DailyGoalsCard(),
      const SizedBox(height: 18),
      _MealPlanCard(
        onShoppingList: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ShoppingListScreen()),
        ),
      ),
      const SizedBox(height: 24),
      const _SectionTitle('Follow nutritionists'),
      const SizedBox(height: 16),
      const _NutritionistRow(),
    ];
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
// Shared header pieces
// ---------------------------------------------------------------------------

class _TitleBlock extends StatelessWidget {
  const _TitleBlock({
    required this.overline,
    required this.title,
    this.subtitle,
  });

  final String overline;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overline,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: _WellnessHubScreenState._subtitle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: _WellnessHubScreenState._ink,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: const TextStyle(
                fontSize: 17, color: _WellnessHubScreenState._subtitle),
          ),
        ],
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}

class _TabToggle extends StatelessWidget {
  const _TabToggle({required this.selected, required this.onChanged});

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
          _half('Training', 0),
          _half('Nutrition', 1),
        ],
      ),
    );
  }

  Widget _half(String label, int index) {
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
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: isSelected
                  ? _WellnessHubScreenState._ink
                  : _WellnessHubScreenState._subtitle,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Training tab cards
// ---------------------------------------------------------------------------

class _CoachCard extends StatelessWidget {
  const _CoachCard();

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF9FC79A), Color(0xFFDD8FA8)],
                  ),
                ),
                child: const Text('R',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coach Rosine',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _WellnessHubScreenState._ink,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Certified PT · Cycle specialist',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        color: _WellnessHubScreenState._subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _SmallCircleButton(icon: Icons.chat_bubble_outline, onTap: () {}),
              const SizedBox(width: 10),
              _SmallCircleButton(icon: Icons.call_outlined, onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '"Great work this week! Your follicular phase is perfect for '
            'adding more weight. Ready to level up?"',
            style: TextStyle(
              fontSize: 18,
              height: 1.4,
              color: _WellnessHubScreenState._ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: CustomPaint(
              painter: _SegmentRingPainter(
                colors: List.generate(
                  8,
                  (i) => i < 5
                      ? _WellnessHubScreenState._cardGreen
                      : _WellnessHubScreenState._maroon,
                ),
                strokeWidth: 14,
              ),
              child: const Center(
                child: Text(
                  '65%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _WellnessHubScreenState._ink,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '8-Week Strength Builder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _WellnessHubScreenState._ink,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Follicular · High intensity',
                  style: TextStyle(
                      fontSize: 15, color: _WellnessHubScreenState._subtitle),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _Pill('Week 5/8'),
                    _Pill('3 left'),
                    _Pill('12 done'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: _WellnessHubScreenState._ink,
        ),
      ),
    );
  }
}

class _WeeklyPlanBanner extends StatelessWidget {
  const _WeeklyPlanBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _WellnessHubScreenState._cardGreen,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.calendar_today_outlined,
                    color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Access your weekly plan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Follicular routine · 4 workouts · trainer-ready',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        color: Color(0xFFCBD9C8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.arrow_forward,
                    color: _WellnessHubScreenState._ink, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    const labels = ['All', 'Sōlea', 'YouTube', 'Partner trainers'];
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final selected = i == 0;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: selected
                  ? _WellnessHubScreenState._ink
                  : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : _WellnessHubScreenState._ink,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VideoRow extends StatelessWidget {
  const _VideoRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _VideoCard(
            source: 'Sōlea',
            icon: Icons.directions_run,
            title: 'Follicular Phase HIIT',
            subtitle: 'Follicular · at home',
            duration: '8:53',
            color: Color(0xFF9FC79A),
          ),
          SizedBox(width: 16),
          _VideoCard(
            source: 'YouTube',
            icon: Icons.self_improvement,
            title: 'Gentle Yoga Flow',
            subtitle: 'Follicular · at home',
            duration: '12:20',
            color: Color(0xFFE7A9C5),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({
    required this.source,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.color,
  });

  final String source;
  final IconData icon;
  final String title;
  final String subtitle;
  final String duration;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withValues(alpha: 0.55)],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(icon,
                      size: 64, color: _WellnessHubScreenState._ink),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      source,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _WellnessHubScreenState._ink,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: _WellnessHubScreenState._ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: _WellnessHubScreenState._ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
                fontSize: 15, color: _WellnessHubScreenState._subtitle),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Nutrition tab cards
// ---------------------------------------------------------------------------

class _PeakEnergyCard extends StatelessWidget {
  const _PeakEnergyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD96E88), Color(0xFFBE5A74)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'DAY 15 · OVULATORY PHASE',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Peak Energy Window',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Focus on high-protein, anti-inflammatory foods to support '
            'peak performance and hormone balance.',
            style: TextStyle(
              fontSize: 17,
              height: 1.4,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyGoalsCard extends StatelessWidget {
  const _DailyGoalsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Daily goals'),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: _MacroRing(
                    value: '95g',
                    label: 'Protein',
                    color: _WellnessHubScreenState._pink),
              ),
              Expanded(
                child: _MacroRing(
                    value: '180g', label: 'Carbs', color: Color(0xFFE6C45E)),
              ),
              Expanded(
                child: _MacroRing(
                    value: '55g', label: 'Fats', color: Color(0xFF7FB07C)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _DashedButton(
            icon: Icons.tune,
            label: 'Adjust my goals',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _MacroRing extends StatelessWidget {
  const _MacroRing({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 92,
          height: 92,
          child: CustomPaint(
            painter: _SegmentRingPainter(
              colors: List.filled(10, color),
              strokeWidth: 11,
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: _WellnessHubScreenState._ink,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, color: _WellnessHubScreenState._subtitle),
        ),
      ],
    );
  }
}

class _MealPlanCard extends StatelessWidget {
  const _MealPlanCard({required this.onShoppingList});

  final VoidCallback onShoppingList;

  @override
  Widget build(BuildContext context) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
            children: const [
              Expanded(child: _SectionTitle("This week's meal plan")),
              Icon(Icons.chevron_right,
                  color: _WellnessHubScreenState._subtitle, size: 26),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '7 meals for your ovulatory phase',
            style:
                TextStyle(fontSize: 16, color: _WellnessHubScreenState._subtitle),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(days.length, (i) {
              final done = i < 4;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: i == 6 ? 0 : 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          days[i],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _WellnessHubScreenState._subtitle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          done ? Icons.check : Icons.ramen_dining,
                          size: 20,
                          color: done
                              ? _WellnessHubScreenState._brandGreen
                              : _WellnessHubScreenState._subtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          Material(
            color: _WellnessHubScreenState._cardGreen,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: onShoppingList,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Shopping list · 17 items',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        '5 bought',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionistRow extends StatelessWidget {
  const _NutritionistRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 244,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _NutritionistCard(
            name: 'Dr. Rosine K',
            role: 'Hormone Health',
            color: Color(0xFFDD8FA8),
          ),
          SizedBox(width: 16),
          _NutritionistCard(
            name: 'Dr. Jackie U',
            role: 'Nutrition Specialist',
            color: Color(0xFFC9A8E6),
          ),
        ],
      ),
    );
  }
}

class _NutritionistCard extends StatelessWidget {
  const _NutritionistCard({
    required this.name,
    required this.role,
    required this.color,
  });

  final String name;
  final String role;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Text(
              name.split(' ').last[0],
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: _WellnessHubScreenState._ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: const TextStyle(
                fontSize: 15, color: _WellnessHubScreenState._subtitle),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _WellnessHubScreenState._ink,
                foregroundColor: Colors.white,
                elevation: 0,
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text('Follow'),
            ),
          ),
        ],
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
        color: _WellnessHubScreenState._ink,
      ),
    );
  }
}

class _DashedButton extends StatelessWidget {
  const _DashedButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DashedRRectPainter(
            radius: 28, color: const Color(0xFFA9ADA4)),
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: _WellnessHubScreenState._ink),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _WellnessHubScreenState._ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallCircleButton extends StatelessWidget {
  const _SmallCircleButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.8),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, size: 20, color: _WellnessHubScreenState._ink),
        ),
      ),
    );
  }
}

/// Segmented ring, one colour per segment.
class _SegmentRingPainter extends CustomPainter {
  _SegmentRingPainter({required this.colors, required this.strokeWidth});

  final List<Color> colors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2 - strokeWidth / 2 - 2;
    final segments = colors.length;
    final sweep = (2 * math.pi) / segments;
    const gapFraction = 0.3;
    final arc = sweep * (1 - gapFraction);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < segments; i++) {
      paint.color = colors[i];
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
  bool shouldRepaint(_SegmentRingPainter oldDelegate) =>
      oldDelegate.colors != colors;
}

/// Dashed rounded-rectangle border.
class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({required this.radius, required this.color});

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
          Offset.zero & size, Radius.circular(radius)));
    const dash = 7.0;
    const gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRRectPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Bottom navigation (Wellness hub selected)
// ---------------------------------------------------------------------------

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
            child: _NavItem(icon: Icons.medication_outlined, label: 'Cycle'),
          ),
          const Expanded(
            child: _NavItem(
                icon: Icons.auto_awesome,
                label: 'Wellness hub',
                selected: true),
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
              color: selected
                  ? _WellnessHubScreenState._brandGreen
                  : Colors.transparent,
              border: selected
                  ? null
                  : Border.all(
                      color: _WellnessHubScreenState._ink, width: 1.4),
            ),
            child: Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : _WellnessHubScreenState._ink,
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
              color: _WellnessHubScreenState._ink,
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
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
