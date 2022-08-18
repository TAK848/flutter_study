import 'dart:math';

String randomString(int length) {
  const randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const charsLength = randomChars.length;

  final codeUnits = List.generate(
    length,
    (index) {
      final n = Random().nextInt(charsLength);
      return randomChars.codeUnitAt(n);
    },
  );
  return String.fromCharCodes(codeUnits);
}
