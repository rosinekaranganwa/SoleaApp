import 'package:flutter/material.dart';

import 'doctors_screen.dart';
import 'voice_screen.dart';

/// Solea "Ask Sōlea AI" chat screen.
class AskAiScreen extends StatelessWidget {
  const AskAiScreen({super.key});

  // Brand palette (kept consistent across the app).
  static const _cream = Color(0xFFECEDE7);
  static const _ink = Color(0xFF1B2A1F);
  static const _brandGreen = Color(0xFF3B6B44);
  static const _darkGreen = Color(0xFF2B4A34);
  static const _subtitle = Color(0xFF5B5F66);

  static const _suggestions = [
    'Is my cycle normal?',
    'Cramps relief',
    'Best foods this week',
  ];

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
                selected: 0,
                onDoctors: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const DoctorsScreen()),
                ),
                onHistory: () {},
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                children: [
                  const Center(child: _ContextChip()),
                  const SizedBox(height: 20),
                  const _UserBubble(
                      'Why am I so tired the week before my period?'),
                  const SizedBox(height: 16),
                  const _AiAnswerCard(),
                  const SizedBox(height: 16),
                  const _UserBubble('Can you add a lighter day to my plan?'),
                  const SizedBox(height: 16),
                  const _TypingBubble(),
                ],
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _suggestions.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (_, i) => _SuggestionChip(_suggestions[i]),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: _InputBar(
                hint: 'Ask anything about your body...',
                onMic: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VoiceScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header + tabs (shared look with the Doctors screen)
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
        const SizedBox(width: 14),
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AskAiScreen._brandGreen,
          ),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ask Sōlea',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AskAiScreen._ink,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Icon(Icons.circle, size: 9, color: AskAiScreen._brandGreen),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      'Private · end-to-end encrypted',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14, color: AskAiScreen._subtitle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _CircleButton(icon: Icons.more_vert, onTap: () {}),
      ],
    );
  }
}

/// Segmented tab control used by the Ask AI and Doctors screens.
class AskTabs extends StatelessWidget {
  const AskTabs({
    super.key,
    required this.selected,
    this.onSolea,
    this.onDoctors,
    this.onHistory,
  });

  final int selected; // 0 = Sōlea AI, 1 = Doctors, 2 = History
  final VoidCallback? onSolea;
  final VoidCallback? onDoctors;
  final VoidCallback? onHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _tab(0, Icons.auto_awesome, 'Sōlea AI', onSolea),
          _tab(1, Icons.medical_services_outlined, 'Doctors', onDoctors),
          _tab(2, Icons.history, 'History', onHistory),
        ],
      ),
    );
  }

  Widget _tab(int index, IconData icon, String label, VoidCallback? onTap) {
    final isSelected = index == selected;
    return Expanded(
      child: GestureDetector(
        onTap: isSelected ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 20,
                  color: isSelected
                      ? AskAiScreen._ink
                      : AskAiScreen._subtitle),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  color:
                      isSelected ? AskAiScreen._ink : AskAiScreen._subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip();

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
          Icon(Icons.data_usage, size: 16, color: AskAiScreen._subtitle),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'Using your cycle data · Day 24 · Luteal',
              style: TextStyle(fontSize: 15, color: AskAiScreen._ink),
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
            color: AskAiScreen._darkGreen,
            borderRadius: BorderRadius.circular(24),
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

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _AiAvatar(),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: List.generate(3, (i) {
              return Container(
                margin: EdgeInsets.only(right: i == 2 ? 0 : 8),
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AskAiScreen._subtitle,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _AiAvatar extends StatelessWidget {
  const _AiAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AskAiScreen._brandGreen,
      ),
      child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
    );
  }
}

// ---------------------------------------------------------------------------
// AI answer card
// ---------------------------------------------------------------------------

class _AiAnswerCard extends StatelessWidget {
  const _AiAnswerCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _AiAvatar(),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.45,
                      color: AskAiScreen._ink,
                    ),
                    children: [
                      TextSpan(
                          text: 'Feeling tired before your period is very '
                              'common. In the '),
                      TextSpan(
                        text: 'luteal phase',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                          text: ', progesterone rises and can make you '
                              'sleepier, and blood loss can lower iron.'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'WHAT CAN HELP',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: AskAiScreen._brandGreen,
                  ),
                ),
                const SizedBox(height: 14),
                const _CheckItem('Plan lighter workouts in the last week of '
                    'your cycle.'),
                const _CheckItem(
                    'Eat iron-rich foods: beans, leafy greens, eggs, fish.'),
                const _CheckItem('Aim for 7–9 hours of sleep; progesterone '
                    'can make you sleepier.'),
                const SizedBox(height: 16),
                const _ArticleCard(),
                const SizedBox(height: 18),
                _ActionRow(
                  icon: Icons.add,
                  label: 'Add rest day to plan',
                  onTap: () {},
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: const [
                          Icon(Icons.ramen_dining,
                              size: 22, color: AskAiScreen._ink),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Iron-rich meals',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AskAiScreen._ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const DoctorsScreen()),
                      ),
                      icon: const Icon(Icons.medical_services_outlined,
                          size: 20),
                      label: const Text('Talk to a doctor'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AskAiScreen._darkGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E4DD)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.verified_user_outlined,
                              size: 18, color: AskAiScreen._subtitle),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Reviewed by Sōlea clinicians · Not a diagnosis',
                              style: TextStyle(
                                  fontSize: 14, color: AskAiScreen._subtitle),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _FeedbackIcon(Icons.content_copy_outlined),
                    _FeedbackIcon(Icons.thumb_up_outlined),
                    _FeedbackIcon(Icons.thumb_down_outlined),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckItem extends StatelessWidget {
  const _CheckItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 22, color: AskAiScreen._ink),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                height: 1.35,
                color: AskAiScreen._ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFE9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFD6E3D2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.article_outlined,
                size: 24, color: AskAiScreen._brandGreen),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Why your energy changes across your cycle',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    color: AskAiScreen._ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Dr. Rosine K · 6 min read',
                  style: TextStyle(fontSize: 14, color: AskAiScreen._subtitle),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right,
              color: AskAiScreen._subtitle, size: 24),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
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
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, size: 24, color: AskAiScreen._ink),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AskAiScreen._ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackIcon extends StatelessWidget {
  const _FeedbackIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Icon(icon, size: 22, color: AskAiScreen._subtitle),
    );
  }
}

// ---------------------------------------------------------------------------
// Suggestion chips + input bar
// ---------------------------------------------------------------------------

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: AskAiScreen._ink),
          ),
        ),
      ),
    );
  }
}

/// Message input bar shared by the Ask AI and Doctors screens.
class AskInputBar extends StatelessWidget {
  const AskInputBar({super.key, required this.hint, this.onMic});

  final String hint;
  final VoidCallback? onMic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, size: 26, color: AskAiScreen._ink),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle:
                    const TextStyle(fontSize: 18, color: AskAiScreen._subtitle),
              ),
              style: const TextStyle(fontSize: 18, color: AskAiScreen._ink),
            ),
          ),
          IconButton(
            onPressed: onMic ?? () {},
            icon: const Icon(Icons.mic_none, size: 26, color: AskAiScreen._ink),
          ),
          const SizedBox(width: 4),
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AskAiScreen._darkGreen,
            ),
            child: const Icon(Icons.send, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

// Private alias so this screen reads naturally.
typedef _InputBar = AskInputBar;

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
          child: Icon(icon, size: 22, color: AskAiScreen._ink),
        ),
      ),
    );
  }
}
