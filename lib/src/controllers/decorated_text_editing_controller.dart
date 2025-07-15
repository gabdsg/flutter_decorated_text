import 'package:flutter/material.dart';

import '../misc/functions.dart';
import '../models/decorator_rule.dart';

class DecoratedTextEditingController extends TextEditingController {
  DecoratedTextEditingController({
    super.text,
    this.rules = const [],
  });

  final List<DecoratorRule> rules;

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

    return getDecoratedTextSpan(
      style: originalTextSpan.style!,
      source: text,
      rules: rules,
      selectable: true,
    );
  }
}
