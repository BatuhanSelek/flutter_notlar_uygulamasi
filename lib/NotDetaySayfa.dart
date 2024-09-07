// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_notlar_uygulamasi/main.dart';

import 'package:flutter_notlar_uygulamasi/models/Notlar.dart';
import 'package:flutter_notlar_uygulamasi/models/Notlardao.dart';

class Notdetaysayfa extends StatefulWidget {
  Notlar not;
  Notdetaysayfa({
    super.key,
    required this.not,
  });

  @override
  State<Notdetaysayfa> createState() => _NotdetaysayfaState();
}

class _NotdetaysayfaState extends State<Notdetaysayfa> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();

  Future<void> sil(int not_id) async {
    await Notlardao().notSil(not_id);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  Future<void> guncelle(int not_id, String ders_adi, int not1, int not2) async {
    await Notlardao().notGuncelle(not_id, ders_adi, not1, not2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfnot1.text = not.not1.toString();
    tfnot2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Not Detay",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            child: Text(
              "Sil",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              sil(widget.not.not_id);
            },
          ),
          TextButton(
            child: Text(
              "Güncelle",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              guncelle(widget.not.not_id, tfDersAdi.text,
                  int.parse(tfnot1.text), int.parse(tfnot2.text));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                textAlign: TextAlign.center,
                controller: tfDersAdi,
                decoration: InputDecoration(
                  hintText: "Ders Adı",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: tfnot1,
                decoration: InputDecoration(
                  hintText: "1. Not",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: tfnot2,
                decoration: InputDecoration(
                  hintText: "2. Not",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
