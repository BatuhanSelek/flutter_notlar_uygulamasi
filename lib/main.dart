import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notlar_uygulamasi/NotDetaySayfa.dart';
import 'package:flutter_notlar_uygulamasi/NotKayitSayfa.dart';
import 'package:flutter_notlar_uygulamasi/models/Notlar.dart';
import 'package:flutter_notlar_uygulamasi/models/Notlardao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notlar Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Notlar>> tumNotlarGoster() async {
    var notlarListesi = await Notlardao().tumNotlar();

    return notlarListesi;
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            uygulamayiKapat();
          },
        ),
        backgroundColor: Colors.deepPurple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notlar Uygulaması",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            FutureBuilder<List<Notlar>>(
              future: tumNotlarGoster(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var notlarListesi = snapshot.data;
                  double ortalama = 0.0;
                  if (!notlarListesi!.isEmpty) {
                    double toplam = 0.0;
                    for (var n in notlarListesi) {
                      toplam = toplam + (n.not1 + n.not2) / 2;
                    }
                    ortalama = toplam / notlarListesi.length;
                  }
                  return Text(
                    "Ortalama : ${ortalama}",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
                } else {
                  return Text(
                    "Ortalama : 0",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Notlar>>(
        future: tumNotlarGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var notlarListesi = snapshot.data;
            return ListView.builder(
              itemCount: notlarListesi!.length,
              itemBuilder: (context, indeks) {
                var not = notlarListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notdetaysayfa(
                                  not: not,
                                )));
                  },
                  child: Card(
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            not.ders_adi,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            not.not1.toString(),
                          ),
                          Text(
                            not.not2.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Notkayitsayfa()));
        },
        tooltip: "Not Ekle",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
