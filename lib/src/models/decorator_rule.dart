import 'package:flutter/material.dart';
import "../misc/common_regexp.dart";

class DecoratorRule {
  final RegExp regExp;
  final TextStyle style;
  final Function(String)? onTap;

  DecoratorRule({
    required this.regExp,
    required this.style,
    this.onTap,
  });

  factory DecoratorRule.word({
    required String word,
    required TextStyle style,
    Function(String)? onTap,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.word(
        word,
        caseSensitive: caseSensitive,
      ),
      onTap: onTap,
    );
  }

  factory DecoratorRule.words({
    required List<String> words,
    required TextStyle style,
    Function(String)? onTap,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.words(
        words,
        caseSensitive: caseSensitive,
      ),
      onTap: onTap,
    );
  }

  factory DecoratorRule.url({
    required TextStyle style,
    required Function(String) onTap,
    bool looseUrl = true,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.url(
        looseUrl: looseUrl,
      ),
      onTap: (match) {
        String url = match;
        if (!match.startsWith("http://") && !match.startsWith("https://")) {
          url = "https://$url";
        }
        if (url.endsWith(".")) {
          url = url.substring(0, url.length - 1);
        }
        onTap(url);
      },
    );
  }

  factory DecoratorRule.startsWith({
    required String text,
    required TextStyle style,
    Function(String)? onTap,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.startsWith(
        text,
        caseSensitive: caseSensitive,
      ),
      onTap: onTap,
    );
  }

  factory DecoratorRule.between({
    required String start,
    required String end,
    required TextStyle style,
    Function(String)? onTap,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.between(
        start: start,
        end: end,
        caseSensitive: caseSensitive,
      ),
      onTap: onTap,
    );
  }
}
