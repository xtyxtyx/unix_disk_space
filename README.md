## Unix Disk Space

Get free disk space info from df, Works on Unix-based systems.

## Usage

**A simple usage example:**

```dart
import 'package:unix_disk_space/unix_disk_space.dart';

void main() async {
  final disks = await diskSpace();
  print(disks);

  final fs = await diskSpace.fs('tmpfs');
  print(fs);

  final file = await diskSpace.file('/bin/bash');
  print(file);
}
```

**Get disk info for each filesystem.**
```dart
final output = await diskSpace();
```

**Get disk info for specified filesystem.**
```dart
final output = await diskSpace.fs('tmpfs');
```

**Get disk info for filesystem the given file is part of.**
```dart
final output = await diskSpace.file('./');
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/xtyxtyx/unix_disk_space/issues
