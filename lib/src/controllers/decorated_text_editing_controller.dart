import 'package:flutter/material.dart';

import '../misc/functions.dart';
import '../models/decorator_rule.dart';

class DecoratedTextEditingController extends TextEditingController {
  DecoratedTextEditingController({
    super.text,
    this.rules = const [],
  });

  final List<DecoratorRule> rules;

  String? _cachedText;
  TextStyle? _cachedStyle;
  TextSpan? _cachedSpan;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool withComposing = false,
  }) {
    final TextSpan originalTextSpan = super.buildTextSpan(
      context: context,
      style: style,
      withComposing: withComposing,
    );

    final currentStyle = originalTextSpan.style!;

    if (_cachedSpan != null &&
        _cachedText == text &&
        _cachedStyle == currentStyle) {
      return _cachedSpan!;
    }

    _cachedText = text;
    _cachedStyle = currentStyle;
    _cachedSpan = getDecoratedTextSpan(
      style: currentStyle,
      source: text,
      rules: rules,
      selectable: true,
    );
    return _cachedSpan!;
  }
}
