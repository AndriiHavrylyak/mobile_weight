import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:mobile_weight/model/setting/globalvar.dart' as global;
import 'dart:io';
import 'dart:convert';

class Form_ttn extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<Form_ttn> {






  bool lockInBackground = true;
  late int  brutto = global.bruttoTTN;
  late int  tare = global.tareTTN;
  late int  netto = global.nettoTTN;

  late String?  track = global.trackTTN;
  late String?  track2 = global.track2TTN;
  late String?  item = global.itemTTN;
  late String?  consignee = global.consigneeTTN;
  late String?  contractor = global.contractorTTN;
  late String?  contsignor = global.contsignorTTN;
  late String?  recepient = global.recepientTTN;
  late String?  sendadress = global.sendadressTTN;
  late String?  elevator = global.elevatorTTN;
  late String?  classs = global.classTTN;
  @override
  void initState() {


    super.initState();
    if ( global.trackTTN == null) {
      track = '';}
    else {
      track = global.trackTTN;};
    // Номер причіпа
    if ( global.track2TTN == null) {
      track2 = '';}
    else {
      track2 = global.track2TTN;};
    // Вантаж
    if ( global.itemTTN == null) {
      item = '';}
    else {
      item = global.itemTTN;};

    if ( global.consigneeTTN == null) {
      consignee = '';}
    else {
      consignee = global.consigneeTTN;};

    if ( global.contractorTTN == null) {
      contractor = '';}
    else {
      contractor = global.contractorTTN;};

    if ( global.contsignorTTN == null) {
      contsignor = '';}
    else {
      contsignor = global.contsignorTTN;};

    if ( global.recepientTTN == null) {
      recepient = '';}
    else {
      recepient = global.recepientTTN;};

    if ( global.sendadressTTN == null) {
      sendadress = '';}
    else {
      sendadress = global.sendadressTTN;};

    if ( global.elevatorTTN == null) {
      elevator = '';}
    else {
      elevator = global.elevatorTTN;};

    if ( global.classTTN == null) {
      classs = '';}
    else {
      classs = global.classTTN;};

    if ( global.bruttoTTN == null) {
      brutto = 0;}
    else {
      brutto = global.bruttoTTN;};

    if ( global.tareTTN == null) {
      tare = 0;}
    else {
      tare = global.tareTTN;};

    if ( global.nettoTTN == null) {
      netto = 0;}
    else {
      netto = global.nettoTTN;};
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text('ТТН'), centerTitle: true,
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: false,),
        body: Scaffold(
            body:

            Container(

                child:SingleChildScrollView(
                 child:Column(
                  children: <Widget>[
                  SizedBox(height: 30.0),
                  ListTile(
                      title: Text('Перевізник',  style:TextStyle(fontSize: 17.0, color: Colors.blue))
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                              leading:  FaIcon(FontAwesomeIcons.truck),
                              title: Text('Автомобіль'  ),
                              subtitle: Text(("" + '$track'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                              leading:  FaIcon(FontAwesomeIcons.truck),
                              title: Text('Причіп'  ),
                              subtitle: Text(("" +'$track2'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.user),
                        title: Text('Водій'),
                        subtitle: Text(("" +global.driverTTN),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                    ),
                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.userCheck),
                        title: Text('Перевізник'),
                        subtitle: Text(("" +'$consignee'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                    ),
                  ),
                  ListTile(
                      title: Text('Контрагенти',  style:TextStyle(fontSize: 17.0, color: Colors.blue))
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.userPlus),
                        title: Text('Замовник'),
                        subtitle: Text(("" +'$contractor'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                    ),

                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.userMinus),
                        title: Text('Відправник'),
                        subtitle: Text(("" +'$contsignor'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                    ),
                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.peopleCarry),
                        title: Text('Отримувач'),
                        subtitle: Text((""+'$recepient'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                    ),
                  ),
                  ListTile(
                      title: Text('Дані про вантаж',  style:TextStyle(fontSize: 17.0, color: Colors.blue))
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.mapMarked),
                        title: Text('Пункт навантаження'),
                        subtitle: Text(("" +'$sendadress'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                    ),
                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                  Container(
                    child: ListTile(
                        leading:  FaIcon(FontAwesomeIcons.hotel),
                        title: Text('Елеватор'),
                        subtitle: Text((""+'$elevator'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                    ),
                  ),
                  Divider(
                      color: Colors.blueGrey
                  ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                                leading:  FaIcon(FontAwesomeIcons.cubes),
                                title: Text('Культура'  ),
                                subtitle: Text(("" + '$item'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                                leading:  FaIcon(FontAwesomeIcons.alignJustify),
                                title: Text('Клас'  ),
                                subtitle: Text(("" +'$classs'),  style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                            ),
                          ),
                        ],
                      ),
                    ),

                  ListTile(
                      title: Text('Вага',  style:TextStyle(fontSize: 17.0, color: Colors.blue))
                  ),
                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:2,
                          child: ListTile(
                              leading:  FaIcon(FontAwesomeIcons.weightHanging),
                              title: Text('Брутто'),
                              subtitle: Text(("" +'$brutto'),    style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))

                          ),
                        ),
                        Expanded(

                          child: ListTile(
                              title: Text('Тара'),
                              subtitle: Text(("" +'$tare'),   style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                              title: Text('Нетто'),
                              subtitle: Text(("" + '$netto'),   style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black))
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            )
        )
    ))
    );
  }

  Future<Null>   getInfottn(
      int? ttn
      ) async {

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);

    final String url = global.urlVar +"/ttn_mobille" + "?id_waybills="+  '$ttn';

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
}