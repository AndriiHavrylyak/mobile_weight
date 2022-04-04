import 'package:flutter/material.dart';
import 'package:mobile_weight/model/PageTTN/PageTTN.dart';
import 'package:mobile_weight/model/PageScanQR/ScanPage.dart';
import 'package:mobile_weight/model/setting/globalvar.dart' as global;
import 'dart:io';
import 'dart:convert';
class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingState();
  }


}

class OnboardingState extends State<Onboarding> {
  @override
  void initState() {
   // getInfottn(global.ttnId);
    super.initState();

  }


  int _current = 0;



  Widget widgetChange = Form_scan();

  var i = 0;



  @override
  void dispose() {

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              onPageChanged: (pageIndex) {
                setState(() {
                  _current = pageIndex;
                });
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Form_ttn();
                } else if (index == 1) {
                  return Form_scan();
                }  else {
                  return Form_scan();
                }
              },
            ),
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2 ].map((url) {
                  int index = [1, 2 ].indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 520.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ),

          ],
        ),
      ),
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