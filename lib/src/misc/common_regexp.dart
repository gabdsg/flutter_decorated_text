class CommonRegExp {
  static RegExp word(
    String word, {
    bool caseSensitive = false,
    bool multiLine = true,
  }) {
    return RegExp(
      r"\b(" + word + r")\b",
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
}