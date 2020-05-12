//import 'dart:html';

import 'dart:io';
//import 'package:flutterparse/convert.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'convert.dart';
import 'lecNumCon.dart';

var datName;
var datStatus;
var datTime;

var lekNumber;
var lekNumberInteger;
var start = 0;

var lekName;

var name = [];
var status = [];
var time = [];
List timeSec = [];

void main() async {
  lekNumber = await stat(0, 'dib');
  lekName = await stat(0, 'titleName');
  lekNumberInteger = int.parse(lecCon().con(lekNumber));
  print('Количество лекций по данной ссылке = $lekNumberInteger');
  print('');
  print('Поиск бесплатных уроков, это может занять некоторое время, пожалуйста подождите!');
  print('');
  for(int tutNumber = 0; tutNumber < lekNumberInteger; tutNumber++) {

    datStatus = await stat(tutNumber, 'status');

    if (txtCon(datStatus) == 'Предварительный просмотр' || txtCon(datStatus) == 'Preview') {
      datName = await stat(tutNumber, 'name');
      datTime = await stat(tutNumber, 'time');

      name.add(txtCon(datName));
      status.add(txtCon(datStatus));
      time.add(txtCon(datTime));

    }

    print('$tutNumber Ok.');
  }

  print('');

  var lenghts = name.length;
  print('Поиск завершен! Количество бесплатных уроков = $lenghts из $lekNumberInteger');

  print('');

  for(int res = 0; res < name.length; res++) {
    stdout.write(name[res] + '   ');       //  отоброжаем строку и убираем все кроме букв
    stdout.write(status[res] + '   ');     //  отображает статус клипа
    stdout.write(time[res] + '   ');       //  отображает длительность клипа

    print('');

  }

  print('');

  for (int sortN = 0; sortN < time.length - 1; sortN++) {
    for (int sort = 0; sort < time.length - 1; sort++) {
      if (convertTime(time[sort]) > convertTime(time[sort + 1]) &&
          sort != name.length) {
        var bufferName = name[sort];
        var bufferStatus = status[sort];
        var bufferSec = time[sort];
        time[sort] = time[sort + 1];
        time[sort + 1] = bufferSec;

        status[sort] = status[sort + 1];
        status[sort + 1] = bufferStatus;


        name[sort] = name[sort + 1];
        name[sort + 1] = bufferName;
      }
    }
  }

  print('Сортировка по длительности!');

  print('');

  for(int res = 0; res < name.length; res++) {
    stdout.write(name[res] + '   ');       // перебираем строку и убираем все кроме букв
    stdout.write(status[res] + '   ');     //  отображает статус клипа
    stdout.write(time[res]);       //  отображает длительность клипа

    print('');
  }

  print('');

}

stat(int n, var text) async {
  var free;
  var textFree;
  var time;
  var timeData;
  var title;
  var titleText;

  ///////////////////////////////////////   4 демо ссылки для проверки   ///////////////////////////////////////////////////

  //final response = await http.Client().get(Uri.parse('https://www.udemy.com/course/learn_flutter/'));
  //final response = await http.Client().get(Uri.parse('https://www.udemy.com/course/the-complete-flutter-ui-masterclass/'));
  //final response = await http.Client().get(Uri.parse('https://www.udemy.com/course/objectivec/'));
  final response = await http.Client().get(Uri.parse('https://www.udemy.com/course/react-native-complete-guide/'));

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (response.statusCode == 200) {
    var document = parse(response.body);

    if (start == 0) {
      free = document.getElementsByClassName('clp-component-render')[4].children[0].children[0]; //.children[0];
      textFree = free.text;
      if (textFree == '\n\n\n\n') {
        free = document.getElementsByClassName('clp-component-render')[3].children[0].children[0]; //.children[0];
        textFree = free.text;
      }
      print(textFree);
      free = document.getElementsByClassName('dib')[0]; //.children[0];
      textFree = free.text;
      start = 1;
      return textFree;
    }

      free = document.getElementsByClassName('details')[n].children[0]; //.children[0];
      textFree = free.text;

      if (textFree == '\nПредварительный просмотр\n' || textFree == '\nPreview\n') {
        title = document.getElementsByClassName('title')[n].children[0]; //.children[0];
        titleText = title.text;

        time = document.getElementsByClassName('details')[n].children[1];
        timeData = time.text;

      } else {
        title = document.getElementsByClassName('title')[n]; //.children[0];
        titleText = title.text;

        timeData = textFree;
      }

  } else {
    throw Exception();
  }

  if (text == 'name') return titleText;
  else if (text == 'status') return textFree;
  else if (text == 'time') return timeData;

}
