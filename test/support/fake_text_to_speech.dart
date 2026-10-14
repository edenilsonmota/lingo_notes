import 'package:lingo_notes/features/texts/domain/text_to_speech.dart';

class SpeechCall {
  const SpeechCall({required this.text, required this.rate, this.voice});

  final String text;
  final double rate;
  final SpeechVoice? voice;
}

class FakeTextToSpeech implements TextToSpeech {
  FakeTextToSpeech({
    this.voices = const [SpeechVoice(name: 'Test Voice', locale: 'en-US')],
  });

  final List<SpeechVoice> voices;
  final calls = <SpeechCall>[];
  int stopCount = 0;

  @override
  Future<List<SpeechVoice>> getEnglishVoices() async => voices;

  @override
  Future<void> speak(
    String text, {
    required double rate,
    SpeechVoice? voice,
  }) async {
    calls.add(SpeechCall(text: text, rate: rate, voice: voice));
  }

  @override
  Future<void> stop() async {
    stopCount++;
  }
}
