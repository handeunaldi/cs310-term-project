import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';

class AuthHeader extends StatelessWidget {
  final String subtitle;

  const AuthHeader({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.location_on_outlined, color: colors.onPrimary),
            ),
            const SizedBox(width: AppSpacing.small),

            const Flexible(
              child: Text('Places to go', style: AppTextStyles.appTitle),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle.copyWith(color: colors.onSurfaceVariant),
        ),
      ],
    );
  }
}