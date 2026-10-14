# Lingo Notes

Aplicativo Android offline-first para estudar inglês com textos bilíngues, áudio e vocabulário pessoal.

## Funcionalidades

- criação e organização de cadernos;
- importação de textos no formato Lingo Notes Dialogue JSON v1.0;
- leitura alinhada em inglês e português;
- destaque de segmentos equivalentes nos dois idiomas;
- reprodução em inglês pelo TTS do Android;
- vocabulário global com significado e estados de aprendizagem;
- persistência local, sem necessidade de conta ou servidor.

## Tecnologias

- Flutter e Material 3;
- Isar Community para persistência local;
- `flutter_tts` para síntese de voz;
- testes de domínio e interface com Flutter Test.

## Executar o projeto

Com Flutter e um dispositivo ou emulador Android configurados:

```bash
flutter pub get
flutter run
```

Para validar o projeto:

```bash
flutter analyze
flutter test
```

Para gerar um APK de desenvolvimento:

```bash
flutter build apk --debug
```

## Arquitetura

O código é organizado por funcionalidade em `lib/features`, separando regras de domínio, persistência e apresentação. As decisões e os contratos para futuras implementações estão documentados em `AGENTS.md`.
