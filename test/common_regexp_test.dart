import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_decorated_text/src/misc/common_regexp.dart';

void main() {
  group('CommonRegExp.word', () {
    test('does not throw on regex metacharacters', () {
      expect(() => CommonRegExp.word('foo (bar)'), returnsNormally);
      expect(() => CommonRegExp.word('C++'), returnsNormally);
    });

    test('matches plain words as before', () {
      final regex = CommonRegExp.word('hello');
      expect(regex.hasMatch('say hello world'), isTrue);
      expect(regex.hasMatch('hellothere'), isFalse);
    });

    test('treats . as literal, not "any char"', () {
      final regex = CommonRegExp.word('a.b');
      expect(regex.hasMatch('a.b'), isTrue);
      expect(regex.hasMatch('axb'), isFalse);
    });
  });

  group('CommonRegExp.words', () {
    test('does not throw on regex metacharacters (the original bug)', () {
      expect(
        () => CommonRegExp.words([
          'Relatório de progresso (sigla em inglês)',
          'PE',
          'ELA',
        ]),
        returnsNormally,
      );
    });

    test('still matches plain alternatives when input contains metachars', () {
      final regex = CommonRegExp.words([
        'Relatório de progresso (sigla em inglês)',
        'PE',
        'ELA',
      ]);
      expect(regex.hasMatch('PE'), isTrue);
      expect(regex.hasMatch('ELA is here'), isTrue);
    });

    test('treats . as literal, not "any char"', () {
      final regex = CommonRegExp.words(['a.b']);
      expect(regex.hasMatch('a.b'), isTrue);
      expect(regex.hasMatch('axb'), isFalse);
    });
  });

  group('CommonRegExp.startsWith', () {
    test('handles single metacharacter prefix', () {
      final regex = CommonRegExp.startsWith('#');
      expect(regex.firstMatch('#hello world')?.group(1), 'hello');
    });

    test('handles multi-character prefix', () {
      final regex = CommonRegExp.startsWith('@@');
      expect(regex.firstMatch('@@user here')?.group(1), 'user');
    });

    test('handles non-meta multi-char prefix (was broken before fix)', () {
      final regex = CommonRegExp.startsWith('cmd:');
      expect(regex.firstMatch('cmd:run something')?.group(1), 'run');
    });
  });

  group('CommonRegExp.between', () {
    test('handles single-char metacharacter delimiters', () {
      final regex = CommonRegExp.between(start: '(', end: ')');
      expect(regex.firstMatch('foo (bar) baz')?.group(1), 'bar');
    });

    test('handles bracket delimiters', () {
      final regex = CommonRegExp.between(start: '[', end: ']');
      expect(regex.firstMatch('foo [bar] baz')?.group(1), 'bar');
    });

    test('handles multi-char delimiters (was broken before fix)', () {
      final regex = CommonRegExp.between(start: '<<', end: '>>');
      expect(regex.firstMatch('foo <<bar>> baz')?.group(1), 'bar');
    });
  });
}
