import 'package:unix_disk_space/unix_disk_space.dart';

void main() async {
  final disks = await diskSpace();
  print(disks);

  final fs = await diskSpace.fs('tmpfs');
  print(fs);

  final file = await diskSpace.file('/bin/bash');
  print(file);

  final wd = await diskSpace.file('.');
  print(wd);
}
