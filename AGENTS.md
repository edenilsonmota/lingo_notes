# Lingo Notes — guia de implementação

## Contexto do produto

O nome oficial do aplicativo é **Lingo Notes**. Use esse nome em títulos, textos da interface, documentação, prompts e artefatos futuros. Não use nomes provisórios ou genéricos para o produto.

Lingo Notes é um aplicativo Android pessoal, offline-first, para estudar inglês com cadernos, textos importados, tradução alinhada, áudio TTS e vocabulário global. A interface usa Flutter e Material 3; a distribuição inicial é por APK.

Idiomas fixos da primeira versão:

- origem: inglês dos Estados Unidos (`en-US`);
- apoio: português do Brasil (`pt-BR`).

Este arquivo é a referência durável de produto, arquitetura e escopo para as próximas implementações. Os contratos executáveis complementares são:

- `lib/features/texts/domain/dialogue_parser.dart` e seus testes: validação canônica da importação v1.0;
- contratos em `lib/features/vocabulary/domain/word_lookup*.dart`: consulta individual e cache;
- modelos e contratos em cada pasta `domain/`: regras e limites entre camadas;
- `lib/app/app_database.dart`: coleções abertas pelo aplicativo;
- `pubspec.yaml`: dependências realmente adotadas pelo projeto.

Os antigos arquivos de planejamento em `context/` não são necessários para evoluir o projeto. Não criar dependência de execução ou documentação sobre eles. Ao mudar uma regra, atualizar juntos este guia, o domínio e os testes correspondentes; não enfraquecer silenciosamente contratos já aceitos.

## Escopo e limites

O MVP inclui:

- CRUD e ordenação de cadernos;
- importação e validação do Lingo Notes Dialogue JSON v1.0;
- listagem dos textos de cada caderno;
- leitor com segmentos EN/PT alinhados;
- TTS por linha e texto completo;
- consulta individual sob demanda, persistência e classificação de palavras em um vocabulário global;
- base do modo Gerar com IA, com entrada curta, prévia simulada e confirmação manual;
- funcionamento local sem conta ou servidor.

Não implementar sem um requisito posterior explícito:

- login, conta ou sincronização em nuvem;
- chaves ou chamadas diretas do aplicativo para provedores de IA;
- geração ou download de arquivos de áudio;
- gravação da voz do usuário;
- repetição espaçada ou estatísticas avançadas;
- compartilhamento público de cadernos.

A internet é usada na consulta explícita de uma palavra individual e, futuramente, na geração explicitamente iniciada pelo usuário por meio da API própria. Não traduzir textos inteiros fora desse fluxo, substituir segmentos do JSON, fazer prefetch de palavras ou iniciar outras chamadas de rede automaticamente. As funções principais precisam continuar disponíveis offline e falhas de rede nunca podem bloquear cadernos, leitura, TTS local ou vocabulário salvo.

## Estado atual

A primeira etapa está implementada:

- tela inicial responsiva com lista e estado vazio;
- criação, edição e exclusão confirmada de cadernos;
- ordenação manual, por título, criação ou atualização;
- persistência local em Isar;
- tela vazia de um caderno preparada para receber textos;
- testes das regras de ordenação e do formulário principal.

A segunda etapa também está implementada:

- seleção nativa de um único arquivo `.json`;
- parser e validação integral do Lingo Notes Dialogue JSON v1.0;
- mensagens de validação com o caminho exato do campo inválido;
- persistência do JSON original validado e metadados em uma coleção Isar;
- UUID interno do texto independente do `id` do arquivo;
- listagem dos textos dentro do caderno;
- exclusão transacional dos textos quando o caderno é excluído;
- testes de validação, garantia de não persistência e fluxo da interface.

A terceira etapa também está implementada:

- leitor de cada linha em inglês com tradução em português opcional;
- segmentos alinhados, tocáveis e destacados nos dois idiomas;
- TTS do Android por linha ou texto completo, montado somente com tokens em inglês;
- seleção de voz inglesa e controle de velocidade;
- pressão longa em palavra inglesa como ponto de integração com o vocabulário;
- regras de leitura e alinhamento no domínio, integração de TTS injetável em `data` e testes de domínio/interface.

A quarta etapa também está implementada:

- vocabulário global persistido localmente em coleção Isar própria;
- normalização de palavras e mesclagem de origens para impedir duplicatas;
- estados `unreviewed`, `learning` e `known`, com alteração rápida e filtros;
- salvamento e atualização manual do significado a partir do leitor;
- indicação visual e semântica no leitor para palavras já salvas;
- testes das regras de normalização, duplicidade, filtros, status e integração com o leitor.

A consulta individual também está implementada:

- consulta explícita por pressão longa, sem prefetch;
- tradução `en` → `pt-BR` pela API pública MyMemory;
- cache local por palavra normalizada antes de qualquer nova chamada de rede;
- estados claros de carregamento, ausência de tradução e erro de rede;
- TTS `en-US` recebe somente a palavra normalizada;
- tradução automática salva com `meaningSource = mymemory`;
- testes de normalização, cache, URLs, parsing das respostas e texto enviado ao TTS.

O MVP especificado está funcional. Não adicionar novas consultas externas, repetição espaçada, geração de áudio, integração real com provedores de IA, login ou nuvem sem novo requisito explícito.

A base do modo **Gerar com IA** está autorizada e usa somente um gateway simulado:

- entrada colada ou importada de `.txt` e `.md`, limitada a 6.000 caracteres;
- modos separados para preservar o texto ou adaptá-lo criativamente como diálogo;
- perfis simples de OpenAI e Anthropic, sem nomes de modelos ou chaves no APK;
- nova validação pelo parser canônico antes da prévia e antes do salvamento;
- edição local de título e escolha de caderno sem gerar novamente;
- persistência apenas após confirmação, com metadados locais da geração;
- contratos da futura API em `docs/ai_generation_api.md`.

Não substituir o gateway simulado por integração direta. A integração real exige uma API própria HTTPS que valide a saída e limite a correção automática a uma tentativa.

## Estrutura

```text
lib/
  main.dart                         # inicialização do Flutter e do banco
  app/
    app_database.dart               # abertura única do Isar e schemas
    lingo_notes_app.dart            # MaterialApp e tema global
  features/
    ai_generation/
      domain/                       # contratos, limites e metadados
      data/                         # simulação, arquivos e persistência Isar
      presentation/                 # entrada, prévia e confirmação
    notebooks/
      domain/                       # modelos e contratos sem Flutter/Isar
      data/                         # records e repositórios Isar
      presentation/                 # páginas, diálogos e widgets
    texts/
      domain/                       # diálogo, validação, leitura e contratos
      data/                         # arquivos, Isar e adaptação do TTS
      presentation/                 # importação, listagem e leitor EN/PT
    vocabulary/
      domain/                       # vocabulário, normalização e consulta
      data/                         # Isar, cache e clientes HTTP públicos
      presentation/                 # lista, filtros e detalhes da palavra
test/
  features/                         # testes espelhando as funcionalidades
```

Para novas funcionalidades, manter a organização `features/<feature>/{domain,data,presentation}`. Regras testáveis ficam no domínio; detalhes do Isar ficam em `data`; widgets não acessam coleções Isar diretamente.

Princípios arquiteturais obrigatórios:

- organizar primeiro por funcionalidade, evitando pastas globais genéricas que misturem domínios;
- manter `domain` independente de Flutter, Isar, plugins e detalhes de plataforma;
- definir contratos de repositório no domínio e implementações concretas em `data`;
- injetar dependências pela composição do aplicativo, permitindo testes com implementações em memória;
- manter estado e navegação simples; adicionar bibliotecas de gerenciamento de estado somente quando a complexidade real justificar;
- dividir widgets e regras quando adquirirem responsabilidades diferentes, sem criar camadas vazias;
- centralizar cada regra de negócio em uma única fonte e cobri-la com testes;
- tratar alterações de schema e persistência com migração ou compatibilidade explícita para não perder dados do usuário.

## Modelo de caderno

Todo caderno deve preservar:

- `id`: UUID interno do aplicativo, independente de IDs de arquivos importados;
- `name` e `description`;
- `colorValue`;
- `createdAt` e `updatedAt` em UTC;
- `sortMode`: `manual`, `titleAsc`, `createdAtDesc` ou `updatedAtDesc`;
- `position` para ordenação manual.

Alterações persistentes devem passar por `NotebookRepository`. Ao editar, atualizar `updatedAt`. Exclusões sempre exigem confirmação visível.

## Contrato de importação

O formato canônico é **Lingo Notes Dialogue JSON v1.0**. O documento raiz é um objeto JSON e aceita somente estes campos:

| Campo | Regra |
|---|---|
| `format` | obrigatório e exatamente `english-notebook-dialogue` |
| `version` | obrigatório e exatamente `1.0` |
| `id` | texto obrigatório e não vazio; identifica a origem, não o registro local |
| `title` | texto obrigatório e não vazio |
| `contentType` | obrigatório; somente `dialogue` ou `narrative` |
| `sourceLanguage` | obrigatório e exatamente `en-US` |
| `targetLanguage` | obrigatório e exatamente `pt-BR` |
| `level` | texto opcional |
| `tags` | lista opcional de textos não vazios e sem itens duplicados |
| `lines` | lista obrigatória com pelo menos uma linha |

`english-notebook-dialogue` é somente o identificador técnico estável do protocolo de importação. Ele deve permanecer inalterado por compatibilidade com o schema v1.0 e não representa o nome do aplicativo. O nome exibido do formato e do produto é **Lingo Notes**.

Cada linha aceita somente `id`, `speaker`, `segments`, `en` e `pt`:

- `id`, `segments`, `en` e `pt` são obrigatórios;
- `id` é um texto não vazio e único no documento;
- `speaker` é um texto não vazio opcional; omiti-lo em narrativas sem falante;
- `segments`, `en` e `pt` são listas não vazias.

Cada segmento aceita exatamente `id`, `en` e `pt`, todos obrigatórios. `en` e `pt` são textos não vazios. O ID deve corresponder a `^[A-Za-z][A-Za-z0-9_-]*$` e ser único dentro da linha.

Cada token das listas `en` e `pt` é um objeto de uma destas formas, sem propriedades adicionais:

```json
{ "segmentId": "s1" }
```

```json
{ "text": " " }
```

Regras adicionais obrigatórias:

1. Objetos raiz, linhas, segmentos e tokens rejeitam propriedades desconhecidas.
2. Todo `segmentId` usado nos tokens existe em `segments` da mesma linha e segue o mesmo padrão de ID.
3. O token contém somente `segmentId` ou somente `text`; `text` nunca é vazio.
4. Tokens são renderizados na ordem declarada em cada idioma, mesmo quando EN e PT usam ordens diferentes.
5. `text` representa espaços, pontuação ou conteúdo deliberadamente não alinhado.
6. Importações inválidas exibem todos os problemas compreensíveis com o caminho do campo e não gravam dado algum.
7. O JSON original validado é preservado integralmente e nunca é alterado ou reescrito.
8. O ID persistido do texto é um UUID gerado pelo aplicativo e não depende do `id` importado.
9. Mudanças incompatíveis exigem uma nova versão do protocolo; não reinterpretar arquivos `1.0`.

Manter testes para formato/versão, tipos, campos obrigatórios e extras, listas vazias, duplicidades, padrão dos IDs e referências inexistentes.

### Produção de conteúdo compatível

Ao gerar ou converter conteúdo para esse formato:

- retornar JSON válido, sem Markdown ou comentários;
- criar segmentos curtos que preservem uma unidade útil de sentido;
- nunca separar phrasal verbs, expressões fixas, contrações ou estruturas interdependentes;
- usar os mesmos `segmentId` em EN e PT, mas ordenar os tokens naturalmente em cada idioma;
- produzir tradução natural em português considerando a frase completa, nunca tradução mecânica palavra por palavra;
- usar tokens `text` para espaços e pontuação e verificar que toda referência aponta para um segmento da própria linha.

## Contrato do leitor e TTS

- Renderizar tokens na ordem específica de cada idioma, permitindo ordens diferentes em EN e PT.
- Um toque destaca todas as ocorrências correspondentes do mesmo `segmentId` nos dois idiomas.
- A tradução pode ser mostrada ou ocultada.
- O texto falado é exclusivamente a concatenação dos tokens `en`; IDs, marcações e português nunca são enviados ao TTS.
- Permitir TTS de uma linha e do texto inteiro, com voz inglesa e velocidade configuráveis.
- Pressão longa em uma palavra inglesa abre a consulta individual e permite salvar ou atualizar significado e origem no vocabulário.
- Testar a montagem do texto de TTS e o alinhamento de segmentos.

## Contrato do vocabulário global

Uma palavra salva vale para todos os cadernos. Persistir `word`, `normalizedWord`, `meaning`, `meaningSource`, `status`, `savedAt`, `updatedAt` e `sourceTextIds`.

Estados fixos:

- `unreviewed`: neutro;
- `learning`: vermelho;
- `known`: verde.

Normalizar maiúsculas/minúsculas, espaços repetidos, pontuação externa e variantes de apóstrofo para evitar duplicatas. Ao salvar novamente a mesma forma normalizada, preservar ID, `savedAt` e estado, atualizar `updatedAt`, manter significado anterior quando o novo estiver vazio e mesclar `sourceTextIds` sem repetição. Nunca separar phrasal verbs ou expressões quando a ação tiver sido feita sobre uma expressão completa. Não implementar repetição espaçada sem novo requisito.

## Contrato da consulta individual

- Consultar somente uma palavra inglesa normalizada e somente após ação explícita do usuário.
- Usar `https://api.mymemory.translated.net/get` com `q=<palavra>` e `langpair=en|pt-BR`; não enviar email, login ou chave.
- Não consultar serviços externos de dicionário; a pronúncia é feita pelo TTS existente.
- Consultar primeiro o cache Isar pela forma normalizada. Resultado completo em cache não gera chamada de rede nem expira automaticamente.
- Não gravar falhas como cache. Exibir separadamente carregamento, nenhum resultado e indisponibilidade de rede, permitindo tentar novamente.
- Salvar tradução automática com origem `mymemory`. O modelo deve continuar aceitando origem `manual` para correções futuras, e uma consulta automática não pode sobrescrever uma correção marcada como manual.
- O botão **Ouvir palavra** usa o TTS existente em `en-US` e envia somente a palavra normalizada.
- Respeitar o limite anônimo da MyMemory: nunca traduzir textos completos, segmentos em lote ou todas as palavras antecipadamente.
- Não usar APIs não documentadas do Google Tradutor, scraping, segredos ou chaves embutidas no APK.
- A consulta individual nunca substitui `en`/`pt` dos segmentos importados; expressões dependem do contexto original.

## Evolução futura

Estas ideias preservam a direção original do produto, mas **não autorizam implementação automática**. Só iniciar uma delas mediante pedido explícito:

1. exportar cadernos e vocabulário para backup e permitir restauração segura;
2. gerar arquivos de áudio e manter cache offline por caderno;
3. conectar o gateway de IA à API própria HTTPS, sem chaves no aplicativo;
4. criar revisão diária baseada no estado `learning`;
5. oferecer sincronização ou backup remoto opcional;
6. permitir correção manual do significado preservando sua origem.

Para qualquer evolução:

- preservar funcionamento offline das funções existentes;
- especificar comportamento de erro, cancelamento e ausência de rede;
- manter compatibilidade com dados já salvos ou criar migração explícita;
- introduzir permissões, rede e dependências somente no menor escopo necessário;
- não enviar textos, vocabulário ou outros dados pessoais sem ação e consentimento claros do usuário.

## Critério de conclusão

Uma feature só está concluída quando:

- regras ficam no domínio e integrações externas permanecem atrás de contratos injetáveis;
- estados vazio, carregando, sucesso e erro relevantes estão tratados na interface;
- dados existentes continuam legíveis e alterações de coleção Isar têm código gerado atualizado;
- testes cobrem regras novas, falhas importantes e a interação principal;
- `dart format lib test`, `flutter analyze` e `flutter test` passam;
- o fluxo principal continua utilizável sem internet;
- documentação e nomes exibidos continuam usando **Lingo Notes**.

## Convenções técnicas

- Flutter com Material 3 e foco principal em telas de celular.
- Isar Community é o banco local; records gerados usam `*.g.dart`.
- Não editar arquivos gerados manualmente. Após mudar um `@collection`, executar o gerador.
- IDs de domínio usam UUID; IDs numéricos do Isar são detalhes internos de armazenamento.
- Datas persistidas ficam em UTC.
- Textos da interface ficam em português do Brasil; conteúdo estudado mantém EN/PT.
- Evitar camadas genéricas, serviços ou dependências sem necessidade concreta.
- Manter navegação e estados de erro/vazio acessíveis e compreensíveis.

## Validação e execução

Após alterações, executar:

```bash
dart format lib test
flutter analyze
flutter test
```

Após alterar modelos Isar:

```bash
dart run build_runner build
```

Para desenvolvimento em um aparelho ou emulador Android:

```bash
flutter devices
flutter run
```

Para gerar um APK de desenvolvimento:

```bash
flutter build apk --debug
```

Antes de encerrar uma etapa, conferir que o aplicativo continua funcional sem internet e que nada do escopo explicitamente excluído foi introduzido.
