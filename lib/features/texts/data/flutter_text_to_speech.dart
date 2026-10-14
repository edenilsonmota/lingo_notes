import 'package:flutter_tts/flutter_tts.dart';

import '../domain/text_to_speech.dart';

class FlutterTextToSpeech implements TextToSpeech {
  FlutterTextToSpeech([FlutterTts? flutterTts])
    : _flutterTts = flutterTts ?? FlutterTts();

  final FlutterTts _flutterTts;
  bool _configured = false;

  Future<void> _configure() async {
    if (_configured) return;
    await _flutterTts.awaitSpeakCompletion(true);
    _configured = true;
  }

  @override
  Future<List<SpeechVoice>> getEnglishVoices() async {
    final dynamic available = await _flutterTts.getVoices;
    if (available is! List<dynamic>) return const [];

    final voices = <SpeechVoice>{};
    for (final voice in available) {
      if (voice is! Map<dynamic, dynamic>) continue;
      final name = voice['name'];
      final locale = voice['locale'];
      if (name is! String || locale is! String) continue;
      if (!locale.toLowerCase().startsWith('en')) continue;
      voices.add(SpeechVoice(name: name, locale: locale));
    }

    final sorted = voices.toList()
      ..sort((a, b) {
        final localeComparison = a.locale.compareTo(b.locale);
        return localeComparison != 0
            ? localeComparison
            : a.name.compareTo(b.name);
      });
    return sorted;
  }

  @override
  Future<void> speak(
    String text, {
    required double rate,
    SpeechVoice? voice,
  }) async {
    await _configure();
    await _flutterTts.stop();
    await _flutterTts.setLanguage(voice?.locale ?? 'en-US');
    await _flutterTts.setSpeechRate(rate);
    if (voice != null) {
      await _flutterTts.setVoice({'name': voice.name, 'locale': voice.locale});
    }
    await _flutterTts.speak(text, focus: true);
  }

  @override
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
