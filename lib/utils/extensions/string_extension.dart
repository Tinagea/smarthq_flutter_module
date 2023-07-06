extension StringExtension on String {
  String hexToAscii(int length) {
    return List.generate(length ~/ 2,
          (i) => String.fromCharCode(
              int.parse(this.substring(i * 2, (i * 2) + 2), radix: 16)),
    ).join();
  }
}