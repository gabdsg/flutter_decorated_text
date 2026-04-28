import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_decorated_text/src/misc/common_regexp.dart';

void main() {
  group('CommonRegExp.url(looseUrl: true)', () {
    final regex = CommonRegExp.url(looseUrl: true);

    test('matches full URL with subdomain and https', () {
      const input = 'https://9aj0gkkctc1.typeform.com/to/CCMi4zIk';
      expect(regex.firstMatch(input)?.group(0), input);
    });

    test('matches full URL with multiple subdomains', () {
      const input = 'https://a.b.c.example.com/path';
      expect(regex.firstMatch(input)?.group(0), input);
    });

    test('matches bare domain in text', () {
      final m = regex.firstMatch('visit google.com today');
      expect(m?.group(0), 'google.com');
    });

    test('matches www-prefixed URL', () {
      final m = regex.firstMatch('see www.example.com here');
      expect(m?.group(0), 'www.example.com');
    });
  });

  group('CommonRegExp.url() strict', () {
    final regex = CommonRegExp.url();

    test('matches full URL with subdomain and https', () {
      const input = 'https://9aj0gkkctc1.typeform.com/to/CCMi4zIk';
      expect(regex.firstMatch(input)?.group(0), input);
    });
  });
}
