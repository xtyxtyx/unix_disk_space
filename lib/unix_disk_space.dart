/// Get free disk space info from df, Works on Unix-based systems.
///
/// Example:
/// ```dart
/// import 'package:unix_disk_space/unix_disk_space.dart';
///
/// void main() async {
///   final disks = await diskSpace();
///   print(disks);
///
///   final fs = await diskSpace.fs('tmpfs');
///   print(fs);
///
///   final file = await diskSpace.file('/bin/bash');
///   print(file);
/// }
/// ```

library unix_disk_space;

import 'package:unix_disk_space/src/unix_disk_space.dart';

export 'src/unix_disk_space_output.dart';

const diskSpace = UnixDiskSpace();
