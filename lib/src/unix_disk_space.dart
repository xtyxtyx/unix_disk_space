import 'dart:io';

import 'package:unix_disk_space/src/unix_disk_space_output.dart';

int parseInt(String input) {
  input = input.replaceAll('%', '');
  return int.parse(input);
}

List<int> getColumnBoundaries(String header) {
  final regex = RegExp(
      r'^Filesystem\s+|Type\s+|1024-blocks|\s+Used|\s+Available|\s+Capacity|\s+Mounted on\s*$');

  final boundaries = <int>[];

  final matches = regex.allMatches(header);
  for (var match in matches) {
    boundaries.add(match.end - match.start);
  }

  boundaries[boundaries.length - 1] = -1;
  return boundaries;
}

Iterable<UnixDiskSpaceOutput> parseOutput(String output) sync* {
  final lines = output.trim().split('\n');
  final boundaries = getColumnBoundaries(lines[0]);

  for (var line in lines.sublist(1)) {
    final cl = boundaries.map((boundary) {
      final column = boundary > 0 ? line.substring(0, boundary) : line;
      line = boundary > 0 ? line.substring(boundary) : line;
      return column.trim();
    }).toList();

    yield UnixDiskSpaceOutput(
      filesystem: cl[0],
      type: cl[1],
      size: parseInt(cl[2]) * 1024,
      used: parseInt(cl[3]) * 1024,
      available: parseInt(cl[4]) * 1024,
      capacity: parseInt(cl[5]) / 100,
      mountpoint: cl[6],
    );
  }
}

Future<List<UnixDiskSpaceOutput>> _run(List<String> args) async {
  final result = await Process.run('df', args);
  return parseOutput(result.stdout).toList();
}

class UnixDiskSpace {
  const UnixDiskSpace();
  
  /// Return a list of UnixDiskSpaceOutput objects for each filesystem.
  Future<List<UnixDiskSpaceOutput>> call() {
    return _run(['-kPT']);
  }

  /// Return UnixDiskSpaceOutput object with the space info
  /// for the given filesystem path.
  Future<UnixDiskSpaceOutput> fs(String name) async {
    final data = await call();

    for (var item in data) {
      if (item.filesystem == name) {
        return item;
      }
    }

    throw Exception("The specified filesystem \'${name}\' doesn't exist");
  }

  /// Returns a UnixDiskSpaceOutput with the space info
  /// for the filesystem the given file is part of.
  Future<UnixDiskSpaceOutput> file(String filename) async {
    final data = await _run(['-kPT', filename]);
    return data?.first;
  }
}
