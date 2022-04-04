import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_weight/model/setting/globalvar.dart' as global;
import 'package:mobile_weight/model/GetHisoryEvent/GetEvent.dart';
import 'package:mobile_weight/model/ErrorPage/ErrorePage.dart';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:timelines/timelines.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:convert/convert.dart';

class Form_scan extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavigationDrawerWidget(),
      // endDrawer: NavigationDrawerWidget(),
      //  appBar: AppBar(title: Text('Scan'), backgroundColor: Colors.blueGrey,),
      body: SealsPage(),
    );
  }
}

class SealsPage extends StatefulWidget {
  @override
  _SealsPageState createState() => _SealsPageState();
}

class _SealsPageState extends State<SealsPage> {

  List? SealsList;
  String? _myQRresult;
  int? weight;
  String? weightSO;
  String? filterSts;
  late int weightRT = 0;
  int? transaction;
  String? weybill;
  bool? status;
  String? track1_P;
  bool? stableWeight;
  bool? errorPerimetr;
  String? track2_P;
  String? item_P;
  String url = global.urlVar;
  Color button1Color = Colors.blueGrey;
  Color button2Color = Colors.blueGrey;




  @override
  void initState() {
    super.initState();
    if   (global.soketScale != null) {
      weightSocket(global.soketScale, global.guidScale, global.soPortScale);
    }
    if   (global.ttnId != null   ) {
      getEventsTTNDetails_filter(global.ttnId,true);
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SizedBox(height: 45.0),
            Container(
              child: Text(("Ваги : " + global. nameScale),
                  style: TextStyle(fontSize: 30.0, color: Colors.blue)),
              padding: EdgeInsets.only(top: 2, bottom: 40, left: 0, right: 0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(

                  textColor: button1Color,
                  color: Colors.transparent,
                  child: Text('взвесить', textScaleFactor: 2),
                  onPressed:  () =>  {getWeight(global.urlScale,global.typeTTN,global.ttnId,global.ttnItem,global.typeOperatin,global.truck,global.truck2,'yes'),
                  button1Color = Colors.black12},
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30, 10.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                FlatButton(
                  textColor:button2Color,
                  color: Colors.transparent,
                  child: Text('отказать', textScaleFactor: 2),
                  onPressed:  () =>   {getWeight(global.urlScale,global.typeTTN,global.ttnId,global.ttnItem,global.typeOperatin,global.truck,global.truck2,'abolition'),
                    button2Color = Colors.black12},
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30, 10.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),

            Container(
              child: Text(('$weightRT' + " кг"),
                  style: TextStyle(fontSize: 45.0, color: Colors.blueGrey)),
              padding: EdgeInsets.fromLTRB(0, 0.0, 0, 20.0),
            ),
            Container(
              child: (stableWeight == true) ?  Text("вес стабилен", style: TextStyle(fontSize: 20.0,
                  color:  Colors.green )) : Text("вес  не стабилен", style: TextStyle(fontSize: 20.0,
                  color: Colors.red)),


            ),
            Container(
              child: (errorPerimetr == true) ?  Text("периметр не пересиченный", style: TextStyle(fontSize: 20.0,
                  color:  Colors.green )) : Text("периметр пересиченный", style: TextStyle(fontSize: 20.0,
                  color: Colors.red)),

              padding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
            ),
            //  Container(
            //    child: SmoothPageIndicator(
            //      controller: _pageController,
            //      count:  2,
            //      effect: JumpingDotEffect(
            //        dotHeight: 16,
            //        dotWidth: 16,
            //        jumpScale: .7,
            //        verticalOffset: 15,
            //     ),
            //        onDotClicked: _onchanged
            //   ),
            // ),
            SizedBox(height: 20.0),

            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 7),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                height: 45,
                                child: Text("история событий", style: TextStyle(
                                    fontSize: 25.0, color: Colors.blueGrey)),
                                padding: EdgeInsets.all(2.0)),
                            Expanded(
                                child: Scrollbar(
                                    child: new ListView(
                                      shrinkWrap: true,
                                      children: [

                                        new Container(
                                            alignment: Alignment.bottomLeft,
                                            child: FixedTimeline.tileBuilder(

                                              theme: TimelineThemeData(
                                                nodePosition: 0.23,
                                                color: Colors.blueGrey,
                                                indicatorTheme: IndicatorThemeData(
                                                  position:  2,
                                                  size: 13.0,
                                                ),
                                                connectorTheme: ConnectorThemeData(
                                                  thickness: 2.5,
                                                ),
                                              ),
                                              builder: TimelineTileBuilder
                                                  .connectedFromStyle(
                                                contentsAlign: ContentsAlign
                                                    .basic,
                                                oppositeContentsBuilder: (
                                                    context, index) =>
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                          _eventDetails[index]
                                                              .date),
                                                    ),
                                                contentsBuilder: (context,
                                                    index) =>
                                                    Card(
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .all(8.0),
                                                        child: Text(
                                                            _eventDetails[index]
                                                                .event),
                                                      ),
                                                    ),
                                                connectorStyleBuilder: (context,
                                                    index) =>
                                                ConnectorStyle.solidLine,
                                                indicatorStyleBuilder: (context,
                                                    index) =>
                                                IndicatorStyle.dot,
                                                itemCount: _eventDetails.length,
                                              ),
                                            )
                                        ),

                                      ],
                                    ))),
                          ],
                        ))))
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _scanQR();
          });
        },
        child: const Icon(Icons.qr_code),
        backgroundColor: Colors.pink,
      ),
    );
  }


  Future _scanQR() async {
    try {
      setState(() {
        _myQRresult =
        'dc4348da-9238-4f6d-a625-05f06de03b9a';
        scanQRapi(_myQRresult, global.idUser);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }


  bool _isLoading = false;

  scanQRapi(String? qr, String? idUser) async {
    var QR = qr;
    var idUsr = idUser;
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);


    String url_scale = global.urlVar + "/auth_scale";

    Map map = {
      "qrResult": QR,
      "isUser": idUsr
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url_scale));

    request.headers.set('content-type', 'application/json');

    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();


    var responseBody = await response.transform(utf8.decoder).join();

    Map jsonResponse = json.decode(responseBody);

    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['message'] ==
          '200') {
        global.urlScale = jsonResponse['url'];
        global.tokenScale = jsonResponse['token'];
        global.nameScale = jsonResponse['name_scale'];
        global.ttnId = jsonResponse['ttn_id'];
        global.ttnItem = jsonResponse['item'];
        global.guidScale = jsonResponse['guid_scale'];
        global.soketScale = jsonResponse['socket'];
        global.soPortScale = jsonResponse['socketPort'];
        global.typeTTN = jsonResponse['type_ttn'];
        global.typeOperatin = jsonResponse['operation_name'];
        global.truck = jsonResponse['track'];
        global.truck2 = jsonResponse['track2'];
        global.scaleID = jsonResponse['scaleID'];
        global.statusScale = 'true';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('lastTTN', jsonResponse['ttn_id']);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => Form_scan(    ))
        // );

          weightSocket(global.soketScale, global.guidScale, global.soPortScale);

      }
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Error_Auth()),
        );
      }
    }
    setState(() {
        getInfottn(global.ttnId);
        getEventsTTNDetails_filter(global.ttnId,true);

    });
  }


  late List<dynamic> data = [];
  Map<String, dynamic>? statsIndia;

  Future<Null>   getWeight(
      String? urlScales,  String? typeTTN,int? ttn,String? itemTTN,String? typeOperation,String? truck,String? truck2,String? button
      ) async {


    // Номер вантажівки
    if (truck == null) {
      track1_P = '';}
    else {
      track1_P = truck;};
    // Номер причіпа
    if (truck2 == null) {
      track2_P = '';}
    else {
      track2_P = truck2;};
    // Вантаж
    if (itemTTN == null) {
      item_P = '';}
    else {
      item_P = itemTTN;};
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);

    final String url = '$urlScales'  + "?item_name=" +  '$item_P' + "&operation_name="  + '$typeOperation' +  "&operation_type="
        + '$typeTTN'+ "&waybill="  + '$ttn' + "&reader=TTN-"+ '$ttn' + "&truck1="  + '$track1_P' + "&truck2="  + '$track2_P' +  "&mobille="  + '$button';

    final request = await client
        .getUrl(Uri.parse(url))
        .timeout(Duration(seconds: 5));

    request.headers.set('token', global.tokenScale);

    HttpClientResponse response = await request.close();

    var responseBody = await response.transform(utf8.decoder).join();

    Map jsonResponse = json.decode(responseBody);

    weight = jsonResponse['weight'];
    transaction = jsonResponse['transaction'];
    global.transactionTTN =  jsonResponse['transaction'];
    global.statusScale = jsonResponse['status'];

    setState(() {
      Timer(Duration(seconds: 2), () {
        getEventsTTNDetails_filter(global.ttnId,true);
        getInfottn(global.ttnId);
        button1Color = Colors.blueGrey;
        button2Color = Colors.blueGrey;
      });

    });

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






  List<eventHistory> _eventDetails = [];

  Future<Null> getEventsTTNDetails_filter(var weibill,var filter) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    final String urlEvents = global.urlVar + "/ttn_events" +   "?weibill=" + '$weibill' + "&filter=" + '$filter';

    final request = await client
        .getUrl(Uri.parse(urlEvents))
        .timeout(Duration(seconds: 5));

    HttpClientResponse response = await request.close();


    var responseBody = await response.transform(utf8.decoder).join();


    final responseJson = json.decode(responseBody);
    List<eventHistory> _temp=[];
    for (Map<String, dynamic> user in responseJson) {
      _temp.add(eventHistory.fromJson(user));
    }
    setState(() {
      _eventDetails=_temp;

    });
  }



  weightSocket(var soketIP, var GUID,int portSO) async {

    Socket socket = await Socket.connect(soketIP, portSO);
    print('connected');
    global.statusScale == 'false';

    var keys = 'DC82FE4110DE150B85B884E129DF455E';
    var encryptText = await FlutterAesEcbPkcs5.encryptString(GUID, keys);
    socket.listen((List<int> event) async {

      var key = 'DC82FE4110DE150B85B884E129DF455E';
      weightSO = utf8.decode(event);

       String RT = await  FlutterAesEcbPkcs5.decryptString(weightSO, key);
      Map jsonResponse = json.decode(ascii.decode(hex.decode(RT)));
      weightRT = jsonResponse['weight'];
      stableWeight  = jsonResponse['stable'];
      errorPerimetr   = jsonResponse['perimetr'];
      setState(()  {

      });
      print(ascii.decode(hex.decode(RT)));
      print((jsonResponse['weight']));
    });
    await(){
    if ( weightRT <= 0 ) {

      setState(() {
        global.urlScale ='';
        global.tokenScale  ='';
        global.nameScale  ='';
        global.ttnItem  ='';
        global.guidScale ='';
        global.soketScale ='';
        weightRT = 0;
        global.typeTTN  ='';
        global.typeOperatin  ='';
        global.truck ='';
        global.truck2 ='';
        global.statusScale  ='';
        global.transactionTTN  = null;

      });

      socket.close();

    };};

    socket.add(utf8.encode(encryptText));
    await Future.delayed(Duration(seconds: 124),() {
      setState(() {
        global.urlScale ='';
        global.tokenScale  ='';
        global.nameScale  ='';
        global.ttnItem  ='';
        global.guidScale ='';
        global.soketScale ='';
        weightRT = 0;
        global.typeTTN  ='';
        global.typeOperatin  ='';
        global.truck ='';
        global.truck2 ='';
        global.statusScale  ='';
        global.transactionTTN  = null;

      });
    }
    );


  }

}

