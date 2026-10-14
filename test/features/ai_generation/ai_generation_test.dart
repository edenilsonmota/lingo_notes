import 'package:flutter_test/flutter_test.dart';
import 'package:lingo_notes/features/ai_generation/data/simulated_ai_generation_gateway.dart';
import 'package:lingo_notes/features/ai_generation/domain/ai_generation.dart';
import 'package:lingo_notes/features/ai_generation/domain/update_generated_dialogue_title.dart';

void main() {
  test('rejeita entrada acima de 6.000 caracteres', () {
    expect(
      () => AiGenerationRequest(
        profileId: 'profile',
        mode: AiConversionMode.preserveText,
        title: 'Título',
        sourceText: List.filled(6001, 'a').join(),
      ),
      throwsA(isA<AiGenerationInputException>()),
    );
  });

  test('contrato enviado não contém modelo nem chave', () {
    final json = AiGenerationRequest(
      profileId: 'openai-economy',
      mode: AiConversionMode.preserveText,
      title: 'Coffee',
      sourceText: 'Hello.',
    ).toApiJson();

    expect(json['profileId'], 'openai-economy');
    expect(json['mode'], 'preserveText');
    expect(json, isNot(contains('model')));
    expect(json, isNot(contains('apiKey')));
  });

  test('modo preservar reconhece falante existente', () async {
    final gateway = SimulatedAiGenerationGateway(
      now: () => DateTime.utc(2026, 10, 14),
    );
    final result = await gateway.generate(
      AiGenerationRequest(
        profileId: 'openai-economy',
        mode: AiConversionMode.preserveText,
        title: 'Greeting',
        sourceText: 'Anna: Hello!\nBen: Hi!',
      ),
    );

    expect(result.document.contentType.name, 'dialogue');
    expect(result.document.lines.first.speaker, 'Anna');
    expect(result.document.lines.last.speaker, 'Ben');
  });

  test('modo preservar não transforma narrativa em conversa', () async {
    final gateway = SimulatedAiGenerationGateway();
    final result = await gateway.generate(
      AiGenerationRequest(
        profileId: 'anthropic-quality',
        mode: AiConversionMode.preserveText,
        title: 'Morning',
        sourceText: 'The sun rose over the quiet city.',
      ),
    );

    expect(result.document.contentType.name, 'narrative');
    expect(result.document.lines.single.speaker, isNull);
  });

  test('alterar título reutiliza e revalida o JSON da prévia', () async {
    final gateway = SimulatedAiGenerationGateway();
    final result = await gateway.generate(
      AiGenerationRequest(
        profileId: 'openai-economy',
        mode: AiConversionMode.preserveText,
        title: 'Antes',
        sourceText: 'Hello.',
      ),
    );

    final updated = updateGeneratedDialogueTitle(
      sourceJson: result.sourceJson,
      title: 'Depois',
    );

    expect(updated, contains('Depois'));
    expect(updated, contains(result.document.sourceId));
  });
}
