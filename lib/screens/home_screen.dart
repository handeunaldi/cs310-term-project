import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';
import '../widgets/app_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  final List<String> _suggestions = [
    'Brunch in Moda',
    'Quiet café to work',
    'Bar for 6 friends',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String text) {
    if (text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write what you are looking for')),
      );
      return;
    }
    // For now, spots come from placeholder data
    Navigator.pushNamed(context, '/spots');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top part scrolls, so it still fits when the keyboard is open
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Column(
                  children: [
                    // Greeting and profile icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Hi, Deniz',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: colors.primary,
                            child: Text(
                              'DY',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: colors.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'What are you in the mood for?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.medium),

                    // Search field and button
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: _search,
                            decoration: const InputDecoration(
                              hintText: 'e.g. brunch in Moda',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.small),
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              _search(_searchController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                            ),
                            child: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.medium),

                    // Suggestion chips
                    Wrap(
                      spacing: AppSpacing.small,
                      runSpacing: AppSpacing.small,
                      children: _suggestions.map((text) {
                        return GestureDetector(
                          onTap: () {
                            _search(text);
                          },
                          child: Chip(label: Text(text, style: AppTextStyles.small)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            // How the app works (stays above the bottom bar)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.large),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _HowItWorksItem(
                      icon: Icons.search,
                      text: 'Search a place or vibe',
                    ),
                  ),
                  Expanded(
                    child: _HowItWorksItem(
                      icon: Icons.swap_horiz,
                      text: 'Swipe the spots you like',
                    ),
                  ),
                  Expanded(
                    child: _HowItWorksItem(
                      icon: Icons.group_outlined,
                      text: 'Decide with your crew',
                    ),
                  ),
                ],
              ),
            ),
            const AppBottomNav(currentIndex: 1),
          ],
        ),
      ),
    );
  }
}

// One small item in the "how it works" row
class _HowItWorksItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HowItWorksItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(height: AppSpacing.small),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
