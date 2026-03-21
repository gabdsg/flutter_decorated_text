import 'package:flutter/material.dart' hide Decoration;

import '../models/decoration.dart';
import '../models/decorator_rule.dart';

/// Hold functions to decorate tagged text
///
/// Return the list of [Decoration] in [getDecorations]
class Decorator {
  final List<DecoratorRule> rules;

  Decorator({required this.rules});

  List<Decoration> _getSourceDecorations(
    List<RegExpMatch> tags,
    String copiedText,
    Map<RegExp, DecoratorRule> ruleByRegExp,
  ) {
    TextRange? previousItem;
    final List<Decoration> result = [];
    for (final tag in tags) {
      ///Add untagged content
      if (previousItem == null) {
        if (tag.start > 0) {
          result.add(
            Decoration(
              range: TextRange(start: 0, end: tag.start),
            ),
          );
        }
      } else {
        result.add(
          Decoration(
            range: TextRange(
              start: previousItem.end,
              end: tag.start,
            ),
          ),
        );
      }

      result.add(
        Decoration(
          range: TextRange(
            start: tag.start,
            end: tag.end,
          ),
          rule: ruleByRegExp[tag.pattern],
        ),
      );

      previousItem = TextRange(
        start: tag.start,
        end: tag.end,
      );
    }

    ///Add remaining untagged content
    if (result.last.range.end < copiedText.length) {
      result.add(
        Decoration(
          range: TextRange(
            start: result.last.range.end,
            end: copiedText.length,
          ),
        ),
      );
    }
    return result;
  }

  /// Return the list of decorations with tagged and untagged text
  List<Decoration> getDecorations(
    String copiedText,
    List<DecoratorRule> rules,
  ) {
    final ruleByRegExp = <RegExp, DecoratorRule>{};
    final List<RegExpMatch> tagsTemp = [];
    for (final rule in rules) {
      ruleByRegExp[rule.regExp] = rule;
      tagsTemp.addAll(rule.regExp.allMatches(copiedText));
    }

    if (tagsTemp.isEmpty) {
      return [];
    }

    // Sort by start position; for ties, prefer longer (wider) matches
    tagsTemp.sort((a, b) {
      final cmp = a.start.compareTo(b.start);
      if (cmp != 0) return cmp;
      return b.end.compareTo(a.end);
    });

    // Single-pass greedy deduplication: keep widest non-overlapping matches
    final List<RegExpMatch> tags = [tagsTemp.first];
    for (int i = 1; i < tagsTemp.length; i++) {
      final current = tagsTemp[i];
      final last = tags.last;
      if (current.start >= last.end) {
        tags.add(current);
      }
      // else: overlapping or contained — skip
    }

    return _getSourceDecorations(tags, copiedText, ruleByRegExp);
  }
}
