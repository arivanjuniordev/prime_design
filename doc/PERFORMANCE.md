# Performance — prime_design

Como o design system segue o [guia de performance do Flutter](https://docs.flutter.dev/perf)
(`best-practices`, `rendering-performance`, `faq`) e **como medir** no app que o consome.

> Princípio nº 1: **meça antes de otimizar** — sempre em *profile mode*, em **device
> físico**. Um design system não "tem performance" sozinho; ele evita os anti-padrões
> e deixa o app medir o resto.

## O que o package já garante (auditado)

| Regra do guia | Status no prime_design |
|---|---|
| Evitar `Opacity` (força `saveLayer`) | ✅ **Zero** `Opacity`. Esmaecimento via `color.withValues(alpha:)` (12 usos) — ex.: `PrimeButton` desabilitado esmaece a cor, não usa `Opacity`. |
| Evitar `saveLayer` (`ShaderMask`/`ColorFilter`/blends) | ✅ Nenhum `ShaderMask`/`ColorFilter` no código. |
| Evitar clipping; preferir `borderRadius`/`shape` | ✅ Zero `ClipPath`/`ClipRRect`/`antiAliasWithSaveLayer`. Cantos via `BorderRadius` no `BoxDecoration`. |
| Listas longas **lazy** (`.builder`) | ✅ `PrimeEntityPicker` usa `ListView.builder` (itens construídos sob demanda). |
| Evitar passes de *intrinsic* | ✅ Sem `IntrinsicHeight`/`IntrinsicWidth`. |
| `const` agressivo | ✅ `flutter_lints` ativo; construtores `const` em todos os widgets/tokens. |
| CPU pesado em **isolate** (`compute`) | ✅ `PrimeExportService` gera **PDF e Excel via `compute()`** (fora da UI thread); CSV (leve) é síncrono. |
| Respeitar *reduce motion* | ✅ `PrimeMotion.fastOf/normalOf/slowOf(context)` zera a duração quando o usuário desativa animações. |
| Não sobrescrever `operator ==` em Widget | ✅ Nenhum widget sobrescreve `==`. |

## O que **fica a cargo do app** consumidor

O package não pode decidir isso por você — siga o guia no seu app:

- **`RepaintBoundary`** em volta de gráficos/animações/itens de lista complexos.
- **`itemExtent`/`prototypeItem`** nas suas `ListView.builder` quando a altura é fixa.
- **Rebuild localizado** (`ValueListenableBuilder`/`ListenableBuilder`) em vez de `setState` no topo.
- **Imagens** decodificadas no tamanho de tela (`cacheWidth`/`cacheHeight`, `FadeInImage`).
- `build()` **puro**: nada de `NumberFormat`/`RegExp`/sort/IO dentro do build (use `PrimeMoney`/`PrimeLitros`, que têm formatters estáticos reutilizados).

## Como medir (profile mode + DevTools)

A medição se faz rodando um app real — use o `example/` ou o seu app:

```bash
cd example
flutter run --profile          # device físico de preferência
```

No DevTools → **Performance**:
1. **Timeline** — separa **UI** de **Raster** por frame. Frame > 16,67 ms (60fps) ou > 8,33 ms (120Hz) = jank.
2. **Track widget builds** — quem reconstrói demais.
3. **Highlight repaints** — o que repinta à toa (candidato a `RepaintBoundary`).
4. **Highlight oversized images** — imagens maiores que o tamanho exibido.

## Como caçar jank

Ciclo: **medir → achar o frame ruim → atacar a causa → medir de novo.** Nunca adivinhe.

- Reproduza a interação suspeita (rolagem, abrir o picker, salvar) com a Timeline gravando.
- Clique no frame vermelho: veja se o custo está em **UI** (build/layout/paint) ou **Raster** (GPU).
- UI alto → rebuild excessivo / `build()` caro. Raster alto → `saveLayer`/clip/sombra/blur.
- Telemetria contínua: `SchedulerBinding.instance.addTimingsCallback` → `FrameTiming`
  (build/raster/total), acompanhando **P50/P90/P99**, não médias.

## Métricas & metas ([perf/metrics](https://docs.flutter.dev/perf/metrics))

Acompanhe **percentis (P50/P90/P99)**, não médias — e prefira números a "achismo"
([perf/appendix](https://docs.flutter.dev/perf/appendix)).

| Métrica | Meta | Investigar |
|---|---|---|
| `buildDuration` (build na UI thread) | < 16 ms (média) | > 20 ms |
| `rasterDuration` (rasterização na GPU) | < 16 ms (média) | > 20 ms |
| P90 dos frames | < 33 ms | > 50 ms |
| 60 fps / 120 Hz | ≤ 16,67 ms / ≤ 8,33 ms por frame | acima = jank |
| Time-to-first-frame | depende do app (benchmark) | regressões vs versão anterior |
| `release_size_bytes` | auditar com `--analyze-size` | crescimento inesperado |

Telemetria contínua em produção:

```dart
SchedulerBinding.instance.addTimingsCallback((timings) {
  for (final t in timings) {
    // t.buildDuration, t.rasterDuration, t.totalSpan → agregue em P50/P90/P99
  }
});
```

## Referência completa

Guia conceitual detalhado (metodologia, pipeline, isolates, app-size, checklist):
ver `nao_mexer/flutter_perf.md` no monorepo Eco Frota, e a doc oficial em
<https://docs.flutter.dev/perf>.
