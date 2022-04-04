
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_weight/model/Login_Page/LoginPage.dart';
import 'package:mobile_weight/model/Setting_page/setting_glob.dart';
import  'package:mobile_weight/model/setting/globalvar.dart' as global;
import 'package:mobile_weight/model/NawgMenu/NawMenu.dart';
import 'dart:io';
import 'dart:convert';



Future<Null>   getInfottn(
    int? ttn,String? urls
    ) async {

  HttpClient client = new HttpClient();
  client.badCertificateCallback =
  ((X509Certificate cert, String host, int port) => true);

  final String url = '$urls' +"/ttn_mobille" + "?id_waybills="+  '$ttn';

  final request = await client
      .getUrl(Uri.parse(url))
      .timeout(Duration(seconds: 5));


  HttpClientResponse response = await request.close();

  var responseBody = await response.transform(utf8.decoder).join();

  Map jsonResponse = json.decode(responseBody);

  print(jsonResponse);
  if (response.statusCode == 200) {
    global.trackTTN = jsonResponse['truck'] ;
    global.track2TTN = jsonResponse['truck2'];
    global.driverTTN = jsonResponse['drivers'];
    global.consigneeTTN = jsonResponse['consignee'];
    global.contractorTTN = jsonResponse['contractor'];
    global.contsignorTTN = jsonResponse['contsignor'];
    global.recepientTTN = jsonResponse['recepient'];
    global.bruttoTTN = jsonResponse['brutto'];
    global.tareTTN = jsonResponse['tare'];
    global.nettoTTN  = jsonResponse['netto'];
    global.sendadressTTN = jsonResponse['sendadress'];
    global.elevatorTTN = jsonResponse['organization'];
    global.classTTN = jsonResponse['class'];
    global.itemTTN = jsonResponse['item'];
  }

}

void main() async {



  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var nameUser = prefs.getString('nameUser');
  global.nameUser =  prefs.getString('nameUser');
  global.idUser =  prefs.getString('idUser');
  global.urlVar =  prefs.getString('mainUrl');
  global.ttnId =  prefs.getInt('lastTTN');
  global.nameScale =  '';
  global.statusScale =  '';
  await  getInfottn(global.ttnId, global.urlVar);
  print(nameUser);



  runApp(MaterialApp(
    initialRoute: nameUser == null ? '/' : '/scan',
    routes: {
      '/' : (context) => Login(),
      '/scan' : (context) => Onboarding(),
      '/setting' : (context) => Setting(),
    },
  ));


}