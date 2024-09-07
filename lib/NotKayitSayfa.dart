import 'package:flutter/material.dart';
import 'package:flutter_notlar_uygulamasi/main.dart';
import 'package:flutter_notlar_uygulamasi/models/Notlardao.dart';

class Notkayitsayfa extends StatefulWidget {
  const Notkayitsayfa({super.key});

  @override
  State<Notkayitsayfa> createState() => _NotkayitsayfaState();
}

class _NotkayitsayfaState extends State<Notkayitsayfa> {
  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();
  Future<void> kayit(String ders_adi, int not1, int not2) async {
    await Notlardao().notEkle(ders_adi, not1, not2);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
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
          "Not Kayıt",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(
                  hintText: "Ders Adı",
                ),
              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(
                  hintText: "1. Not",
                ),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(
                  hintText: "2. Not",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          kayit(tfDersAdi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
        },
        tooltip: "Not Kayıt",
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          "Kaydet",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
