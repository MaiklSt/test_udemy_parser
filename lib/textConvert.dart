
// ignore: camel_case_types

class textConver {
  var text = [];
 // var time;
  String s;

  con(var s) {
    for (int n = 0; n < s.length; n++) {
      if (s[n] != '\n') text.add(s[n]);
    }
    return text.join();
  }
}
