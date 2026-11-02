import 'package:flutter/material.dart';

import 'ask_ai_screen.dart';

/// Solea Community screen (Posts + Blogs & articles tabs).
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _darkGreen = Color(0xFF2B4A34);
  static const _subtitle = Color(0xFF5B5F66);
  static const _pink = Color(0xFFD6557A);

  int _tab = 0; // 0 = Posts, 1 = Blogs & articles
  int _lang = 0; // 0 = EN, 1 = FR, 2 = RW

  final List<_Post> _posts = [
    _Post(
      'Aline M.',
      Color(0xFFE79BBE),
      'Luteal · 2 h',
      'Real talk: I used to think I was just "bad at being consistent" with '
          'workouts. After 6 weeks of tracking I realised I kept scheduling '
          'hard sessions in my luteal phase, when my body needs rest. I '
          'switched it up this cycle and feel like a different person. Anyone '
          'else been working against themselves without knowing it?',
      48,
      12,
      liked: true,
    ),
    _Post(
      'Grace U.',
      Color(0xFFE6C45E),
      'Ovulatory · 5 h',
      'Quick question: does anyone else completely lose their appetite during '
          'ovulation week? I have to remind myself to eat actual meals. I '
          'thought something was wrong with me for the longest time. Would '
          'love to know if this is common!',
      31,
      7,
    ),
    _Post(
      'Diane K.',
      Color(0xFF8FBF8A),
      'Follicular · 1 d',
      'Okay I have to share this. Woke up this morning and felt like myself '
          'again after a really hard week. Breakfast, a walk, journaling, all '
          'before 9am. Turns out I just entered my follicular phase. Is anyone '
          'else starting to see these patterns too?',
      72,
      18,
      liked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
              children: [
                const _Header(),
                const SizedBox(height: 20),
                _TabToggle(
                  selected: _tab,
                  onChanged: (v) => setState(() => _tab = v),
                ),
                const SizedBox(height: 20),
                ...(_tab == 0 ? _postsTab() : _blogsTab()),
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

  // ----- Posts tab ----------------------------------------------------------

  List<Widget> _postsTab() {
    return [
      const _LiveCard(),
      const SizedBox(height: 16),
      const _Composer(),
      const SizedBox(height: 16),
      const _FilterChips(
        labels: ['For you', 'Luteal', 'Ovulatory', 'Follicular', 'Period'],
      ),
      const SizedBox(height: 16),
      ...List.generate(_posts.length, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _PostCard(
            post: _posts[i],
            onLike: () => setState(() {
              final p = _posts[i];
              p.liked = !p.liked;
              p.likes += p.liked ? 1 : -1;
            }),
          ),
        );
      }),
    ];
  }

  // ----- Blogs tab ----------------------------------------------------------

  List<Widget> _blogsTab() {
    return [
      const _FilterChips(
        labels: ['All', 'Cycle basics', 'Nutrition', 'Training', 'Mental health'],
      ),
      const SizedBox(height: 16),
      const _FeaturedCard(),
      const SizedBox(height: 24),
      Row(
        children: [
          const Expanded(child: _SectionTitle('Latest from experts')),
          _LangToggle(
            selected: _lang,
            onChanged: (v) => setState(() => _lang = v),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const _ArticleRow(
        category: 'NUTRITION',
        title: 'Iron and your period: what to eat',
        author: 'Dr. Jackie U',
        minutes: '4 min',
        icon: Icons.restaurant,
        color: Color(0xFFF2E3B0),
      ),
      const SizedBox(height: 14),
      const _ArticleRow(
        category: 'TRAINING',
        title: 'Training through the luteal phase',
        author: 'Coach Amani',
        minutes: '5 min',
        icon: Icons.fitness_center,
        color: Color(0xFFF3D1DC),
      ),
      const SizedBox(height: 14),
      const _ArticleRow(
        category: 'CONDITIONS',
        title: 'PCOS: early signs and when to see a doctor',
        author: 'Dr. Rosine K',
        minutes: '7 min',
        icon: Icons.favorite_border,
        color: Color(0xFFD6E7D2),
      ),
      const SizedBox(height: 14),
      const _ArticleRow(
        category: 'MENTAL HEALTH',
        title: 'Sleep and hormones: a simple guide',
        author: 'Dr. Rosine K',
        minutes: '5 min',
        icon: Icons.nightlight_round,
        color: Color(0xFFE2DAF0),
      ),
      const SizedBox(height: 20),
      const _ExpertCta(),
    ];
  }
}

// ---------------------------------------------------------------------------
// Header + tabs
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
                'Community',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: _CommunityScreenState._ink,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Learn, share and grow together',
                style: TextStyle(
                    fontSize: 17, color: _CommunityScreenState._subtitle),
              ),
            ],
          ),
        ),
        _CircleButton(icon: Icons.search, onTap: () {}),
        const SizedBox(width: 12),
        const _Avatar(),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF9FC79A),
      ),
      child: const Text(
        'R',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: _CommunityScreenState._ink,
        ),
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
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          _half(Icons.chat_bubble_outline, 'Posts', 0),
          _half(Icons.article_outlined, 'Blogs & articles', 1),
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
                      ? _CommunityScreenState._ink
                      : _CommunityScreenState._subtitle),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                    color: isSelected
                        ? _CommunityScreenState._ink
                        : _CommunityScreenState._subtitle,
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

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
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
              color: selected ? _CommunityScreenState._darkGreen : Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : _CommunityScreenState._ink,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Posts tab widgets
// ---------------------------------------------------------------------------

class _LiveCard extends StatelessWidget {
  const _LiveCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 84,
            height: 84,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF9FC79A),
            ),
            child: const Text('R',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: _CommunityScreenState._ink)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.wifi_tethering,
                        size: 18, color: _CommunityScreenState._ink),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'LIVE Q&A · TOMORROW',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _CommunityScreenState._ink,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Rosine Karanganwa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _CommunityScreenState._ink,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Women's Health Specialist",
                  style: TextStyle(
                      fontSize: 15, color: _CommunityScreenState._subtitle),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _CommunityScreenState._darkGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: const Text('Remind me'),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF9FC79A),
            ),
            child: const Text('R',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _CommunityScreenState._ink)),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Share something with the community...',
              style: TextStyle(
                  fontSize: 18, color: _CommunityScreenState._subtitle),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _CommunityScreenState._darkGreen,
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

class _Post {
  _Post(this.name, this.color, this.meta, this.body, this.likes, this.comments,
      {this.liked = false});

  final String name;
  final Color color;
  final String meta;
  final String body;
  int likes;
  final int comments;
  bool liked;
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post, required this.onLike});

  final _Post post;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: post.color),
                child: Text(
                  post.name[0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: _CommunityScreenState._ink,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.name,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: _CommunityScreenState._ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.meta,
                      style: const TextStyle(
                          fontSize: 15, color: _CommunityScreenState._subtitle),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border,
                  color: _CommunityScreenState._ink, size: 24),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 18,
              height: 1.45,
              color: _CommunityScreenState._ink,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE2E4DD)),
          const SizedBox(height: 10),
          Row(
            children: [
              _ActionPill(
                icon: post.liked ? Icons.favorite : Icons.favorite_border,
                label: '${post.likes}',
                iconColor: post.liked
                    ? _CommunityScreenState._pink
                    : _CommunityScreenState._ink,
                onTap: onLike,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: _ActionPill(
                  icon: Icons.chat_bubble_outline,
                  label: '${post.comments} comments',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.ios_share,
                      size: 22, color: _CommunityScreenState._subtitle),
                  SizedBox(width: 8),
                  Text(
                    'Share',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: _CommunityScreenState._subtitle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = _CommunityScreenState._ink,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF1F2EC),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _CommunityScreenState._ink,
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

// ---------------------------------------------------------------------------
// Blogs tab widgets
// ---------------------------------------------------------------------------

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFD7A98E), Color(0xFFB77A5E)],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Row(
                    children: const [
                      _TagPill('Featured', dark: true),
                      SizedBox(width: 8),
                      _TagPill('Cycle basics'),
                    ],
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      '[COVER IMAGE]',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Why your energy changes across your cycle',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
              color: _CommunityScreenState._ink,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'What happens to your hormones in each phase, and how to plan '
            'your week around it.',
            style: TextStyle(
              fontSize: 17,
              height: 1.4,
              color: _CommunityScreenState._subtitle,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF9FC79A),
                ),
                child: const Text('R',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _CommunityScreenState._ink)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Flexible(
                          child: Text(
                            'Dr. Rosine K',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _CommunityScreenState._ink,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.verified,
                            size: 18, color: _CommunityScreenState._brandGreen),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Hormone Health · 6 min read',
                      style: TextStyle(
                          fontSize: 14, color: _CommunityScreenState._subtitle),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border,
                  color: _CommunityScreenState._ink, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill(this.text, {this.dark = false});

  final String text;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: dark ? _CommunityScreenState._darkGreen : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: dark ? Colors.white : _CommunityScreenState._ink,
        ),
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.language,
            size: 22, color: _CommunityScreenState._subtitle),
        const SizedBox(width: 8),
        ...List.generate(3, (i) {
          const labels = ['EN', 'FR', 'RW'];
          final isSelected = i == selected;
          return Padding(
            padding: const EdgeInsets.only(left: 6),
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? _CommunityScreenState._darkGreen
                      : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color:
                        isSelected ? Colors.white : _CommunityScreenState._ink,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _ArticleRow extends StatelessWidget {
  const _ArticleRow({
    required this.category,
    required this.title,
    required this.author,
    required this.minutes,
    required this.icon,
    required this.color,
  });

  final String category;
  final String title;
  final String author;
  final String minutes;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 36, color: _CommunityScreenState._ink),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: _CommunityScreenState._brandGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: _CommunityScreenState._ink,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        author,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15,
                            color: _CommunityScreenState._subtitle),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified,
                        size: 16, color: _CommunityScreenState._brandGreen),
                    const SizedBox(width: 6),
                    Text(
                      '· $minutes',
                      style: const TextStyle(
                          fontSize: 15,
                          color: _CommunityScreenState._subtitle),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.bookmark_border,
              color: _CommunityScreenState._ink, size: 24),
        ],
      ),
    );
  }
}

class _ExpertCta extends StatelessWidget {
  const _ExpertCta();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEBD8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.edit_outlined,
              size: 26, color: _CommunityScreenState._ink),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you a health expert?',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: _CommunityScreenState._ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Write for Sōlea. Every article is reviewed before it's "
                  'published.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.35,
                    color: _CommunityScreenState._subtitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _CommunityScreenState._darkGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            child: const Text('Apply'),
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
        color: _CommunityScreenState._ink,
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
          width: 56,
          height: 56,
          child: Icon(icon, size: 24, color: _CommunityScreenState._ink),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation (Community selected)
// ---------------------------------------------------------------------------

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
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
            child: _NavItem(icon: Icons.auto_awesome, label: 'Wellness hub'),
          ),
          const Expanded(
            child: _NavItem(
                icon: Icons.forest_outlined,
                label: 'Community',
                selected: true),
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
                  ? _CommunityScreenState._brandGreen
                  : Colors.transparent,
              border: selected
                  ? null
                  : Border.all(color: _CommunityScreenState._ink, width: 1.4),
            ),
            child: Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : _CommunityScreenState._ink,
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
              color: _CommunityScreenState._ink,
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
