# Changelog

## 0.2.0

- **PrimeStyles**: tokens responsivos (`context.styles`) que escalam espaçamento
  e tipografia por tamanho de tela (fator 1.0/1.1/1.2), inspirado no Wonderous.
- **PrimeReveal** / `PrimeReveal.stagger`: animação de entrada (fade + slide)
  reutilizável, respeitando reduce-motion.
- **Primitivos de layout/render** (inspirados no Wonderous): `PrimeLazyIndexedStack`
  (abas/páginas lazy), `PrimeMeasurable` (mede o filho), `PrimeIgnorePointerKeepSemantics`
  / `PrimeIgnorePointerAndSemantics` (acessibilidade).
- **Acessibilidade**: cores semânticas (success/warning/info) escurecidas para
  contraste WCAG AA com texto branco em badges sólidos.
- **Qualidade**: leak tracking (leak_tracker) em todos os widget tests e
  property-based testing (glados) na camada de lógica.
- Package neutro (sem marca específica) e performance medida no example.

## 0.1.0

- Versão inicial: tema `PrimeTheme` com cor de marca parametrizável
  (`PrimeColors` via `ThemeExtension`), tokens, fonte Inter bundlada e
  ~26 componentes.
