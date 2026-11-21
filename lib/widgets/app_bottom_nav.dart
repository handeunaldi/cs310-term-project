import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

// Bottom bar used in Home and Profile (Explore will use it too)
// 0 = Explore, 1 = Home, 2 = Profile
class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.small),
      child: Row(
        children: [
          Expanded(
            child: _NavItem(
              icon: Icons.explore_outlined,
              label: 'Explore',
              selected: currentIndex == 0,
              onTap: () {
                // Explore screen is not ready yet
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Explore is coming soon')),
                );
              },
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: currentIndex == 1,
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: currentIndex == 2,
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// One button in the bottom bar
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final void Function() onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // The selected item is red with white text, like in the wireframe
    final background = selected ? colors.primary : colors.surface;
    final foreground = selected ? colors.onPrimary : Colors.grey;

    return GestureDetector(
      onTap: () {
        // Tapping the screen we are already on does nothing
        if (!selected) {
          onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: foreground),
            Text(label, style: TextStyle(fontSize: 12, color: foreground)),
          ],
        ),
      ),
    );
  }
}
