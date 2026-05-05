// Model data penyakit dan gejala untuk sistem pakar Certainty Factor

class Disease {
  final String id;
  final String name;
  final String cause;
  final String description;
  final String symptoms;
  final List<String> recommendations;
  final String iconPath; // nama icon

  const Disease({
    required this.id,
    required this.name,
    required this.cause,
    required this.description,
    required this.symptoms,
    required this.recommendations,
    required this.iconPath,
  });
}

class Symptom {
  final String id;
  final String name;
  final String description;
  // CF Pakar (MB) untuk setiap penyakit: Map<diseaseId, cfValue>
  final Map<String, double> cfPakar;

  const Symptom({
    required this.id,
    required this.name,
    required this.description,
    required this.cfPakar,
  });
}

class DiagnosisResult {
  final Disease disease;
  final double cfValue; // 0.0 - 1.0

  const DiagnosisResult({
    required this.disease,
    required this.cfValue,
  });

  double get percentage => cfValue * 100;

  String get label {
    if (cfValue >= 0.7) return 'Sangat Mungkin';
    if (cfValue >= 0.4) return 'Mungkin';
    if (cfValue >= 0.2) return 'Sedikit Mungkin';
    return 'Tidak Terdeteksi';
  }
}

// ============================================================
// KNOWLEDGE BASE
// ============================================================

const List<Disease> kDiseases = [
  Disease(
    id: 'blast',
    name: 'Penyakit Blas (Blast)',
    cause: 'Jamur Pyricularia oryzae',
    description:
        'Penyakit blas merupakan penyakit jamur yang paling merusak pada tanaman padi. Menyerang daun, leher malai, dan buku-buku batang. Pada kondisi cuaca lembap dan suhu rendah, penyebaran dapat berlangsung sangat cepat.',
    symptoms:
        'Bercak berbentuk belah ketupat dengan tepi coklat dan tengah abu-abu pucat pada daun, serangan pada leher malai menyebabkan malai patah.',
    recommendations: [
      'Gunakan varietas padi tahan blas',
      'Aplikasikan fungisida berbahan aktif trisiklazol atau isoprotiolan',
      'Kurangi pemupukan nitrogen berlebihan',
      'Hindari penanaman di daerah berkabut terus-menerus',
      'Lakukan pergiliran tanaman',
    ],
    iconPath: 'blast',
  ),
  Disease(
    id: 'hdb',
    name: 'Hawar Daun Bakteri (HDB)',
    cause: 'Bakteri Xanthomonas oryzae pv. oryzae',
    description:
        'Hawar daun bakteri (HDB) adalah penyakit bakterial yang menyerang daun padi dari tepi, kemudian meluas ke dalam. Penyakit ini dapat menyebabkan kehilangan hasil panen hingga 50% jika menyerang saat fase vegetatif.',
    symptoms:
        'Bercak basah berair di tepi daun yang kemudian berubah kuning dan mengering menjadi putih keabu-abuan, dimulai dari ujung atau tepi daun.',
    recommendations: [
      'Gunakan varietas tahan HDB',
      'Aplikasikan bakterisida berbahan aktif tembaga (copper) atau streptomisin',
      'Perbaiki drainase lahan untuk mengurangi kelembapan berlebih',
      'Hindari luka mekanis pada tanaman',
      'Gunakan benih bebas penyakit dan lakukan perlakuan benih',
    ],
    iconPath: 'hdb',
  ),
  Disease(
    id: 'tungro',
    name: 'Penyakit Tungro',
    cause: 'Virus RTBV & RTSV (ditularkan Wereng Hijau)',
    description:
        'Tungro disebabkan oleh dua jenis virus yang ditularkan oleh wereng hijau (Nephotettix virescens). Penyakit ini menyebabkan tanaman kerdil dan menguning sehingga produktivitas turun drastis.',
    symptoms:
        'Tanaman kerdil, daun menguning hingga oranye dari ujung ke pangkal, jumlah anakan berkurang, malai mengecil atau tidak berisi.',
    recommendations: [
      'Gunakan varietas tahan tungro',
      'Kendalikan populasi wereng hijau sebagai vektor dengan insektisida',
      'Tanam serempak untuk memutus siklus hidup virus',
      'Cabut dan musnahkan tanaman terserang',
      'Gunakan lampu perangkap untuk mengendalikan wereng',
    ],
    iconPath: 'tungro',
  ),
  Disease(
    id: 'bercak_coklat',
    name: 'Bercak Coklat (Brown Spot)',
    cause: 'Jamur Bipolaris oryzae (Helminthosporium oryzae)',
    description:
        'Bercak coklat adalah penyakit jamur yang umumnya menyerang tanaman yang kekurangan hara, terutama pada lahan kurang subur. Dapat menyerang daun, pelepah, dan gabah.',
    symptoms:
        'Bercak oval atau bulat berwarna coklat dengan tepi kuning pada daun, pusat bercak berwarna abu-abu atau putih, bercak dapat bergabung menyebabkan daun mengering.',
    recommendations: [
      'Perbaiki kesuburan tanah dengan pemupukan seimbang (N, P, K)',
      'Aplikasikan fungisida berbahan aktif mankozeb atau propikonazol',
      'Gunakan benih sehat dan lakukan seed treatment',
      'Perbaiki manajemen air irigasi',
      'Gunakan varietas dengan ketahanan lebih baik',
    ],
    iconPath: 'bercak_coklat',
  ),
  Disease(
    id: 'busuk_batang',
    name: 'Busuk Batang (Stem Rot)',
    cause: 'Jamur Sclerotium oryzae',
    description:
        'Busuk batang disebabkan oleh jamur yang menyerang pelepah dan batang tanaman padi di dekat permukaan air. Penyakit ini menyebabkan batang membusuk dari dalam sehingga tanaman mudah rebah.',
    symptoms:
        'Bercak hitam tidak beraturan pada pelepah daun dekat permukaan air, batang membusuk dari dalam, tanaman rebah pada fase pengisian gabah.',
    recommendations: [
      'Kurangi genangan air yang berlebihan, perbaiki drainase',
      'Aplikasikan fungisida berbahan aktif validamycin',
      'Buang dan musnahkan tanaman atau bagian tanaman terinfeksi berat',
      'Hindari pemupukan nitrogen berlebihan',
      'Rotasi tanaman dan olah tanah dengan baik',
    ],
    iconPath: 'busuk_batang',
  ),
];

const List<Symptom> kSymptoms = [
  Symptom(
    id: 'g01',
    name: 'Bercak belah ketupat pada daun',
    description: 'Terdapat bercak berbentuk belah ketupat/berlian dengan tepi coklat dan pusat abu-abu pucat',
    cfPakar: {'blast': 0.9, 'hdb': 0.1, 'tungro': 0.1, 'bercak_coklat': 0.2, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g02',
    name: 'Bercak coklat oval pada daun',
    description: 'Terdapat bercak oval atau bulat berwarna coklat, kadang dengan pusat abu-abu atau putih',
    cfPakar: {'blast': 0.2, 'hdb': 0.2, 'tungro': 0.1, 'bercak_coklat': 0.9, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g03',
    name: 'Bercak basah berair di tepi daun',
    description: 'Terdapat bercak basah/berair yang dimulai dari tepi atau ujung daun',
    cfPakar: {'blast': 0.1, 'hdb': 0.9, 'tungro': 0.1, 'bercak_coklat': 0.2, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g04',
    name: 'Daun menguning dari ujung ke pangkal',
    description: 'Warna daun berubah kuning mulai dari ujung, menyebar ke arah pangkal daun',
    cfPakar: {'blast': 0.2, 'hdb': 0.4, 'tungro': 0.9, 'bercak_coklat': 0.3, 'busuk_batang': 0.2},
  ),
  Symptom(
    id: 'g05',
    name: 'Tanaman kerdil / pertumbuhan terhambat',
    description: 'Tinggi tanaman jauh lebih pendek dari normal, pertumbuhan lambat atau terhenti',
    cfPakar: {'blast': 0.2, 'hdb': 0.2, 'tungro': 0.9, 'bercak_coklat': 0.2, 'busuk_batang': 0.3},
  ),
  Symptom(
    id: 'g06',
    name: 'Jumlah anakan berkurang drastis',
    description: 'Tanaman menghasilkan anakan jauh lebih sedikit dari biasanya',
    cfPakar: {'blast': 0.1, 'hdb': 0.2, 'tungro': 0.8, 'bercak_coklat': 0.1, 'busuk_batang': 0.2},
  ),
  Symptom(
    id: 'g07',
    name: 'Batang membusuk / berwarna hitam',
    description: 'Batang atau pelepah tampak membusuk, berubah warna menjadi hitam atau coklat gelap',
    cfPakar: {'blast': 0.1, 'hdb': 0.1, 'tungro': 0.1, 'bercak_coklat': 0.1, 'busuk_batang': 0.9},
  ),
  Symptom(
    id: 'g08',
    name: 'Tanaman rebah / mudah patah',
    description: 'Tanaman roboh atau batang mudah patah di bagian bawah',
    cfPakar: {'blast': 0.1, 'hdb': 0.1, 'tungro': 0.2, 'bercak_coklat': 0.1, 'busuk_batang': 0.8},
  ),
  Symptom(
    id: 'g09',
    name: 'Tepi daun mengering berwarna putih',
    description: 'Bagian tepi daun yang terserang mengering dan berubah menjadi putih keabu-abuan',
    cfPakar: {'blast': 0.2, 'hdb': 0.8, 'tungro': 0.2, 'bercak_coklat': 0.2, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g10',
    name: 'Serangan pada leher malai (neck blast)',
    description: 'Leher malai (tangkai malai) tampak membusuk atau menghitam, menyebabkan malai patah',
    cfPakar: {'blast': 0.8, 'hdb': 0.1, 'tungro': 0.1, 'bercak_coklat': 0.2, 'busuk_batang': 0.3},
  ),
  Symptom(
    id: 'g11',
    name: 'Pusat bercak berwarna abu-abu pucat',
    description: 'Bagian tengah bercak pada daun berwarna abu-abu pucat atau putih, dikelilingi tepi coklat',
    cfPakar: {'blast': 0.8, 'hdb': 0.1, 'tungro': 0.1, 'bercak_coklat': 0.7, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g12',
    name: 'Daun berwarna oranye / kuning-oranye',
    description: 'Warna daun berubah menjadi oranye atau kuning-oranye yang mencolok',
    cfPakar: {'blast': 0.1, 'hdb': 0.2, 'tungro': 0.8, 'bercak_coklat': 0.2, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g13',
    name: 'Terdapat wereng/serangga pada tanaman',
    description: 'Ditemukan wereng hijau (Nephotettix) atau serangga kecil lainnya pada tanaman',
    cfPakar: {'blast': 0.1, 'hdb': 0.1, 'tungro': 0.7, 'bercak_coklat': 0.1, 'busuk_batang': 0.1},
  ),
  Symptom(
    id: 'g14',
    name: 'Bercak hitam pada pelepah dekat air',
    description: 'Bercak hitam tidak beraturan pada pelepah daun di bagian bawah tanaman, dekat permukaan air',
    cfPakar: {'blast': 0.2, 'hdb': 0.1, 'tungro': 0.1, 'bercak_coklat': 0.2, 'busuk_batang': 0.8},
  ),
];
