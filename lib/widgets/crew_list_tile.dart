import 'package:flutter/material.dart';

import '../models/crew.dart';
import '../theme/app_spacing.dart';
import '../theme/text_styles.dart';

class CrewListTile extends StatelessWidget {
  final Crew crew;
  final int index;
  final VoidCallback? onTap;
  final IconData trailingIcon;

  const CrewListTile({
    super.key,
    required this.crew,
    required this.index,
    this.onTap,
    this.trailingIcon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accent = index.isEven
        ? const Color(0xFFE8AD48)
        : const Color(0xFF60A982);
    final tileColor = Color.alphaBlend(
      accent.withValues(alpha: 0.27),
      colors.surface,
    );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSpacing.small / 2,
      ),
      leading: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          crew.letter,
          style: AppTextStyles.label.copyWith(color: colors.onSurface),
        ),
      ),
      title: Text(crew.name, style: AppTextStyles.label),
      subtitle: Text(crew.summary, style: AppTextStyles.small),
      trailing: onTap == null
          ? null
          : Icon(trailingIcon, color: colors.onSurfaceVariant),
      onTap: onTap,
    );
  }
}
