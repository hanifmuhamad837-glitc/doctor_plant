import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hasil Diagnosis")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Busuk Batang (Stem Rot)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Penyakit Terdeteksi",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Deskripsi:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Penyakit busuk batang disebabkan oleh bakteri atau jamur yang menyerang batang tanaman padi, menyebabkan tanaman layu dan batang membusuk dari dalam.",
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Rekomendasi Penanganan:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text("Buang dan musnahkan tanaman terinfeksi"),
            ),
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text("Perbaiki drainase"),
            ),
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text("Gunakan fungisida"),
            ),
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text("Rotasi tanaman"),
            ),

            Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Kembali ke Beranda"),
            ),
          ],
        ),
      ),
    );
  }
}
