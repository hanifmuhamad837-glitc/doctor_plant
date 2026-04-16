import 'package:flutter/material.dart';
import 'result_page.dart';

class DiagnosisPage extends StatefulWidget {
  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  List<String> selected = [];

  List<String> gejala = [
    "Daun menguning",
    "Bercak coklat pada daun",
    "Tanaman layu",
    "Batang busuk",
    "Serangan hama",
  ];

  void toggleSelection(String item) {
    setState(() {
      if (selected.contains(item)) {
        selected.remove(item);
      } else {
        selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diagnosis Tanaman")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Pilih gejala yang terlihat pada tanaman anda:"),
            SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: gejala.map((g) {
                  return Card(
                    child: ListTile(
                      title: Text(g),
                      trailing: selected.contains(g)
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.radio_button_unchecked),
                      onTap: () => toggleSelection(g),
                    ),
                  );
                }).toList(),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ResultPage()),
                );
              },
              child: Text("Analisis Tanaman"),
            ),

            SizedBox(height: 10),
            Text("${selected.length} gejala dipilih"),
          ],
        ),
      ),
    );
  }
}
