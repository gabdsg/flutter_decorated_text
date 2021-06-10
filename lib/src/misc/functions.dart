import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/decorator_rule.dart';
import 'decorator.dart';

/// Returns textSpan with decorated tagged text
TextSpan getDecoratedTextSpan({
  required String source,
  required TextStyle style,
  required List<DecoratorRule> rules,
  bool selectable = false,
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
            String text = item.range.textInside(source);
            if (item.rule?.transformMatch != null) {
              text = item.rule!.transformMatch!(text);
            }
            return MapEntry(
              index,
              TextSpan(
                style: item.rule?.style,
                text: selectable ||
                        (item.rule?.leadingBuilder == null &&
                            item.rule?.leadingBuilder == null)
                    ? text
                    : null,
                children: selectable ||
                        (item.rule?.leadingBuilder == null &&
                            item.rule?.leadingBuilder == null)
                    ? null
                    : [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              final decoration = decorations[index];
                              if (decoration.rule?.onTap != null) {
                                decoration.rule?.onTap!(
                                  decoration.range.textInside(source).trim(),
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (item.rule?.leadingBuilder != null)
                                  item.rule!.leadingBuilder!(
                                    decorations[index]
                                        .range
                                        .textInside(source)
                                        .trim(),
                                  ),
                                Text(
                                  text,
                                  style: item.rule?.style,
                                ),
                                if (item.rule?.trailingBuilder != null)
                                  item.rule!.trailingBuilder!(
                                    decorations[index]
                                        .range
                                        .textInside(source)
                                        .trim(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    final decoration = decorations[index];
                    if (decoration.rule?.onTap != null) {
                      decoration.rule?.onTap!(
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
