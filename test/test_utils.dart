import 'dart:io';
import 'package:path/path.dart' as path;


double currentMemoryUsage() {
  return (ProcessInfo.currentRss / 1024 / 1024);
}

String currentMemoryUsageString() {
  return (ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2);
}

/// Returns the (resolved) paths of all files memory-mapped into this process.
///
/// Uses `/proc/self/maps` on Linux/Android and `lsof` on macOS, where mapped
/// files are listed with the fd type `txt`.
Set<String> mappedFiles() {
  if (Platform.isLinux || Platform.isAndroid) {
    // address perms offset dev inode [pathname]
    final line = RegExp(r'^\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+(/.*)$');
    return File('/proc/self/maps').readAsLinesSync()
      .map((l) => line.firstMatch(l)?.group(1))
      .whereType<String>()
      .toSet();
  }
  if (Platform.isMacOS) {
    final result = Process.runSync('lsof', ['-p', '$pid', '-Fn', '-w']);
    if (result.exitCode != 0) {
      throw Exception('lsof failed: ${result.stderr}');
    }
    final files = <String>{};
    String? fd;
    for (final l in (result.stdout as String).split('\n')) {
      if (l.startsWith('f')) fd = l.substring(1);
      if (l.startsWith('n') && fd == 'txt') files.add(l.substring(1));
    }
    return files;
  }
  throw UnsupportedError('mappedFiles() is not implemented for ${Platform.operatingSystem}');
}

/// Finds the root directory of the project by looking for pubspec.yaml.
String getProjectRoot() {
  Directory current = Directory.current;
  
  // Keep going up the directory tree until we hit the system root
  while (current.path != current.parent.path) {
    final pubspecFile = File(path.join(current.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      return current.path;
    }
    current = current.parent;
  }
  
  throw Exception('Could not find project root! (pubspec.yaml not found)');
}

/// Helper to get the absolute path to your assets folder
String getAssetsPath() {
  return path.join(getProjectRoot(), 'assets');
}