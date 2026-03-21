// ignore: avoid_classes_with_only_static_members
class CommonRegExp {
  static final Map<String, RegExp> _cache = {};

  static RegExp word(
    String word, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    final pattern = "\\b($word)\\b";
    final key = '$pattern|$caseSensitive|$multiLine';
    return _cache.putIfAbsent(
      key,
      () => RegExp(pattern, caseSensitive: caseSensitive, multiLine: multiLine),
    );
  }

  static RegExp words(
    List<String> words, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    final pattern = "\\b(${words.join("|")})\\b";
    final key = '$pattern|$caseSensitive|$multiLine';
    return _cache.putIfAbsent(
      key,
      () => RegExp(pattern, caseSensitive: caseSensitive, multiLine: multiLine),
    );
  }

  static final _emailRegex = RegExp(
    r'((mailto:)?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z][A-Z]+)',
    caseSensitive: false,
    dotAll: true,
    multiLine: true,
  );

  static RegExp email() => _emailRegex;

  static final _urlRegex = RegExp(
    r'((?:https?:\/\/|www\.)[^\s/$.?#].[^\s]*)',
    caseSensitive: false,
    dotAll: true,
    multiLine: true,
  );

  static final _looseUrlRegex = RegExp(
    r'((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%_\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+~#?&//=]*))',
    caseSensitive: false,
    dotAll: true,
    multiLine: true,
  );

  static RegExp url({bool looseUrl = false}) {
    return looseUrl ? _looseUrlRegex : _urlRegex;
  }

  static RegExp startsWith(
    String text, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    const String backslash = r'\';
    final pattern = "$backslash$text(\\S+)";
    final key = '$pattern|$caseSensitive|$multiLine';
    return _cache.putIfAbsent(
      key,
      () => RegExp(pattern, caseSensitive: caseSensitive, multiLine: multiLine),
    );
  }

  static RegExp between({
    required String start,
    required String end,
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    const String backslash = r'\';
    final pattern = "$backslash$start(.*?)$backslash$end";
    final key = '$pattern|$caseSensitive|$multiLine';
    return _cache.putIfAbsent(
      key,
      () => RegExp(pattern, caseSensitive: caseSensitive, multiLine: multiLine),
    );
  }
}
