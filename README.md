# App Version Compare

[![Publish to pub.dev](https://github.com/Jeilson-Dev/app_version_compare/actions/workflows/publish.yml/badge.svg)](https://github.com/Jeilson-Dev/app_version_compare/actions/workflows/publish.yml)
[![codecov](https://codecov.io/gh/Jeilson-Dev/app_version_compare/graph/badge.svg?token=0SB1GH2OUK)](https://codecov.io/gh/Jeilson-Dev/app_version_compare)
[![Tests](https://github.com/Jeilson-Dev/app_version_compare/actions/workflows/dart.yml/badge.svg)](https://github.com/Jeilson-Dev/app_version_compare/actions/workflows/dart.yml)


## Overview

This Dart package provides a utility for parsing version strings according to Semantic Versioning (SemVer) and comparing two versions. It's particularly useful for managing app versions and implementing version comparison logic, such as determining whether a force update is required based on a version retrieved from a remote configuration.

## Installation

You can install this package via pub.dev. Add the following line to your `pubspec.yaml` file:

Then, run:

```bash
flutter pub add app_version_compare
```

## Usage

### Comparing Versions

```dart
void main() {
  final remoteConfigVersion = '1.2.4';
  final appVersion = '1.2.3';

  final remoteVersion = AppVersion.fromString(remoteConfigVersion);
  final appCurrentVersion = AppVersion.fromString(appVersion);

  if (appCurrentVersion >= remoteVersion) {
    print('The app is updated!');
    print('Current app version: $appCurrentVersion');
    print('Latest version available: $remoteVersion');
  } else {
    print('The app is out of date!');
    print('Current app version: $appCurrentVersion');
    print('Latest version available: $remoteVersion');
  }
}
```

## Support

For any issues or suggestions, please [open an issue](https://github.com/Jeilson-Dev/app_version_compare/issues) on GitHub.

## License

This package is licensed under the MIT License. See the [LICENSE](https://github.com/Jeilson-Dev/app_version_compare/blob/main/LICENSE) file for details.
