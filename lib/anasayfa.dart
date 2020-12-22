import 'package:arif_haber/ayarlar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class AnaSayfa extends StatefulWidget {
  AnaSayfa({Key key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

Future<RssFeed> vericek() async {
  var response = await http.get("https://t24.com.tr/rss");
  var rssFeed = RssFeed.parse(response.body);
  return rssFeed;
}

class _AnaSayfaState extends State<AnaSayfa> {
  RssFeed yenifeed;
  @override
  void initState() {
    super.initState();
    vericek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("T24 Haber Sayfası"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ayarlar()));
              },
            )
          ],
        ),
        body: FutureBuilder<RssFeed>(
            future: vericek(),
            builder: (context, AsyncSnapshot<RssFeed> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data.items[index];
                      return ListTile(
                        leading: Text(index.toString()),
                        title: Text(item.title),
                      );
                    });
              } else {
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              }
            }));
  }
}
