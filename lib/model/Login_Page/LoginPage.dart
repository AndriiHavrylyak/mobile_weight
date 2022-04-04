
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_weight/model/Setting_page/setting_glob.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:mobile_weight/model/setting/globalvar.dart' as global;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_weight/model/PageScanQR/ScanPage.dart';
import 'package:mobile_weight/model/NawgMenu/NawMenu.dart';

class Login extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return   MaterialApp(
        home:   LoginPage(
            storage: Storage()
        )
    );
  }
}



class LoginPage extends StatefulWidget {

  final Storage storage;

  LoginPage({ Key? key, required this.storage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//Info about users
  String? state;

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        global.urlVar = value;
      });
    });
  }

  bool _isLoading = false;

  @override

  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/2nd-section-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            SizedBox(
              height: 20,
            ),
            buttonSection(),
            buttonSectionSetting(),
          ],
        ),
      ),
    );
  }


  signIn(String login, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var AESLogin = login;
    var AESpass = pass;
//generate a 16-byte random key
    var key = 'BF223008A23C2E3D25C33B48C29ACD46';

    print(key);
//encrypt
    var encryptLogin = await FlutterAesEcbPkcs5.encryptString(AESLogin, key);
    var encryptPass = await FlutterAesEcbPkcs5.encryptString(AESpass, key);




    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);


    String url = global.urlVar + "/auth_user";

    Map map = {
      "login": encryptLogin,
      "pass": encryptPass
    };

    HttpClientRequest request = await client.postUrl(Uri.parse(url));

    request.headers.set('content-type', 'application/json');

    request.add(utf8.encode(json.encode(map)));

    HttpClientResponse response = await request.close();


    var responseBody = await response.transform(utf8.decoder).join();

    Map jsonResponse = json.decode(responseBody);

    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['message'] ==
          '200') { //if( jsonResponse['message'] == '200') {
        setState(() {
          _isLoading = false;
        });
        global.nameUser = jsonResponse['name'];
        global.idUser = jsonResponse['id'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('nameUser', jsonResponse['name']);
        prefs.setString('idUser', jsonResponse['id']);


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
      else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Error_Auth()),
        );
      }
    }

    else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 35.0),
      child:             RaisedButton(
        disabledColor: Colors.blueGrey,
        onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        color: Colors.purple,
        child: Text("Авторизація", style: TextStyle(color:Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),

    );
  }
  Container buttonSectionSetting() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 35.0),
      child:             RaisedButton(
        disabledColor: Colors.blueGrey,
        onPressed: ()  {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Setting()),
          );
        },
        color: Colors.blue,
        child: Text("Налаштування", style: TextStyle(color:Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),

    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color:Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold
            ),
            decoration: InputDecoration(
              icon: Icon(Icons.login, color:Colors.black),
              hintText: "Логін",
              border: UnderlineInputBorder(borderSide: BorderSide(color:Colors.black)),
              hintStyle: TextStyle(color: const Color(
                  0xFF6A6969)),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color:  Colors.black,fontSize: 16.0,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black),
              hintText: "Пароль",
              border: UnderlineInputBorder(borderSide: BorderSide(color:  Colors.black)),
              hintStyle: TextStyle(color: const Color(
                  0xFF6A6969)),
            ),
          ),

        ],
      ),

    );
  }

  Container headerSection() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 50.0),

    );
  }
}
class Error_Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Text('Помилка при авторизації'),
      content:
      Text('Повторити спробу авторизації'),
      actions: [
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () => SystemNavigator.pop(),
          child: Text('Ні'),
        ),
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () { Navigator.push(
            context,MaterialPageRoute(builder: (context) => Login()),
          );
          },
          child: Text('Так'),
        ),
      ],
    );
    return Scaffold(
        body:dialog
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}

