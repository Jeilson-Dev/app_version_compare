import 'package:app_version_compare/app_version_compare.dart';

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
