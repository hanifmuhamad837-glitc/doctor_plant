import 'disease_model.dart';

/// Engine perhitungan Certainty Factor (CF)
/// 
/// Rumus:
/// CF_combined = CF_pakar × CF_user
/// Kombinasi: CF(A,B) = CF_A + CF_B × (1 - CF_A)
class CfEngine {
  /// Menghitung diagnosis berdasarkan gejala yang dipilih
  /// 
  /// [selectedSymptoms]: Map<symptomId, cfUser> (cfUser antara 0.2 – 1.0)
  /// Returns: List<DiagnosisResult> diurutkan dari CF tertinggi
  static List<DiagnosisResult> diagnose(Map<String, double> selectedSymptoms) {
    // Hitung CF total per penyakit
    final Map<String, double> cfTotalPerDisease = {};

    for (final disease in kDiseases) {
      double cfTotal = 0.0;
      bool hasAnySymptom = false;

      for (final entry in selectedSymptoms.entries) {
        final symptomId = entry.key;
        final cfUser = entry.value;

        // Cari symptom di knowledge base
        final symptom = kSymptoms.firstWhere(
          (s) => s.id == symptomId,
          orElse: () => const Symptom(
            id: '',
            name: '',
            description: '',
            cfPakar: {},
          ),
        );

        if (symptom.id.isEmpty) continue;

        final cfPakar = symptom.cfPakar[disease.id] ?? 0.0;
        if (cfPakar == 0.0) continue;

        // CF combined untuk gejala ini
        final cfCombined = cfPakar * cfUser;

        // Gabungkan dengan CF total: CF(A,B) = CF_A + CF_B × (1 - CF_A)
        if (!hasAnySymptom) {
          cfTotal = cfCombined;
          hasAnySymptom = true;
        } else {
          cfTotal = cfTotal + cfCombined * (1 - cfTotal);
        }
      }

      cfTotalPerDisease[disease.id] = cfTotal.clamp(0.0, 1.0);
    }

    // Buat list DiagnosisResult
    final results = kDiseases.map((disease) {
      return DiagnosisResult(
        disease: disease,
        cfValue: cfTotalPerDisease[disease.id] ?? 0.0,
      );
    }).toList();

    // Urutkan dari CF tertinggi
    results.sort((a, b) => b.cfValue.compareTo(a.cfValue));

    return results;
  }
}
