
import 'timeConvert.dart';
import 'textConvert.dart';

txtCon(String s) {
  textConver textCon = new textConver();
  var txtCnt = textCon.con(s);
  return txtCnt;
}

convertTime(String s) {
  timeConver time = new timeConver();
  var resCon = time.con(s);
  return resCon;
}
