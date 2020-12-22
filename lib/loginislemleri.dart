import 'package:arif_haber/anasayfa.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Anasayfa extends StatefulWidget {
  Anasayfa({Key key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

Future kullaniciolustur(String email, String password) async {
  try {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User userx = credential.user;
    debugPrint("Kullanıcı Giriş yaptı");
    return userx;
  } on FirebaseException catch (e) {
    print("Hata:" + e.toString());
    if (e.code == "weak-password") {
      print("şifre gücsüz............");
    } else if (e.code == "email-already-in-use") {
      print("böyle bir kullanıcı var222222222222 ");
    }
  }
}

void cikisyap() async {
  try {
    await _auth.signOut();
    debugPrint("Kullanici çıkış yaptı*********************");
  } catch (e) {
    debugPrint("1111111111111111111Hata:" + e.toString());
  }
}

class _AnasayfaState extends State<Anasayfa> {
  String xemail = "arifasd@1.com";
  String xpassword = "asd";
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('Kullanıcı çıkış yapmış veya yok');
      } else {
        print('Kullanıcı giriş yapmış');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _auth.currentUser != null
        ? AnaSayfa()
        : Scaffold(
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SafeArea(
                  top: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (String email) {
                            setState(() {
                              xemail = email;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "E-Mail giriniz",
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 250,
                        height: 60,
                        child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (String password) {
                            xpassword = password;
                          },
                          decoration: InputDecoration(
                            hintText: "Şifre giriniz",
                            hintStyle: TextStyle(
                              color: Colors.grey[700],
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              await kullaniciolustur(xemail, xpassword);
                              if (_auth.currentUser != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnaSayfa()));
                              }
                            },
                            child: Text("Giriş yap"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              cikisyap();
                            },
                            child: Text("Çıkış yap"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )),
          );
  }
}
