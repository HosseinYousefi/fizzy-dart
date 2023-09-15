import 'dart:io';
import 'dart:typed_data';

final fizzbuzz = "FizzBuzz".codeUnits;
final fizz = "Fizz".codeUnits;
final buzz = "Buzz".codeUnits;

const fblength = 8;
const flength = 4;

final zero = '0'.codeUnits.first;
final nine = '9'.codeUnits.first;

void main(List<String> arguments) {
  int i = 1;
  int ptr = 0;
  final s = Uint8List(64000);
  final number = Uint8List(20);
  number.fillRange(0, 20, zero);
  ++number[0];
  int numberLength = 1;

  while (true) {
    if (i % 15 == 0) {
      s.setRange(ptr, ptr + fblength, fizzbuzz);
      ptr += fblength;
    } else if (i % 3 == 0) {
      s.setRange(ptr, ptr + flength, fizz);
      ptr += flength;
    } else if (i % 5 == 0) {
      s.setRange(ptr, ptr + flength, buzz);
      ptr += flength;
    } else {
      s.setRange(ptr, ptr + numberLength, number);
      ptr += numberLength;
    }
    s[ptr++] = 10;

    i++;
    bool carry = true;
    for (int j = numberLength - 1; j >= 0; --j) {
      if (number[j] < nine) {
        ++number[j];
        carry = false;
        break;
      }
      if (numberLength - 1 - j > 2) {
        // just recalculate.
        carry = false;
        final n = i.toString().codeUnits;
        numberLength = n.length;
        number.setRange(0, numberLength, n);
        break;
      }
      number[j] = zero;
    }
    if (carry) {
      ++numberLength;
      ++number[0];
    }
    if (ptr > 63900) {
      stdout.add(Uint8List.sublistView(s, 0, ptr));
      ptr = 0;
    }
  }
}
