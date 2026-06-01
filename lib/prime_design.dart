/// Prime Design — design system flat 2026 (Inter, marca parametrizável).
///
/// Uso típico:
/// ```dart
/// import 'package:prime_design/prime_design.dart';
///
/// MaterialApp(
///   theme: PrimeTheme.light(brand: const Color(0xFF16A34A)),
///   darkTheme: PrimeTheme.dark(brand: const Color(0xFF16A34A)),
/// );
/// ```
/// Dentro dos widgets, leia a paleta resolvida via `context.cs`.
library;

// ===== Tema =====
export 'src/theme/app_colors.dart';
export 'src/theme/app_text.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/design_tokens.dart';

// ===== Utilitários =====
export 'src/money.dart';
export 'src/masks.dart';
export 'src/ui/haptics.dart';
export 'src/services/export_service.dart';

// ===== Componentes =====
export 'src/design_system/app_badge.dart';
export 'src/design_system/app_banner.dart';
export 'src/design_system/app_button.dart';
export 'src/design_system/app_card.dart';
export 'src/design_system/app_chip.dart';
export 'src/design_system/app_circle.dart';
export 'src/design_system/app_date_field.dart';
export 'src/design_system/app_dropdown_field.dart';
export 'src/design_system/app_empty_state.dart';
export 'src/design_system/app_error_banner.dart';
export 'src/design_system/app_icon_box.dart';
export 'src/design_system/app_info_box.dart';
export 'src/design_system/app_info_tile.dart';
export 'src/design_system/app_page_header.dart';
export 'src/design_system/app_pill.dart';
export 'src/design_system/app_pressable.dart';
export 'src/design_system/app_search_field.dart';
export 'src/design_system/app_section_header.dart';
export 'src/design_system/app_skeleton.dart';
export 'src/design_system/app_stat_tile.dart';
export 'src/design_system/app_text_field.dart';
export 'src/design_system/entity_form_scaffold.dart';
export 'src/design_system/entity_picker.dart';
export 'src/design_system/export_button.dart';
export 'src/design_system/status_chip.dart';
export 'src/design_system/surface.dart';
