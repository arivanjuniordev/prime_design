import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_badge.dart';

/// Mapeia status textuais comuns da frota pra cores semânticas e renderiza
/// um AppBadge. Centraliza a paleta de status pra toda a app.
class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});
  final String status;

  static Color colorFor(String status) {
    switch (status.toLowerCase()) {
      case 'ativo':
      case 'concluida':
      case 'pago':
      case 'valido':
        return AppColors.success;
      case 'manutencao':
      case 'agendada':
      case 'em_andamento':
      case 'pendente':
      case 'planejada':
      case 'afastado':
      case 'recorrido':
        return AppColors.warning;
      case 'inativo':
      case 'cancelado':
      case 'cancelada':
      case 'vencido':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  static String labelFor(String status) => status.replaceAll('_', ' ');

  @override
  Widget build(BuildContext context) {
    // Cor sozinha não é acessível (depende de visão de cor). Anuncia o status
    // textualmente e exclui o texto UPPERCASE do badge para não ler duplicado.
    return Semantics(
      label: 'Status: ${labelFor(status)}',
      container: true,
      child: ExcludeSemantics(
        child: AppBadge(text: labelFor(status), color: colorFor(status)),
      ),
    );
  }
}
