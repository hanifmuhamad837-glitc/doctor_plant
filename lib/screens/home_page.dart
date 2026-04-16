import 'package:flutter/material.dart';
import 'diagnosis_page.dart';

class HomePage extends StatelessWidget {
  Widget menuCard(
    String title,
    String subtitle,
    IconData icon,
    Function() onTap,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doctor Plant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Diagnosa tanaman padi Anda dengan mudah",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            menuCard(
              "Mulai Diagnosis",
              "Periksa kesehatan tanaman",
              Icons.search,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DiagnosisPage()),
                );
              },
            ),

            menuCard(
              "Informasi Penyakit Tanaman",
              "Pelajari berbagai penyakit",
              Icons.info,
              () {},
            ),

            menuCard(
              "Tips Perawatan Tanaman",
              "Panduan merawat padi",
              Icons.book,
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
