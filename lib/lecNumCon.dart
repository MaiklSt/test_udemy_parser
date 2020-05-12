
class lecCon {

  var text = [];
  String s;

  con(var s) {
    for (int n = 0; n < s.length; n++) {
      if (s[n] == ' ') break;
      if (s[n] != '\n' && s[n] != ' ') text.add(s[n]);
    }
    return text.join();
  }
}