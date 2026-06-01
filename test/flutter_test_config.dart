import 'dart:async';

import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

/// Habilita o leak_tracker (integrado ao flutter_test) para TODOS os testes
/// deste diretório: se um `testWidgets` deixar vazar um objeto descartável
/// (controller, ticker, node não liberado), o teste falha.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  LeakTesting.enable();
  LeakTesting.settings = LeakTesting.settings
      .withTrackedAll()
      .withCreationStackTrace();
  await testMain();
}
