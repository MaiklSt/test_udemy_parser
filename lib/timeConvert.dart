
// ignore: camel_case_types

class timeConver {
  var text = [];
  var time;
  String s;

  con(var s) {
    for (int n = 0; n < s.length; n++) {
      if (s[n] != '\n' && s[n] != ':') text.add(s[n]);
    }

    var min = text[0] + text[1];
    var sec = text[2] + text[3];

    int minMin = int.parse(min);
    int secSec = int.parse(sec);

    var convertSecond = minMin * 60 + secSec;

    return convertSecond;
  }
}
