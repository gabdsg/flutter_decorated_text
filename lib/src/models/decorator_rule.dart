import 'package:flutter/material.dart';
import "../misc/common_regexp.dart";

class DecoratorRule {
  final RegExp regExp;
  final TextStyle style;
  final Function(String)? onTap;
  final String Function(String)? transformMatch;
  final Widget Function(String)? leadingBuilder;
  final Widget Function(String)? trailingBuilder;
  final Widget Function(Widget, String)? builder;

  DecoratorRule({
    required this.regExp,
    required this.style,
    this.onTap,
    this.transformMatch,
    this.leadingBuilder,
    this.trailingBuilder,
    this.builder,
  });

  factory DecoratorRule.word({
    required String word,
    required TextStyle style,
    Function(String)? onTap,
    Widget Function(Widget, String)? builder,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.word(
        word,
        caseSensitive: caseSensitive,
      ),
      builder: builder,
      onTap: onTap,
    );
  }

  factory DecoratorRule.words({
    required List<String> words,
    required TextStyle style,
     Widget Function(Widget, String)? builder,
    Function(String)? onTap,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.words(
        words,
        caseSensitive: caseSensitive,
      ),
      builder: builder,
      onTap: onTap,
    );
  }

  factory DecoratorRule.email({
    required TextStyle style,
    required Function(String) onTap,
     Widget Function(Widget, String)? builder,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.email(),
      builder: builder,
      onTap: (match) {
        String url = match;
        if (!match.startsWith("mailto:")) {
          url = "mailto:$url";
        }
        onTap(url);
      },
      transformMatch: (match) {
        return match;
      },
    );
  }

  factory DecoratorRule.url({
    required TextStyle style,
    required Function(String) onTap,
    Widget Function(Widget, String)? builder,
    bool looseUrl = true,
    bool humanize = false,
    bool removeWww = false,
  }) {
    return DecoratorRule(
        style: style,
        regExp: CommonRegExp.url(
          looseUrl: looseUrl,
        ),
        builder: builder,
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
        transformMatch: (match) {
          if (humanize) {
            String url = match;
            url = url.replaceFirst(RegExp('https?://'), '');
            if (url.endsWith("/")) {
              url = url.substring(0, url.length - 1);
            }
            if (removeWww) {
              url = url.replaceFirst(RegExp(r'www\.'), '');
            }
            return url;
          }
          return match;
        });
  }

  factory DecoratorRule.startsWith({
    required String text,
    required TextStyle style,
    Function(String)? onTap,
    Widget Function(Widget, String)? builder,
    bool caseSensitive = false,
  }) {
    return DecoratorRule(
      style: style,
      regExp: CommonRegExp.startsWith(
        text,
        caseSensitive: caseSensitive,
      ),
      builder: builder,
      onTap: onTap,
    );
  }

  factory DecoratorRule.between({
    required String start,
    required String end,
    required TextStyle style,
    Function(String)? onTap,
    Widget Function(Widget, String)? builder,
    bool removeMatchingCharacters = false,
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
      builder: builder,
      transformMatch: (match) {
        if (removeMatchingCharacters) {
          String res = match;
          res = res.replaceFirst(start, "");
          res = res.replaceFirst(end, "");
          return res;
        }
        return match;
      },
    );
  }
}
