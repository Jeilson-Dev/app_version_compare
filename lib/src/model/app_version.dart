extension _AppVersionString on String {
  List<String> get _versionParts => split('.');

  int get _secureParseInt {
    RegExp regex = RegExp(r'\d+');

    Iterable<Match> matches = regex.allMatches(this);

    String numberStr = matches.map((match) => match.group(0)).join('');
    return int.tryParse(numberStr) ?? 0;
  }
}

extension _AppVersionListString on List<String> {
  String get _major => isNotEmpty ? this[0] : '';
  String get _minor => length > 1 ? this[1] : '';
  String get _patch => length > 2 ? this[2].split('+').first : '';
}

/// ### Version Numbers
/// Software often uses a numbering system to indicate different versions.
/// These version numbers can follow various conventions such as *Semantic Versioning* (SemVer),
/// which typically consists of three numbers separated by dots (e.g., 1.2.3).
///
/// Each number represents a different level of change: **major**, **minor**, and **patch**.

class AppVersion {
  /// ### Major
  /// The **major** version number typically represents significant updates
  /// or changes to the software that may include major new features,
  /// significant redesigns, or architectural changes.
  ///
  /// Incrementing the major version number usually indicates that
  /// there are substantial changes that might affect compatibility with previous versions,
  /// and users may need to pay attention to upgrade instructions.
  ///
  /// For example, going from version 1.x to 2.x indicates a major version update.
  final int major;

  /// ### Minor
  /// The **minor** version number usually represents smaller updates or enhancements to the software.
  /// These updates might include new features, improvements, or bug fixes,
  /// but they are generally not as significant as those in a major version update.
  ///
  /// Incrementing the minor version number indicates that new features or improvements have been added,
  /// but backward compatibility with previous versions is typically maintained.
  ///
  /// For example, going from version 2.1 to 2.2 indicates a minor version update.
  final int minor;

  /// ### Patch
  /// The **patch** version (also known as the maintenance version or revision number)
  /// is typically used for small updates or bug fixes. These updates are often released
  /// to address specific issues or bugs discovered in the software since the last release.
  ///
  /// Incrementing the patch version number indicates that no new features have been added,
  /// but improvements or fixes have been made to enhance the stability or security of the software.
  ///
  /// For example, going from version 2.2.1 to 2.2.2 indicates a patch update.
  final int patch;

  AppVersion({required this.major, required this.minor, required this.patch});

  List<int> get _toList => [major, minor, patch];

  factory AppVersion.fromString(String appVersion) => AppVersion(
        major: appVersion._versionParts._major._secureParseInt,
        minor: appVersion._versionParts._minor._secureParseInt,
        patch: appVersion._versionParts._patch._secureParseInt,
      );

  bool operator >=(Object other) {
    if (identical(this, other)) return true;
    return other is AppVersion && major >= other.major && minor >= other.minor && patch >= other.patch;
  }

  bool operator >(Object other) {
    if (identical(this, other)) return true;
    final isAppVersion = other is AppVersion;
    return other is AppVersion && isGreater(_toList, other._toList);
  }

  bool operator <(Object other) {
    if (identical(this, other)) return true;
    return other is AppVersion && major < other.major && minor < other.minor && patch < other.patch;
  }

  bool operator <=(Object other) {
    if (identical(this, other)) return true;
    return other is AppVersion && major <= other.major && minor <= other.minor && patch <= other.patch;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppVersion && major == other.major && minor == other.minor && patch == other.patch;
  }

  @override
  int get hashCode => major.hashCode + minor.hashCode + patch.hashCode;

  @override
  String toString() => '$major.$minor.$patch';

  bool isGreater(List<int> a, List<int> b) {
    if (a.isNotEmpty && b.isNotEmpty) {
      if (a.first > b.first) return true;
      return isGreater(a.sublist(1, a.length), b.sublist(1, b.length));
    }
    return false;
  }

  bool isLower(List<int> a, List<int> b) {
    if (a.isNotEmpty && b.isNotEmpty) {
      if (a.first < b.first) return true;
      return isGreater(a.sublist(1, a.length), b.sublist(1, b.length));
    }
    return false;
  }
}
