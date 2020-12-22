import 'package:arif_haber/loginislemleri.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Ayarlar extends StatefulWidget {
  Ayarlar({Key key}) : super(key: key);

  @override
  _AyarlarState createState() => _AyarlarState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

Future cikisyap() async {
  try {
    await _auth.signOut();

    debugPrint("Kullanici çıkış yaptı*********************");
  } catch (e) {
    debugPrint("1111111111111111111Hata:" + e.toString());
  }
}

class _AyarlarState extends State<Ayarlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: Text("Geliştirici"),
              onTap: () {},
            ),
            RaisedButton(
              onPressed: () async {
                await cikisyap();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Anasayfa()),
                    (route) => false);
              },
              child: Text("Çıkış yap"),
            ),
          ],
        ),
      ),
    );
  }
}
