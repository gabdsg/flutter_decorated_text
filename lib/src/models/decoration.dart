import 'package:flutter/material.dart';

import '../models/decorator_rule.dart';

/// DataModel to explain the unit of word in decoration system
class Decoration extends Comparable<Decoration> {
  Decoration({
    required this.range,
    this.rule,
  });

  final TextRange range;
  final DecoratorRule? rule;

  @override
  int compareTo(Decoration other) {
    return range.start.compareTo(other.range.start);
  }
}
