# Medição de performance (scroll)

Harness de `integration_test` + `flutter_driver` que mede o desempenho de
scroll de uma lista com 200 `PrimeCard`s (cada um com um `PrimeInfoTile`).

## Arquivos

- `integration_test/perf_scroll_test.dart` — monta o app e mede o timeline de
  frames durante uma sequência de flings (`binding.traceAction`,
  `reportKey: 'scrolling_timeline'`).
- `test_driver/perf_driver.dart` — recebe o timeline e escreve o summary.

## Como rodar (emulador / device físico)

Sempre em **`--profile`** (modo debug não reflete a performance real):

```bash
# liste os devices disponíveis
flutter devices

# rode o harness apontando para o emulador (ex.: emulator-5554)
flutter drive \
  --driver=test_driver/perf_driver.dart \
  --target=integration_test/perf_scroll_test.dart \
  --profile --no-dds -d <emulador>
```

> Rode a partir da pasta `example/`. Antes do primeiro uso: `flutter pub get`.
> `--no-dds` é **obrigatório** em device/emulador (senão o `traceAction` falha
> com "Failed to connect to VM Service"). Doc oficial:
> <https://docs.flutter.dev/cookbook/testing/integration/profiling>.

## Saída

O driver gera, na pasta `build/` do `example/`:

- `build/scrolling_timeline.timeline.json` — timeline bruto (eventos de trace).
- `build/scrolling_timeline.timeline_summary.json` — **métricas agregadas** (o
  arquivo que interessa).

## Como ler o summary

Abra `build/scrolling.timeline_summary.json`. Campos principais (tempos em ms):

| Chave | O que mede | Alvo (60fps) |
| --- | --- | --- |
| `average_frame_build_time_millis` | tempo médio de build da UI thread por frame | < 16.6 |
| `90th_percentile_frame_build_time_millis` | p90 do build | < 16.6 |
| `99th_percentile_frame_build_time_millis` | p99 do build (piores frames) | < 16.6 |
| `worst_frame_build_time_millis` | pior frame de build | — |
| `average_frame_rasterizer_time_millis` | tempo médio da GPU/raster thread por frame | < 16.6 |
| `90th_percentile_frame_rasterizer_time_millis` | p90 do raster | < 16.6 |
| `99th_percentile_frame_rasterizer_time_millis` | p99 do raster | < 16.6 |
| `worst_frame_rasterizer_time_millis` | pior frame de raster | — |
| `missed_frame_build_budget_count` | nº de frames de UI que estouraram o orçamento | 0 |
| `missed_frame_rasterizer_budget_count` | nº de frames de raster que estouraram | 0 |
| `frame_count` | total de frames medidos | — |

Regra de bolso: num device a 60fps cada frame tem ~16.6 ms de orçamento.
`build` acima desse valor = jank na UI thread; `rasterizer` acima = jank na GPU.
Os percentis `90th`/`99th` mostram a cauda (os piores frames), normalmente mais
reveladores que a média. Em telas de 90/120 Hz o orçamento cai para ~11.1/8.3 ms.
