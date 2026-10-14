# Contrato da API própria — Gerar com IA

O aplicativo nunca chama OpenAI ou Anthropic diretamente. A futura integração
usa `Flutter -> API própria via HTTPS -> provedor configurado`. Nesta etapa, o
gateway Flutter é simulado e nenhuma requisição de geração é enviada.

## Perfis disponíveis

`GET /v1/ai-generation/profiles`

```json
{
  "profiles": [
    {
      "id": "openai-economy",
      "provider": "openai",
      "label": "Econômico",
      "promptVersion": "lingo-notes-dialogue-v1"
    }
  ]
}
```

O servidor retorna somente perfis atualmente configurados. Nome real do
modelo, chave, limite interno e parâmetros do provedor não fazem parte desse
contrato.

## Solicitar geração

`POST /v1/ai-generation/generations`

```json
{
  "profileId": "openai-economy",
  "mode": "preserveText",
  "title": "At the coffee shop",
  "sourceText": "Anna: Can I have a coffee, please?",
  "sourceFileName": "coffee.md"
}
```

- `mode`: `preserveText` ou `adaptAsDialogue`;
- `sourceText`: obrigatório, sem processamento em lote e com no máximo 6.000
  caracteres;
- `sourceFileName`: opcional, apenas informativo;
- cada requisição é isolada e não possui histórico de chat.

Resposta `200`:

```json
{
  "generationId": "uuid",
  "status": "previewReady",
  "provider": "openai",
  "profileId": "openai-economy",
  "profileLabel": "Econômico",
  "promptVersion": "lingo-notes-dialogue-v1",
  "generatedAt": "2026-10-14T12:00:00Z",
  "document": {}
}
```

`document` deve cumprir integralmente o Lingo Notes Dialogue JSON v1.0. O
servidor usa a saída estruturada/JSON Schema nativa do provedor, valida também
as regras relacionais e pode fazer no máximo uma tentativa de correção com os
erros encontrados. O aplicativo valida o documento novamente antes da prévia e
do salvamento.

Resposta `422` para saída inválida após a tentativa de correção:

```json
{
  "code": "invalid_generation",
  "message": "A IA não produziu um documento válido.",
  "issues": [
    {"path": "$.lines[0].pt[0]", "message": "Referência inexistente."}
  ]
}
```

Outros códigos previstos:

- `400`: requisição ou opção inválida;
- `413`: texto acima do limite;
- `503`: perfil/provedor não configurado ou temporariamente indisponível.

O servidor não devolve a resposta bruta do provedor. O aplicativo persiste
somente o documento confirmado e os metadados `provider`, `profileId`, rótulo
do perfil, data, versão do prompt e status.
