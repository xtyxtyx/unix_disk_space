class UnixDiskSpaceOutput {
  UnixDiskSpaceOutput({
    this.filesystem,
    this.type,
    this.size,
    this.used,
    this.available,
    this.capacity,
    this.mountpoint,
  });

  /// Name of the filesystem.
  final String filesystem;

  /// Type of the filesystem.
  final String type;

  /// Total size in bytes.
  final int size;

  /// Used size in bytes.
  final int used;

  /// Available size in bytes.
  final int available;

  /// Capacity as a float from 0 to 1.
  final double capacity;

  /// Disk mount location.
  final String mountpoint;

  @override
  String toString() {
    return 'disk: $mountpoint($capacity)';
  }
}
