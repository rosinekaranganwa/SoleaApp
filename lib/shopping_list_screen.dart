import 'dart:ui';
import 'package:flutter/material.dart';

/// Solea shopping-list screen.
class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _subtitle = Color(0xFF5B5F66);

  final List<_Category> _categories = [
    _Category('Fruit & veg', Icons.eco, const Color(0xFFD6E3D2), [
      _Item('Spinach', '3 bunches', bought: true),
      _Item('Avocados', '4', bought: true),
      _Item('Sweet potatoes', '1.5 kg'),
      _Item('Amaranth (dodo)', '2 bunches'),
      _Item('Passion fruit', '8'),
      _Item('Ginger', '1 root'),
    ]),
    _Category('Protein', Icons.set_meal, const Color(0xFFF3C9D4), [
      _Item('Tilapia fillets', '4 × 150 g'),
      _Item('Chicken breast', '600 g'),
      _Item('Eggs', '12', bought: true),
      _Item('Red lentils', '500 g'),
    ]),
    _Category('Grains & beans', Icons.grass, const Color(0xFFEAD9A6), [
      _Item('Brown rice', '1 kg'),
      _Item('Dry beans', '1 kg', bought: true),
      _Item('Whole-grain bread', '1 loaf'),
    ]),
    _Category('Dairy & pantry', Icons.local_drink, const Color(0xFFD9CDEE), [
      _Item('Greek yogurt', '1 kg'),
      _Item('Groundnuts', '250 g'),
      _Item('Olive oil', '1 bottle', bought: true),
      _Item('Turmeric', '1 jar'),
    ]),
  ];

  int get _total =>
      _categories.fold(0, (sum, c) => sum + c.items.length);
  int get _bought => _categories.fold(
      0, (sum, c) => sum + c.items.where((i) => i.bought).length);

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
                        child: Text(
                          '13–19 Oct · Ovulatory',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: _subtitle,
                          ),
                        ),
                      ),
                    ),
                    _CircleButton(icon: Icons.ios_share, onTap: () {}),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Shopping list',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$_bought of $_total items bought',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                    ),
                    const Text(
                      '7 meals · 2 people',
                      style: TextStyle(fontSize: 16, color: _subtitle),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Stack(
                    children: [
                      Container(
                          height: 10,
                          color: Colors.white.withValues(alpha: 0.7)),
                      FractionallySizedBox(
                        widthFactor: _total == 0 ? 0 : _bought / _total,
                        child: Container(height: 10, color: _brandGreen),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ..._categories.map(_buildCategory),
                const _AddItemButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(_Category category) {
    final bought = category.items.where((i) => i.bought).length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: category.color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(category.icon, size: 24, color: _ink),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                ),
                Text(
                  '$bought/${category.items.length}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _subtitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...List.generate(category.items.length, (i) {
              final item = category.items[i];
              return Column(
                children: [
                  if (i != 0) const Divider(color: Color(0xFFE2E4DD), height: 1),
                  _buildItemRow(item),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_Item item) {
    return InkWell(
      onTap: () => setState(() => item.bought = !item.bought),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            _Checkbox(checked: item.bought),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: item.bought ? _subtitle : _ink,
                  decoration: item.bought
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: _subtitle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              item.qty,
              style: const TextStyle(fontSize: 17, color: _subtitle),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  _Category(this.name, this.icon, this.color, this.items);

  final String name;
  final IconData icon;
  final Color color;
  final List<_Item> items;
}

class _Item {
  _Item(this.name, this.qty, {this.bought = false});

  final String name;
  final String qty;
  bool bought;
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.checked});

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: checked
            ? _ShoppingListScreenState._brandGreen
            : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        border: checked
            ? null
            : Border.all(color: const Color(0xFFC3C6BF), width: 1.6),
      ),
      child: checked
          ? const Icon(Icons.check, size: 20, color: Colors.white)
          : null,
    );
  }
}

class _AddItemButton extends StatelessWidget {
  const _AddItemButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomPaint(
        painter:
            _DashedRRectPainter(radius: 28, color: const Color(0xFFA9ADA4)),
        child: const SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 24, color: _ShoppingListScreenState._ink),
              SizedBox(width: 10),
              Text(
                'Add your own item',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ShoppingListScreenState._ink,
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
          child: Icon(icon, size: 22, color: _ShoppingListScreenState._ink),
        ),
      ),
    );
  }
}

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
