import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/decorator_rule.dart';
import 'decorator.dart';

/// Returns textSpan with decorated tagged text
TextSpan getDecoratedTextSpan({
  required String source,
  required TextStyle style,
  required List<DecoratorRule> rules,
}) {
  final decorations = Decorator(
    rules: rules,
  ).getDecorations(source, rules);
  if (decorations.isEmpty) {
    return TextSpan(
      text: source,
      style: style,
    );
  } else {
    decorations.sort();
    final span = decorations
        .asMap()
        .map(
          (index, item) {
            return MapEntry(
              index,
              TextSpan(
                style: item.rule?.style,
                text: item.range.textInside(source),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    final decoration = decorations[index];
                    if (decoration.rule?.onTap != null) {
                      decoration.rule?.onTap(
                        decoration.range.textInside(source).trim(),
                      );
                    }
                  },
              ),
            );
          },
        )
        .values
        .toList();

    return TextSpan(children: span, style: style);
  }
}
