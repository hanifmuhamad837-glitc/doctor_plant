import 'package:flutter/material.dart';

// Data model untuk Tips
class TipCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<TipItem> tips;

  const TipCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.tips,
  });
}

class TipItem {
  final String title;
  final String content;
  final IconData icon;

  const TipItem({
    required this.title,
    required this.content,
    required this.icon,
  });
}

const List<TipCategory> kTipCategories = [
  TipCategory(
    title: 'Persiapan Lahan',
    subtitle: 'Langkah awal yang menentukan keberhasilan panen',
    icon: Icons.agriculture_rounded,
    color: Color(0xFF5D4037),
    tips: [
      TipItem(
        title: 'Olah Tanah dengan Baik',
        icon: Icons.grass,
        content:
            'Bajak tanah sedalam 20–30 cm untuk membalikkan lapisan tanah dan membantu aerasi. Lakukan 2–3 minggu sebelum tanam agar tanah cukup matang dan organisme tanah berkembang dengan baik.',
      ),
      TipItem(
        title: 'Perbaiki Drainase Lahan',
        icon: Icons.water,
        content:
            'Pastikan saluran air masuk dan keluar berfungsi dengan baik. Lahan yang tergenang terlalu lama atau terlalu kering akan mempengaruhi pertumbuhan akar dan meningkatkan risiko penyakit busuk batang.',
      ),
      TipItem(
        title: 'Pengapuran pada Tanah Asam',
        icon: Icons.science_outlined,
        content:
            'Jika pH tanah di bawah 5,5, lakukan pengapuran menggunakan dolomit atau kapur pertanian. pH ideal untuk padi adalah 6,0–7,0. Lakukan uji tanah sebelum musim tanam untuk mengetahui kebutuhan kapur.',
      ),
      TipItem(
        title: 'Pemupukan Dasar',
        icon: Icons.eco_outlined,
        content:
            'Berikan pupuk organik (kompos atau pupuk kandang matang) sebanyak 1–2 ton/ha sebelum tanam. Tambahkan pupuk dasar fosfat (SP-36 atau TSP) sesuai rekomendasi lokal untuk mendukung perkembangan akar.',
      ),
    ],
  ),
  TipCategory(
    title: 'Pemilihan & Perlakuan Benih',
    subtitle: 'Benih sehat adalah kunci tanaman yang kuat',
    icon: Icons.grain_rounded,
    color: Color(0xFF2E7D32),
    tips: [
      TipItem(
        title: 'Pilih Varietas Unggul',
        icon: Icons.star_outline_rounded,
        content:
            'Gunakan varietas padi unggul bersertifikat yang sesuai dengan kondisi lahan dan iklim setempat, seperti Ciherang, Inpari, Mekongga, atau varietas lokal unggulan. Varietas unggul umumnya lebih tahan terhadap penyakit dan hama.',
      ),
      TipItem(
        title: 'Seleksi Benih dengan Air Garam',
        icon: Icons.filter_alt_outlined,
        content:
            'Rendam benih dalam larutan air garam (1–2 sendok makan garam per liter air). Benih yang mengambang dibuang, benih yang tenggelam adalah benih berkualitas. Cuci bersih benih dengan air setelah seleksi.',
      ),
      TipItem(
        title: 'Perendaman & Perkecambahan',
        icon: Icons.opacity_rounded,
        content:
            'Rendam benih selama 24–48 jam dalam air bersih, kemudian tiriskan dan bungkus dengan karung basah selama 24–48 jam untuk proses perkecambahan. Benih siap semai saat radikula (calon akar) muncul sepanjang ±1 mm.',
      ),
      TipItem(
        title: 'Perlakuan Benih dengan Fungisida',
        icon: Icons.health_and_safety_outlined,
        content:
            'Untuk mencegah penyakit terbawa benih (seed-borne disease), rendam benih dalam larutan fungisida berbahan aktif metalaksil atau mankozeb sesuai dosis anjuran selama 30 menit sebelum semai.',
      ),
    ],
  ),
  TipCategory(
    title: 'Penanaman',
    subtitle: 'Teknik tanam yang benar untuk pertumbuhan optimal',
    icon: Icons.spa_rounded,
    color: Color(0xFF0277BD),
    tips: [
      TipItem(
        title: 'Waktu Tanam yang Tepat',
        icon: Icons.calendar_month_rounded,
        content:
            'Tanam serempak dalam satu hamparan untuk memutus siklus penyakit dan hama. Waktu tanam yang tepat disesuaikan dengan kalender tanam setempat dan ketersediaan air irigasi. Hindari tanam terlalu awal atau terlalu akhir dari musim yang disarankan.',
      ),
      TipItem(
        title: 'Jarak Tanam Ideal',
        icon: Icons.grid_on_rounded,
        content:
            'Gunakan jarak tanam 25×25 cm atau 20×20 cm untuk padi. Jarak tanam yang tepat memastikan sirkulasi udara baik, mengurangi kelembapan mikro yang memicu jamur, dan memudahkan perawatan. Metode Jajar Legowo (2:1 atau 4:1) dapat meningkatkan hasil 15–20%.',
      ),
      TipItem(
        title: 'Kedalaman Tanam Bibit',
        icon: Icons.vertical_align_bottom_rounded,
        content:
            'Tanam bibit sedalam 2–3 cm dengan posisi tegak. Penanaman terlalu dalam menghambat pertumbuhan anakan, sedangkan terlalu dangkal menyebabkan bibit mudah roboh. Gunakan bibit berumur 15–21 hari untuk sistem bibit muda (system of rice intensification/SRI).',
      ),
      TipItem(
        title: 'Jumlah Bibit Per Lubang',
        icon: Icons.format_list_numbered_rounded,
        content:
            'Tanam 1–3 bibit per lubang. Penanaman terlalu banyak bibit per lubang menyebabkan persaingan antar tanaman, meningkatkan kelembapan, dan memperparah risiko penyakit. Sistem SRI menggunakan 1 bibit per lubang dengan hasil yang lebih optimal.',
      ),
    ],
  ),
  TipCategory(
    title: 'Pemupukan',
    subtitle: 'Nutrisi seimbang untuk hasil panen maksimal',
    icon: Icons.science_rounded,
    color: Color(0xFFF57F17),
    tips: [
      TipItem(
        title: 'Pupuk Nitrogen (Urea)',
        icon: Icons.water_drop_rounded,
        content:
            'Berikan pupuk urea dalam 2–3 tahap: 1/3 dosis saat tanam, 1/3 pada 21–25 hari setelah tanam (VST), dan 1/3 pada 42–45 HST (fase primordia). Hindari pemupukan nitrogen berlebihan karena meningkatkan kerentanan terhadap penyakit blas dan hawar daun bakteri.',
      ),
      TipItem(
        title: 'Pupuk Fosfat & Kalium',
        icon: Icons.eco_rounded,
        content:
            'Fosfat (SP-36/TSP) diberikan seluruhnya saat pengolahan tanah terakhir. Kalium (KCl/ZA) diberikan 1/2 saat tanam dan 1/2 saat pemupukan kedua. Kalium memperkuat dinding sel tanaman sehingga lebih tahan penyakit dan rebah.',
      ),
      TipItem(
        title: 'Pupuk Organik & Hayati',
        icon: Icons.compost_rounded,
        content:
            'Kombinasikan pupuk kimia dengan pupuk organik untuk menjaga kesehatan tanah jangka panjang. Pupuk hayati (biofertilizer) mengandung bakteri pelarut fosfat dan penambat nitrogen yang membantu efisiensi pemupukan dan meningkatkan daya tahan tanaman.',
      ),
      TipItem(
        title: 'Penggunaan Silika (Si)',
        icon: Icons.shield_outlined,
        content:
            'Silika memperkuat dinding sel tanaman padi sehingga lebih tahan terhadap serangan jamur dan hama pengisap. Berikan pupuk silika (terak silikat atau pupuk Si khusus) terutama pada lahan yang sering terserang penyakit blas.',
      ),
    ],
  ),
  TipCategory(
    title: 'Pengairan',
    subtitle: 'Manajemen air yang tepat untuk padi sehat',
    icon: Icons.water_rounded,
    color: Color(0xFF0288D1),
    tips: [
      TipItem(
        title: 'Sistem Pengairan Berselang (Intermittent)',
        icon: Icons.swap_horiz_rounded,
        content:
            'Terapkan pengairan berselang: airi lahan hingga 5 cm, biarkan hingga macak-macak atau sedikit retak, lalu airi kembali. Metode ini menghemat air 20–30%, mengurangi emisi gas metan, dan mengurangi risiko penyakit busuk batang akibat genangan terus-menerus.',
      ),
      TipItem(
        title: 'Fase Kritis yang Perlu Air',
        icon: Icons.priority_high_rounded,
        content:
            'Pastikan lahan selalu tergenang (3–5 cm) pada fase-fase kritis: saat tanam, pembentukan anakan aktif (14–35 HST), dan fase primordia hingga pengisian gabah. Kekurangan air pada fase ini dapat menurunkan hasil panen secara drastis.',
      ),
      TipItem(
        title: 'Pengeringan Sebelum Panen',
        icon: Icons.wb_sunny_outlined,
        content:
            'Keringkan lahan 10–14 hari sebelum panen untuk memudahkan proses pemanenan, mencegah kerusakan akar akibat tergenang, dan mempercepat pematangan gabah secara merata. Pengeringan juga mengurangi risiko kontaminasi aflatoksin pada gabah.',
      ),
    ],
  ),
  TipCategory(
    title: 'Pengendalian Hama & Penyakit',
    subtitle: 'Perlindungan tanaman secara terpadu (PHT)',
    icon: Icons.bug_report_rounded,
    color: Color(0xFFC62828),
    tips: [
      TipItem(
        title: 'Prinsip PHT (Pengendalian Hama Terpadu)',
        icon: Icons.balance_rounded,
        content:
            'Terapkan Pengendalian Hama Terpadu: utamakan pengendalian secara budidaya (varietas tahan, tanam serempak), biologi (musuh alami), dan fisik sebelum menggunakan pestisida kimia. Penggunaan pestisida berlebihan membunuh musuh alami dan memicu resistensi hama.',
      ),
      TipItem(
        title: 'Pemantauan Rutin (Monitoring)',
        icon: Icons.search_rounded,
        content:
            'Lakukan pengamatan tanaman secara rutin minimal 2 kali seminggu sejak awal tanam. Amati gejala penyakit, populasi hama, dan keberadaan musuh alami. Deteksi dini memungkinkan penanganan sebelum serangan meluas dan kerusakan besar terjadi.',
      ),
      TipItem(
        title: 'Penggunaan Pestisida yang Tepat',
        icon: Icons.local_pharmacy_outlined,
        content:
            'Jika harus menggunakan pestisida: pilih yang spesifik, gunakan dosis anjuran, semprotkan pada waktu yang tepat (pagi atau sore hari), dan rotasi bahan aktif untuk mencegah resistensi. Selalu gunakan APD (masker, sarung tangan, kacamata) saat menyemprot.',
      ),
      TipItem(
        title: 'Manfaatkan Musuh Alami',
        icon: Icons.nature_people_rounded,
        content:
            'Lindungi dan perbanyak musuh alami seperti laba-laba, capung, dan parasitoid telur wereng. Hindari penggunaan insektisida spektrum lebar. Tanam refugia (tanaman bunga) di pematang untuk menarik musuh alami dan meningkatkan keanekaragaman hayati lahan.',
      ),
    ],
  ),
  TipCategory(
    title: 'Panen & Pascapanen',
    subtitle: 'Memastikan kualitas gabah terbaik',
    icon: Icons.shopping_basket_rounded,
    color: Color(0xFF6A1B9A),
    tips: [
      TipItem(
        title: 'Waktu Panen yang Tepat',
        icon: Icons.access_time_rounded,
        content:
            'Panen saat 90–95% gabah telah menguning (sekitar 30–35 hari setelah berbunga). Panen terlalu awal menghasilkan banyak butir hijau dan rendemen giling rendah; panen terlalu lambat menyebabkan kehilangan hasil karena gabah rontok dan serangan burung.',
      ),
      TipItem(
        title: 'Teknik Panen Minim Kehilangan',
        icon: Icons.handyman_outlined,
        content:
            'Gunakan sabit bergerigi atau mesin panen (combine harvester) untuk meminimalkan kehilangan hasil. Lakukan perontokan segera (≤24 jam) setelah pemotongan untuk mencegah peningkatan kadar air gabah dan serangan jamur pasca-panen.',
      ),
      TipItem(
        title: 'Pengeringan Gabah',
        icon: Icons.wb_sunny_rounded,
        content:
            'Keringkan gabah hingga kadar air ≤14% sebelum disimpan. Pengeringan di bawah sinar matahari dilakukan 2–3 hari dengan pembalikan setiap 1–2 jam. Gabah yang terlalu lembap akan mudah terserang jamur dan bakteri selama penyimpanan.',
      ),
      TipItem(
        title: 'Penyimpanan Gabah yang Benar',
        icon: Icons.inventory_2_outlined,
        content:
            'Simpan gabah dalam karung yang bersih atau silo kedap udara di tempat yang kering, sejuk, dan berventilasi baik. Jauhkan dari lantai dan dinding menggunakan alas palet. Lakukan fumigasi jika diperlukan untuk mencegah serangan hama gudang.',
      ),
    ],
  ),
];

// ===========================
// HALAMAN TIPS & TRIK
// ===========================
class TipsTricksPage extends StatefulWidget {
  const TipsTricksPage({super.key});

  @override
  State<TipsTricksPage> createState() => _TipsTricksPageState();
}

class _TipsTricksPageState extends State<TipsTricksPage> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = kTipCategories[_selectedCategoryIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: CustomScrollView(
        slivers: [
          // ---- APP BAR ----
          SliverAppBar(
            expandedHeight: 230,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF2E7D32),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B5E20), Color(0xFF4CAF50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Dekorasi lingkaran
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.07),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      bottom: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.07),
                        ),
                      ),
                    ),
                    // Konten header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.lightbulb_rounded,
                                  color: Colors.amber,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Panduan Petani',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tips & Trik\nBudidaya Padi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---- KATEGORI CHIP ----
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFFF1F8E9),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      itemCount: kTipCategories.length,
                      itemBuilder: (context, i) {
                        final cat = kTipCategories[i];
                        final isActive = i == _selectedCategoryIndex;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategoryIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isActive ? cat.color : Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: isActive ? cat.color : Colors.grey.shade300,
                              ),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: cat.color.withValues(alpha: 0.35),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  cat.icon,
                                  size: 16,
                                  color: isActive
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  cat.title,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // ---- HEADER KATEGORI TERPILIH ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selectedCategory.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selectedCategory.color.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: selectedCategory.color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        selectedCategory.icon,
                        color: selectedCategory.color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCategory.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: selectedCategory.color,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            selectedCategory.subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: selectedCategory.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${selectedCategory.tips.length} Tips',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---- DAFTAR TIPS ----
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tip = selectedCategory.tips[index];
                  return _TipCard(
                    tip: tip,
                    index: index,
                    color: selectedCategory.color,
                  );
                },
                childCount: selectedCategory.tips.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Widget Kartu Tip ----
class _TipCard extends StatefulWidget {
  final TipItem tip;
  final int index;
  final Color color;

  const _TipCard({
    required this.tip,
    required this.index,
    required this.color,
  });

  @override
  State<_TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<_TipCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Nomor
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${widget.index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.color,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(widget.tip.icon,
                          color: widget.color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.tip.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                // Konten (expand)
                AnimatedCrossFade(
                  firstChild: const SizedBox(height: 0),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: Colors.grey.shade100, height: 1),
                        const SizedBox(height: 12),
                        Text(
                          widget.tip.content,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: _expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
