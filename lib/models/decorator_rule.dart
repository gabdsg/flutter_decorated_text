import 'package:flutter/material.dart';

class DecoratorRule {
  final RegExp regExp;
  final TextStyle style;
  final Function(String) onTap;

  DecoratorRule({
    required this.regExp,
    required this.style,
    required this.onTap,
  });
}
