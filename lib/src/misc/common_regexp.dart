// ignore: avoid_classes_with_only_static_members
class CommonRegExp {
  static RegExp word(
    String word, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    return RegExp(
      "\\b($word)\\b",
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    );
  }

  static RegExp words(
    List<String> words, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    return RegExp(
      "\\b(${words.join("|")})\\b",
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    );
  }

  static final _urlRegex = RegExp(
    r'((?:https?:\/\/|www\.)[^\s/$.?#].[^\s]*)',
    caseSensitive: false,
    dotAll: true,
    multiLine: true,
  );

  static final _looseUrlRegex = RegExp(
    r'((https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*))',
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
    final String backslash = r'\';
    return RegExp(
      "$backslash$text(\\S+)",
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    );
  }

  static RegExp between({
    required String start,
    required String end,
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    final String backslash = r'\';
    return RegExp(
      "$backslash$start(.*?)$backslash$end",
      caseSensitive: caseSensitive,
      multiLine: multiLine,
    );
  }
}
