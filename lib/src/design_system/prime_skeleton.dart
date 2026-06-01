import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Bloco shimmer simples (linha, círculo, retângulo). Usa cores do tema
/// (claro/escuro automático) — nunca cores hardcoded.
class PrimeSkeletonBox extends StatelessWidget {
  /// Cria um bloco shimmer (linha, círculo ou retângulo).
  const PrimeSkeletonBox({
    super.key,
    this.width,
    this.height = 12,
    this.radius = PrimeRadius.xs,
    this.shape = BoxShape.rectangle,
  });

  /// Largura do bloco; nulo ocupa a largura disponível.
  final double? width;

  /// Altura do bloco.
  final double height;

  /// Raio de canto (ignorado quando [shape] é círculo).
  final double radius;

  /// Forma do bloco (retângulo ou círculo).
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

/// Wrapper Shimmer com cores do tema. Envolve uma árvore de [PrimeSkeletonBox].
class PrimeShimmer extends StatelessWidget {
  /// Cria um wrapper de shimmer ao redor de [child].
  const PrimeShimmer({super.key, required this.child});

  /// Árvore de widgets (geralmente [PrimeSkeletonBox]) animada pelo shimmer.
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
class PrimeSkeletonListRow extends StatelessWidget {
  /// Cria uma linha de skeleton para listagens.
  const PrimeSkeletonListRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.all(PrimeSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(PrimeRadius.md),
        border: Border.all(color: cs.border, width: 1),
      ),
      child: PrimeShimmer(
        child: Row(
          children: [
            const PrimeSkeletonBox(
              width: 44,
              height: 44,
              radius: PrimeRadius.sm,
            ),
            const SizedBox(width: PrimeSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  PrimeSkeletonBox(width: 120, height: 14),
                  SizedBox(height: PrimeSpacing.sm),
                  PrimeSkeletonBox(width: 200, height: 12),
                  SizedBox(height: PrimeSpacing.xs),
                  PrimeSkeletonBox(width: 80, height: 10),
                ],
              ),
            ),
            const PrimeSkeletonBox(
              width: 64,
              height: 22,
              radius: PrimeRadius.pill,
            ),
          ],
        ),
      ),
    );
  }
}

/// Lista de skeletons (n linhas) com padding padrão das listagens.
class PrimeSkeletonList extends StatelessWidget {
  /// Cria uma lista com [count] linhas de skeleton.
  const PrimeSkeletonList({super.key, this.count = 6});

  /// Quantidade de linhas de skeleton exibidas.
  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        PrimeSpacing.xxl,
        0,
        PrimeSpacing.xxl,
        100,
      ),
      itemCount: count,
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.only(bottom: PrimeSpacing.sm),
        child: PrimeSkeletonListRow(),
      ),
    );
  }
}

/// Skeleton para tiles do dashboard (grid 2x4 ou 4x2 de StatTile).
class PrimeSkeletonStatTile extends StatelessWidget {
  /// Cria um skeleton para um tile de estatística do dashboard.
  const PrimeSkeletonStatTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Container(
      padding: const EdgeInsets.all(PrimeSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(PrimeRadius.md),
        border: Border.all(color: cs.border, width: 1),
      ),
      child: PrimeShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: const [
            PrimeSkeletonBox(width: 32, height: 24, radius: PrimeRadius.sm),
            PrimeSkeletonBox(width: 60, height: 16),
            PrimeSkeletonBox(width: 100, height: 10),
          ],
        ),
      ),
    );
  }
}
