import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc/functions.dart';
import '../models/decorator_rule.dart';

/// DecoratedText
///
/// [rules] list of DecoratorRule
class DecoratedText extends StatelessWidget {
  const DecoratedText({
    Key? key,
    required this.text,
    required this.rules,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectable = false,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final List<DecoratorRule> rules;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  final double? textScaleFactor;
  final int? maxLines;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final bool selectable;

  /// Not available if selectable is set tu true
  final bool? softWrap;

  /// Not available if selectable is set tu true
  final TextOverflow? overflow;

  /// Not available if selectable is set tu true
  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOverride(context)) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    if (selectable) {
      return SelectableText.rich(
        getDecoratedTextSpan(
          style: effectiveTextStyle!,
          source: text,
          rules: rules,
          selectable: true,
        ),
        style: effectiveTextStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        // softWrap: softWrap,
        // overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        // locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );
    }
    return Text.rich(
      getDecoratedTextSpan(
        style: effectiveTextStyle!,
        source: text,
        rules: rules,
      ),
      style: effectiveTextStyle,
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
