# Lingo Notes — guia de implementação

## Contexto do produto

O nome oficial do aplicativo é **Lingo Notes**. Use esse nome em títulos, textos da interface, documentação, prompts e artefatos futuros. Não use nomes provisórios ou genéricos para o produto.

Lingo Notes é um aplicativo Android pessoal, offline-first, para estudar inglês com cadernos, textos importados, tradução alinhada, áudio TTS e vocabulário global. A interface usa Flutter e Material 3; a distribuição inicial é por APK.

Idiomas fixos da primeira versão:

- origem: inglês dos Estados Unidos (`en-US`);
- apoio: português do Brasil (`pt-BR`).

As fontes de verdade do produto estão em:

- `context/lingo_notes_app_spec.md`: requisitos, escopo e etapas;
- `context/lingo_notes_dialogue.schema.json`: schema canônico de importação.

Leia os dois arquivos antes de alterar regras de domínio, importação, leitor, TTS ou vocabulário. Uma nova implementação não deve enfraquecer as validações do schema.

## Escopo e limites

O MVP inclui:

- CRUD e ordenação de cadernos;
- importação e validação do Lingo Notes Dialogue JSON v1.0;
- listagem dos textos de cada caderno;
- leitor com segmentos EN/PT alinhados;
- TTS por linha e texto completo;
- consulta e persistência de palavras em um vocabulário global;
- funcionamento local sem conta ou servidor.

Não implementar sem um requisito posterior explícito:

- login, conta ou sincronização em nuvem;
- IA dentro do aplicativo;
- geração ou download de arquivos de áudio;
- gravação da voz do usuário;
- repetição espaçada ou estatísticas avançadas;
- compartilhamento público de cadernos.

A internet só poderá ser usada futuramente por uma ação explícita do usuário para dicionário, tradução ou IA. As funções principais precisam continuar disponíveis offline.

## Estado atual

A primeira etapa está implementada:

- tela inicial responsiva com lista e estado vazio;
- criação, edição e exclusão confirmada de cadernos;
- ordenação manual, por título, criação ou atualização;
- persistência local em Isar;
- tela vazia de um caderno preparada para receber textos;
- testes das regras de ordenação e do formulário principal.

Ainda não existem importação, leitor, TTS ou vocabulário. Não simule essas funções nem conecte APIs externas antes das etapas correspondentes.

## Estrutura

```text
lib/
  main.dart                         # inicialização do Flutter e do banco
  app/
    lingo_notes_app.dart            # MaterialApp e tema global
  features/
    notebooks/
      domain/                       # modelos e contratos sem Flutter/Isar
      data/                         # records e repositórios Isar
      presentation/                 # páginas, diálogos e widgets
context/                            # especificação e schema fornecidos
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

## Contrato de importação — próxima etapa

O formato aceito deve ser exatamente `english-notebook-dialogue`, versão `1.0`. Exigir `id`, `title`, `contentType`, `sourceLanguage`, `targetLanguage` e ao menos uma linha.

`english-notebook-dialogue` é somente o identificador técnico estável do protocolo de importação. Ele deve permanecer inalterado por compatibilidade com o schema v1.0 e não representa o nome do aplicativo. O nome exibido do formato e do produto é **Lingo Notes**.

Regras obrigatórias:

1. `contentType` aceita apenas `dialogue` ou `narrative`.
2. `sourceLanguage` é `en-US` e `targetLanguage` é `pt-BR`.
3. IDs de linha são únicos no arquivo.
4. IDs de segmento são únicos dentro de cada linha.
5. Todo `segmentId` usado nos tokens `en` ou `pt` existe em `segments` da mesma linha.
6. Cada token contém somente `segmentId` ou somente `text`.
7. Importações inválidas mostram erros compreensíveis e não gravam nenhum dado.
8. O arquivo original nunca é alterado.
9. O ID persistido do texto é gerado pelo aplicativo e não depende do `id` importado.

Criar testes para formato/versão, obrigatórios, duplicidades e referências inexistentes antes de considerar a importação concluída.

## Contrato do leitor e TTS

- Renderizar tokens na ordem específica de cada idioma, permitindo ordens diferentes em EN e PT.
- Um toque destaca todas as ocorrências correspondentes do mesmo `segmentId` nos dois idiomas.
- A tradução pode ser mostrada ou ocultada.
- O texto falado é exclusivamente a concatenação dos tokens `en`; IDs, marcações e português nunca são enviados ao TTS.
- Permitir TTS de uma linha e do texto inteiro, com voz inglesa e velocidade configuráveis.
- Pressão longa em uma palavra inglesa deve expor a ação futura de consultar/salvar no vocabulário.
- Testar a montagem do texto de TTS e o alinhamento de segmentos.

## Contrato do vocabulário global

Uma palavra salva vale para todos os cadernos. Persistir `word`, `normalizedWord`, `meaning`, `status`, `savedAt`, `updatedAt` e `sourceTextIds`.

Estados fixos:

- `unreviewed`: neutro;
- `learning`: vermelho;
- `known`: verde.

Normalizar maiúsculas/minúsculas, espaços e pontuação externa para evitar duplicatas. Nunca separar phrasal verbs ou expressões quando a ação tiver sido feita sobre uma expressão completa. Não implementar repetição espaçada nesta fase.

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
