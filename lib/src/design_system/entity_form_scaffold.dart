import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../theme/design_tokens.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_error_banner.dart';

/// Scaffold padrão dos formulários de cadastro: header com voltar, card com
/// os campos, banner de erro e botões cancelar/salvar. Centraliza o layout.
///
/// O rodapé fica no `body` (Column + Expanded), e NÃO em
/// `Scaffold.bottomNavigationBar`: este scaffold é renderizado aninhado dentro
/// do Scaffold do app_shell (rota filha do ShellRoute), e um `bottomNavigationBar`
/// aninhado recebe altura indevida e estoura o layout no mobile.
///
/// UX premium:
/// - tap em área vazia fecha o teclado;
/// - `resizeToAvoidBottomInset: true` (default) + scroll garante campos
///   visíveis sobre o teclado;
/// - banner de erro aparece/some com `AnimatedSize` + crossfade.
class EntityFormScaffold extends StatelessWidget {
  const EntityFormScaffold({
    super.key,
    required this.title,
    required this.fields,
    required this.saving,
    required this.onCancel,
    required this.onSave,
    this.errorMessage,
    this.saveLabel = 'Salvar',
    this.saveKey,
  });

  final String title;
  final List<Widget> fields;
  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String? errorMessage;
  final String saveLabel;
  final Key? saveKey;

  static const double _maxWidth = 960;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.xxl),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _maxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: onCancel,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  title,
                                  style: AppText.display.copyWith(
                                    color: cs.textPrimary,
                                    fontSize: AppText.s22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          AppCard(
                            padding: const EdgeInsets.all(AppSpacing.xxl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AnimatedSize(
                                  duration: AppMotion.normal,
                                  curve: AppMotion.curve,
                                  alignment: Alignment.topCenter,
                                  child: AnimatedSwitcher(
                                    duration: AppMotion.normal,
                                    child: errorMessage == null
                                        ? const SizedBox(
                                            key: ValueKey('no-error'),
                                            width: double.infinity,
                                          )
                                        : Padding(
                                            key: ValueKey(errorMessage),
                                            padding: const EdgeInsets.only(
                                              bottom: AppSpacing.lg,
                                            ),
                                            child: AppErrorBanner(
                                              message: errorMessage!,
                                            ),
                                          ),
                                  ),
                                ),
                                for (var i = 0; i < fields.length; i++) ...[
                                  if (i > 0)
                                    const SizedBox(height: AppSpacing.lg),
                                  fields[i],
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _StickyFooter(
                saving: saving,
                onCancel: onCancel,
                onSave: onSave,
                saveLabel: saveLabel,
                saveKey: saveKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rodapé fixo com os botões Cancelar/Salvar. Fundo `surface`, borda superior
/// fina (`cs.border`) e conteúdo centralizado respeitando a `maxWidth` do form.
class _StickyFooter extends StatelessWidget {
  const _StickyFooter({
    required this.saving,
    required this.onCancel,
    required this.onSave,
    required this.saveLabel,
    required this.saveKey,
  });

  final bool saving;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final String saveLabel;
  final Key? saveKey;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs;
    return Material(
      color: cs.surface,
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: cs.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: EntityFormScaffold._maxWidth,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Cancelar',
                        variant: AppButtonVariant.secondary,
                        onPressed: saving ? null : onCancel,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        key: saveKey,
                        label: saveLabel,
                        loading: saving,
                        onPressed: saving ? null : onSave,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
