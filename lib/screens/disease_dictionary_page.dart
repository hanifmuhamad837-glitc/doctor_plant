import 'package:flutter/material.dart';

class DiseaseDictionaryPage extends StatefulWidget {
  const DiseaseDictionaryPage({super.key});

  @override
  _DiseaseDictionaryPageState createState() => _DiseaseDictionaryPageState();
}

class _DiseaseDictionaryPageState extends State<DiseaseDictionaryPage> {
  final List<Map<String, dynamic>> diseases = [
    {
      "name": "Busuk Batang (Stem Rot)",
      "cause": "Jamur (Sclerotium oryzae)",
      "symptoms": "Bercak hitam pada pelepah daun dekat permukaan air, batang membusuk, tanaman rebah.",
      "icon": Icons.eco_outlined,
      "color": Colors.brown,
    },
    {
      "name": "Hawar Daun Bakteri",
      "cause": "Bakteri (Xanthomonas oryzae)",
      "symptoms": "Bercak basah pada tepi daun yang meluas, daun menjadi kuning dan akhirnya mengering putih.",
      "icon": Icons.spa_outlined,
      "color": Colors.orange,
    },
    {
      "name": "Penyakit Tungro",
      "cause": "Virus (ditularkan Wereng Hijau)",
      "symptoms": "Tanaman kerdil, daun menguning dari ujung ke pangkal, jumlah anakan berkurang.",
      "icon": Icons.bug_report_outlined,
      "color": Colors.redAccent,
    },
    {
      "name": "Bercak Coklat (Brown Spot)",
      "cause": "Jamur (Bipolaris oryzae)",
      "symptoms": "Bercak oval berwarna coklat pada daun, kadang dengan pusat berwarna abu-abu.",
      "icon": Icons.texture_outlined,
      "color": Colors.deepOrange,
    },
    {
      "name": "Penyakit Blas (Blast)",
      "cause": "Jamur (Pyricularia oryzae)",
      "symptoms": "Bercak belah ketupat pada daun dengan tepi coklat dan tengah abu-abu pucat.",
      "icon": Icons.water_drop_outlined,
      "color": Colors.blueGrey,
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredDiseases = diseases
        .where((d) => d['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // Hijau pastel muda
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 230.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF2E7D32),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ensiklopedia",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Penyakit Tanaman",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Cari nama penyakit...",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final disease = filteredDiseases[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: disease['color'].withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  disease['icon'],
                                  color: disease['color'],
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      disease['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Penyebab: ${disease['cause']}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
                          ),
                          Text(
                            "Gejala:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            disease['symptoms'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                // Akan terhubung ke halaman detail yang lebih lengkap jika ada
                              },
                              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                              label: const Text("Pelajari Cara Mengatasi"),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filteredDiseases.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
