class SpeechVoice {
  const SpeechVoice({required this.name, required this.locale});

  final String name;
  final String locale;

  @override
  bool operator ==(Object other) {
    return other is SpeechVoice && other.name == name && other.locale == locale;
  }

  @override
  int get hashCode => Object.hash(name, locale);
}

abstract interface class TextToSpeech {
  Future<List<SpeechVoice>> getEnglishVoices();

  Future<void> speak(String text, {required double rate, SpeechVoice? voice});

  Future<void> stop();
}
