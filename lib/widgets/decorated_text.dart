import 'package:flutter/cupertino.dart';

import '../misc/functions.dart';
import '../models/decorator_rule.dart';

/// Show decorated tagged text only to be shown
///
/// [decoratedStyle] is textStyle of tagged text.
/// [onTap] is called when a tagged text is tapped.
class DecoratedText extends StatelessWidget {
  DecoratedText({
    required this.text,
    required this.rules,
    this.style = const TextStyle(),
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  });

  final String text;
  final TextStyle style;
  final List<DecoratorRule> rules;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      getDecoratedTextSpan(
        style: style,
        source: text,
        rules: rules,
      ),
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
