import 'package:app_version_compare/src/model/app_version.dart';
import 'package:test/test.dart';

void main() {
  test('when passing a string to AppVersion.fromString should return an instance of AppVersion with the numbers of version', () {
    final version = '1.2.3';

    final result = AppVersion.fromString(version);

    expect(result.major, 1);
    expect(result.minor, 2);
    expect(result.patch, 3);
  });

  test('''when passing 1.2.3 to AppVersion.fromString should return an instance of AppVersion with the numbers of version
      when try to convert to string should return the same value, since using the default major(1), minor(2) and patch(3) 
      the other values should be discard''', () {
    final version = '1.2.3';

    final result = AppVersion.fromString(version);

    expect(result.major, 1);
    expect(result.minor, 2);
    expect(result.patch, 3);
    expect(result.toString(), version);
  });

  test('''when passing 1.2.3.4 to AppVersion.fromString the other values should be discard''', () {
    final version = '1.2.3.4';

    final result = AppVersion.fromString(version);

    expect(result.major, 1);
    expect(result.minor, 2);
    expect(result.patch, 3);
    expect(result.toString() == version, false);
    expect(result.toString(), '1.2.3');
  });

  group('Lack of data', () {
    test('''when passing incomplete data the value should be filled by zero (0)
        when version is 1.2 without the path the patch should be zero(0) 
        AppVersion('1.2').toString() should return 1.2.0''', () {
      final version = '1.2';

      final result = AppVersion.fromString(version);

      expect(result.major, 1);
      expect(result.minor, 2);
      expect(result.patch, 0);
      expect(result.toString(), '1.2.0');
    });

    test('''when passing incomplete data the value should be filled by zero (0)
        when version is 1 without the path and minor the patch and minor should be zero(0) 
        AppVersion('1').toString() should return 1.0.0''', () {
      final version = '1';

      final result = AppVersion.fromString(version);

      expect(result.major, 1);
      expect(result.minor, 0);
      expect(result.patch, 0);
      expect(result.toString(), '1.0.0');
    });

    test('''when passing incomplete data the value should be filled by zero (0)
        when version is an empty string without the path , minor and major the patch, minor and major should be zero(0) 
        AppVersion('').toString() should return 0.0.0''', () {
      final version = '0';

      final result = AppVersion.fromString(version);

      expect(result.major, 0);
      expect(result.minor, 0);
      expect(result.patch, 0);
      expect(result.toString(), '0.0.0');
    });
  });

  group('Compare versions', () {
    group('Equal', () {
      test('when comparing with the same values: major, minor and path should return true', () {
        final version = '1.2.3';

        final result = AppVersion.fromString(version);

        expect(result, AppVersion(major: 1, minor: 2, patch: 3));
        expect(result == AppVersion(major: 1, minor: 2, patch: 3), true);
      });

      test('when comparing with different values: major, minor and path should return false', () {
        final version = '3.2.1';

        final result = AppVersion.fromString(version);

        expect(result == AppVersion(major: 1, minor: 2, patch: 3), false);
      });
    });

    group('Greater than', () {
      test('when comparing with the same values: major, minor and path should return false', () {
        final version = '1.2.3';

        final result = AppVersion.fromString(version);

        expect(result > AppVersion(major: 1, minor: 2, patch: 3), false);
      });

      test('when comparing different values: major, minor and path should return true', () {
        final version = '3.2.1';

        final result = AppVersion.fromString(version);

        expect(result > AppVersion(major: 1, minor: 2, patch: 3), true);
      });

      group('patch', () {
        test('''when 1.1.0 > 1.1.1 should return false''', () {
          final version = '1.1.0';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 1.1.1 should return false''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 1.1.0 should return true''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 0), true);
        });
      });
      group('minor', () {
        test('''when 1.0.1 > 1.1.1 should return false''', () {
          final version = '1.0.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 1.1.1 should return false''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 1.0.1 should return true''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 0, patch: 1), true);
        });
      });
      group('major', () {
        test('''when 0.1.1 > 1.1.1 should return false''', () {
          final version = '0.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 1.1.1 should return false''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 1, minor: 1, patch: 1), false);
        });

        test('''when 1.1.1 > 0.1.1 should return true''', () {
          final version = '1.1.1';

          final result = AppVersion.fromString(version);

          expect(result > AppVersion(major: 0, minor: 1, patch: 1), true);
        });
      });
    });
  });
}
