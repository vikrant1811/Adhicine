// test/validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:adhicine/core/utils/validators.dart';

void main() {
  group('Email Validator', () {
    test('Valid email returns null', () {
      expect(Validators.emailValidator('test@example.com'), isNull);
    });

    test('Invalid email returns error message', () {
      expect(Validators.emailValidator('invalid-email'), isNotNull);
    });
  });

  group('Password Validator', () {
    test('Valid password returns null', () {
      expect(Validators.passwordValidator('Passw0rd!'), isNull);
    });

    test('Short password returns error', () {
      expect(Validators.passwordValidator('Short!'), isNotNull);
    });

    test('Missing number returns error', () {
      expect(Validators.passwordValidator('Password!'), isNotNull);
    });

    test('Missing special char returns error', () {
      expect(Validators.passwordValidator('Password1'), isNotNull);
    });
  });
}
