import 'dart:math';

String generateId() {
  final rand = Random().nextInt(99999);
  return '${DateTime.now().microsecondsSinceEpoch}-$rand';
}
