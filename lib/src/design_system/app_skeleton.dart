import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

/// Bloco shimmer simples (linha, círculo, retângulo). Usa cores do tema
/// (claro/escuro automático) — nunca cores hardcoded.
class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    super.key,
    this.width,
    this.height = 12,
    this.radius = AppRadius.xs,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double height;
  final double radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.surface,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(radius)
            : null,
      ),
    );
  }
}

/// Wrapper Shimmer com cores do tema. Envolve uma árvore de [AppSkeletonBox].
class AppShimmer extends StatelessWidget {
  const AppShimmer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark
          ? cs.surface.withValues(alpha: 0.6)
          : cs.border.withValues(alpha: 0.35),
      highlightColor: isDark ? cs.surface.withValues(alpha: 0.9) : cs.surface,
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

/// Skeleton de linha de lista (card com ícone + texto). Padrão das listagens.
class AppSkeletonListRow extends StatelessWidget {
  const AppSkeletonListRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: cs.border, width: 1),
      ),
      child: AppShimmer(
        child: Row(
          children: [
            const AppSkeletonBox(width: 44, height: 44, radius: AppRadius.sm),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AppSkeletonBox(width: 120, height: 14),
                  SizedBox(height: AppSpacing.sm),
                  AppSkeletonBox(width: 200, height: 12),
                  SizedBox(height: AppSpacing.xs),
                  AppSkeletonBox(width: 80, height: 10),
                ],
              ),
            ),
            const AppSkeletonBox(width: 64, height: 22, radius: AppRadius.pill),
          ],
        ),
      ),
    );
  }
}

/// Lista de skeletons (n linhas) com padding padrão das listagens.
class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({super.key, this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl,
        0,
        AppSpacing.xxl,
        100,
      ),
      itemCount: count,
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.only(bottom: AppSpacing.sm),
        child: AppSkeletonListRow(),
      ),
    );
  }
}

/// Skeleton para tiles do dashboard (grid 2x4 ou 4x2 de StatTile).
class AppSkeletonStatTile extends StatelessWidget {
  const AppSkeletonStatTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: cs.border, width: 1),
      ),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppSkeletonBox(width: 32, height: 24, radius: AppRadius.sm),
            AppSkeletonBox(width: 60, height: 16),
            AppSkeletonBox(width: 100, height: 10),
          ],
        ),
      ),
    );
  }
}
