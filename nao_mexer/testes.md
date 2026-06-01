Memory leaks

Property-based testing




Ao gerar testes para este package Flutter, siga estas regras:

* NÃO crie testes apenas para aumentar cobertura.
* Crie testes somente quando houver comportamento de negócio, lógica, estado ou contrato público relevante a validar.
* Evite testar getters, setters, construtores simples, widgets passivos ou código sem lógica.
* Não escreva testes que apenas reproduzem a implementação interna.
* Priorize testes que detectariam regressões reais para usuários do package.
* Para componentes visuais, teste apenas comportamentos observáveis, interações, estados e acessibilidade.
* Se um componente for puramente apresentacional e não possuir lógica relevante, explique por que um teste não é necessário.
* Antes de criar qualquer teste, responda:

  1. Qual comportamento importante está sendo validado?
  2. Qual regressão este teste impediria?
  3. O teste valida uma regra pública ou apenas a implementação interna?
* Se a resposta da pergunta 3 for "implementação interna", não crie o teste.
* Prefira poucos testes de alto valor em vez de muitos testes de baixo valor.
* Nunca gere mocks, fixtures ou testes artificiais sem uma necessidade clara.
* Quando não houver comportamento relevante para validar, informe explicitamente que nenhum teste adicional é recomendado.
