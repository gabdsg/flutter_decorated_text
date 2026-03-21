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
            try {
              final rawText = item.range.textInside(source);
              final trimmedText = rawText.trim();
              String text = rawText;
              if (item.rule?.transformMatch != null) {
                text = item.rule!.transformMatch!(rawText);
              }

              // Check if this rule has a builder
              if (item.rule?.builder != null) {
                // Create the base widget for the text with flexible layout
                final textWidget = GestureDetector(
                  onTap: item.rule?.onTap == null
                      ? null
                      : () {
                          if (item.rule?.onTap != null) {
                            item.rule?.onTap!(trimmedText);
                          }
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.rule?.leadingBuilder != null)
                        item.rule!.leadingBuilder!(trimmedText),
                      Flexible(
                        child: Text(
                          text,
                          style: item.rule?.style,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      if (item.rule?.trailingBuilder != null)
                        item.rule!.trailingBuilder!(trimmedText),
                    ],
                  ),
                );

                // Wrap with the custom builder (passing both widget and text)
                final wrappedWidget =
                    item.rule!.builder!(textWidget, trimmedText);

                return MapEntry(
                  index,
                  TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: wrappedWidget,
                      ),
                    ],
                  ),
                );
              } else {
                // Original logic for rules without builder
                return MapEntry(
                  index,
                  TextSpan(
                    style: item.rule?.style,
                    text: selectable ||
                            (item.rule?.leadingBuilder == null &&
                                item.rule?.trailingBuilder == null)
                        ? text
                        : null,
                    children: selectable ||
                            (item.rule?.leadingBuilder == null &&
                                item.rule?.trailingBuilder == null)
                        ? null
                        : [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: item.rule?.onTap == null
                                    ? null
                                    : () {
                                        if (item.rule?.onTap != null) {
                                          item.rule?.onTap!(trimmedText);
                                        }
                                      },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (item.rule?.leadingBuilder != null)
                                      item.rule!.leadingBuilder!(trimmedText),
                                    Text(
                                      text,
                                      style: item.rule?.style,
                                    ),
                                    if (item.rule?.trailingBuilder != null)
                                      item.rule!.trailingBuilder!(trimmedText),
                                  ],
                                ),
                              ),
                            ),
                          ],
                    recognizer: item.rule?.onTap == null
                        ? null
                        : (TapGestureRecognizer()
                          ..onTap = () {
                            if (item.rule?.onTap != null) {
                              item.rule?.onTap!(trimmedText);
                            }
                          }),
                  ),
                );
              }
            } catch (err) {
              return MapEntry(index, null);
            }
          },
        )
        .values
        .whereType<TextSpan>()
        .toList();

    return TextSpan(children: span, style: style);
  }
}
