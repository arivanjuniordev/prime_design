import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/prime_colors.dart';
import '../theme/prime_tokens.dart';

/// Estado vazio centralizado com ícone, título, descrição e ação opcionais,
/// animados na entrada (scale + fade).
class PrimeEmptyState extends StatelessWidget {
  /// Cria um estado vazio com [title] e elementos opcionais.
  const PrimeEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  /// Título principal exibido abaixo do ícone.
  final String title;

  /// Descrição secundária opcional.
  final String? description;

  /// Ícone exibido no topo (default: caixa de entrada).
  final IconData icon;

  /// Widget de ação opcional (ex.: botão) exibido no rodapé.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PrimeSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: cs.textMuted)
                .animate()
                .scale(
                  duration: 300.ms,
                  curve: Curves.easeOutBack,
                  begin: const Offset(0.8, 0.8),
                )
                .fadeIn(),
            const SizedBox(height: PrimeSpacing.lg),
            Text(title, style: Theme.of(context).textTheme.titleMedium)
                .animate()
                .fadeIn(delay: 80.ms, duration: 250.ms)
                .slideY(begin: 0.2, end: 0),
            if (description != null) ...[
              const SizedBox(height: PrimeSpacing.sm),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: cs.textSecondary),
              ).animate().fadeIn(delay: 140.ms, duration: 250.ms),
            ],
            if (action != null) ...[
              const SizedBox(height: PrimeSpacing.xxl),
              action!.animate().fadeIn(delay: 220.ms, duration: 250.ms),
            ],
          ],
        ),
      ),
    );
  }
}
