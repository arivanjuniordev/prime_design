# Publicando o `prime_design` no pub.dev

## Passos

1. Remova a linha `publish_to: 'none'` (e o comentário acima dela) do `pubspec.yaml`.
2. Atualize o `CHANGELOG.md` com a versão a ser publicada.
3. Rode o dry-run e corrija qualquer aviso:

   ```bash
   dart pub publish --dry-run
   ```

4. Publique de fato:

   ```bash
   dart pub publish
   ```

## Checklist de pub score

- [x] **Documentação da API** — dartdoc nos símbolos públicos (já temos).
- [x] **`example/`** — exemplo executável presente (já temos).
- [x] **LICENSE** — MIT na raiz (`LICENSE`).
- [x] **CHANGELOG.md** — entrada para a versão atual.
- [ ] **`dart analyze` limpo** — sem erros, warnings ou infos:

  ```bash
  dart analyze
  ```

- [ ] **Formatação** — `dart format .` aplicado.
- [x] **Metadados** — `description` (60–180 chars), `repository`, `issue_tracker`, `topics` no `pubspec.yaml`.

## Versionando com tags

Após publicar uma versão, crie a tag git correspondente:

```bash
git tag v0.1.0
git push origin v0.1.0
```

Use SemVer: `vMAJOR.MINOR.PATCH`. A tag deve casar com o campo `version` do `pubspec.yaml`.
