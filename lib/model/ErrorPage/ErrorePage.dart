
import 'package:flutter/material.dart';
import 'package:mobile_weight/model/PageScanQR/ScanPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mobile_weight/model/setting/globalvar.dart' as global;

class Error_Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Text('Помилка при сканувані ваг'),
      content: Text('Повторити спробу сканування ваг'),
      actions: [
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Form_scan()),
            );
          },
          child: Text('Ні'),
        ),
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Form_scan()),
            );
          },
          child: Text('Так'),
        ),
      ],
    );
    return Scaffold(body: dialog);
  }
}


String? _coment;
class abolition_weight extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final AlertDialog dialog = AlertDialog(
      title: Text('Оказ взвешивания'),
      actions: [
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Введите комментарий'),
          keyboardType: TextInputType.text,
          onSaved: (String? val) {
            _coment = val;
          },

        ),
        new SizedBox(
          height: 10.0,
        ),
         FlatButton(
          onPressed: setComment,
          color: Colors.blue,
          child: new Text('Отправить'),
        )

      ],
    );

    return Scaffold(body: dialog);
  }
}




Future<Null> setComment() async {


  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);


  final String urlSet= global.urlVar +  "events/log/comment";

  Map map = {
    "author_name": global.nameUser,
    "id": global.ttnId,
    "description": _coment

  };

  HttpClientRequest request = await client.postUrl(Uri.parse(urlSet));

  request.headers.set('content-type', 'application/json');

  request.add(utf8.encode(json.encode(map)));

  HttpClientResponse response = await request.close();


  var responseBody = await response.transform(utf8.decoder).join();

  Map jsonResponse = json.decode(responseBody);

  print(jsonResponse);


}





