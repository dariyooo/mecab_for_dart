import 'dart:io';

import 'package:mecab_for_dart/mecab_dart.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'test_utils.dart';


void main() {

  final ipadicDir = path.join(getAssetsPath(), 'ipa dic');

  // Without HAVE_MMAP in src/config.h, src/unix/mmap.h falls back to
  // `new T[length]; read(...)` and copies the whole dictionary into the heap.
  // Windows always maps the files (CreateFileMapping / MapViewOfFile).
  test('dictionary files are memory-mapped, not read into the heap', () async {
    final tagger = await Mecab.create(dictDir: ipadicDir);

    final mapped = mappedFiles();
    for (final name in ['sys.dic', 'matrix.bin']) {
      final file = File(path.join(ipadicDir, name)).resolveSymbolicLinksSync();
      expect(mapped, contains(file),
        reason: '$name is not memory-mapped, is HAVE_MMAP defined in src/config.h?');
    }

    expect(tagger.parse("林檎を食べる").map((e) => e.surface).toList(),
      ["林檎", "を", "食べる", "EOS"]);
    tagger.dispose();
  }, skip: Platform.isWindows ? 'Windows always uses MapViewOfFile' : false);

}
