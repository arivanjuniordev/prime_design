import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';
import '../theme/design_tokens.dart';

class PrimeErrorBanner extends StatelessWidget {
  const PrimeErrorBanner({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(PrimeSpacing.md),
          decoration: BoxDecoration(
            color: PrimePalette.error.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(PrimeRadius.md),
            border: Border.all(color: PrimePalette.error.withValues(alpha: 0.30)),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: PrimePalette.error, size: 20),
              const SizedBox(width: PrimeSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: PrimePalette.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
        // Shake leve + fade-in: chama atenção sem ser invasivo.
        .animate()
        .fadeIn(duration: PrimeMotion.normal)
        .shake(hz: 4, offset: const Offset(2, 0), duration: 350.ms);
  }
}
