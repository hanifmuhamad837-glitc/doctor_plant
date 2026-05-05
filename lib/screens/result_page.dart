import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/disease_model.dart';

class ResultPage extends StatefulWidget {
  final List<DiagnosisResult> results;
  const ResultPage({super.key, required this.results});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  static const Color _bgDark = Color(0xFF0D1F1C);
  static const Color _bgCard = Color(0xFF1A2E2B);
  static const Color _primary = Color(0xFF00897B);
  static const Color _accent = Color(0xFF64FFDA);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnim =
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color _cfColor(double cf) {
    if (cf >= 0.7) return const Color(0xFF00C853);
    if (cf >= 0.4) return const Color(0xFFFFAB00);
    if (cf >= 0.2) return const Color(0xFFFF5722);
    return Colors.grey;
  }

  IconData _diseaseIcon(String id) {
    switch (id) {
      case 'blast':
        return Icons.water_drop_rounded;
      case 'hdb':
        return Icons.spa_rounded;
      case 'tungro':
        return Icons.bug_report_rounded;
      case 'bercak_coklat':
        return Icons.texture_rounded;
      case 'busuk_batang':
        return Icons.eco_rounded;
      default:
        return Icons.local_florist_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final top = widget.results.first;
    final hasDetection = top.cfValue >= 0.2;
    final topColor = hasDetection ? _cfColor(top.cfValue) : Colors.grey;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _bgDark,
        body: CustomScrollView(
          slivers: [
            // ═══════════ SLIVER HEADER ═══════════
            SliverToBoxAdapter(
              child: _buildHeroSection(top, hasDetection, topColor),
            ),

            // ═══════════ CONTENT ═══════════
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (hasDetection) ...[
                    const SizedBox(height: 20),
                    _sectionLabel('Tentang Penyakit'),
                    const SizedBox(height: 10),
                    _diseaseInfoCard(top),
                    const SizedBox(height: 20),
                    _sectionLabel('Rekomendasi Penanganan'),
                    const SizedBox(height: 10),
                    _recommendationsCard(top),
                  ],
                  const SizedBox(height: 20),
                  _sectionLabel('Certainty Factor Semua Penyakit'),
                  const SizedBox(height: 10),
                  _cfAllCard(),
                  const SizedBox(height: 20),
                  _disclaimerCard(),
                  const SizedBox(height: 20),
                  _actionButtons(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(
      DiagnosisResult top, bool hasDetection, Color topColor) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: hasDetection
                  ? [const Color(0xFF004D40), const Color(0xFF00695C)]
                  : [const Color(0xFF263238), const Color(0xFF37474F)],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Status chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: topColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: topColor.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasDetection
                              ? Icons.verified_rounded
                              : Icons.search_off_rounded,
                          color: topColor,
                          size: 15,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hasDetection
                              ? 'Penyakit Terdeteksi'
                              : 'Tidak Terdeteksi',
                          style: TextStyle(
                            color: topColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Nama penyakit
                  Text(
                    hasDetection ? top.disease.name : 'Tanaman Sehat',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),

                  if (!hasDetection) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Gejala yang dipilih tidak menunjukkan indikasi penyakit signifikan.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // CF Progress Card
                  if (hasDetection)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: topColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: topColor.withOpacity(0.4)),
                                ),
                                child: Icon(_diseaseIcon(top.disease.id),
                                    color: topColor, size: 26),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tingkat Kepastian (CF)',
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      top.label,
                                      style: TextStyle(
                                        color: topColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${top.percentage.toStringAsFixed(1)}%',
                                style: TextStyle(
                                  color: topColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: top.cfValue),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeOutCubic,
                              builder: (ctx, v, _) =>
                                  LinearProgressIndicator(
                                value: v,
                                backgroundColor:
                                    Colors.white.withOpacity(0.15),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    topColor),
                                minHeight: 10,
                              ),
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
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00C853), Color(0xFF00897B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _diseaseInfoCard(DiagnosisResult top) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.local_hospital_rounded, 'Nama Penyakit',
              top.disease.name),
          _dividerLine(),
          _infoRow(Icons.science_rounded, 'Penyebab', top.disease.cause),
          _dividerLine(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.description_rounded,
                  color: _accent, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      top.disease.description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 3),
                Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerLine() {
    return Divider(
        color: Colors.white.withOpacity(0.07), height: 20);
  }

  Widget _recommendationsCard(DiagnosisResult top) {
    return _card(
      child: Column(
        children: top.disease.recommendations.asMap().entries.map((e) {
          final i = e.key;
          final rec = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00C853), Color(0xFF00897B)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    rec,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _cfAllCard() {
    return _card(
      child: Column(
        children: widget.results.map((r) {
          final color = _cfColor(r.cfValue);
          final isTop = r == widget.results.first;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Icon(_diseaseIcon(r.disease.id),
                          color: color, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                r.disease.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              if (isTop) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Tertinggi',
                                    style: TextStyle(
                                        color: Color(0xFF00C853),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            r.label,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${r.percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                          color: color,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: r.cfValue),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOutCubic,
                  builder: (ctx, v, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: v,
                      backgroundColor: Colors.white.withOpacity(0.07),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 7,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _disclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFAB00).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: const Color(0xFFFFAB00).withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded,
              color: Color(0xFFFFAB00), size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Hasil ini bersifat rekomendasi awal berdasarkan metode Certainty Factor. Untuk kepastian lebih akurat, konsultasikan dengan penyuluh pertanian setempat.',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.popUntil(context, (r) => r.isFirst);
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00C853), Color(0xFF00897B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C853).withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded, color: Colors.white, size: 22),
                SizedBox(width: 10),
                Text(
                  'Kembali ke Beranda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh_rounded,
                    color: Colors.white.withOpacity(0.7), size: 20),
                const SizedBox(width: 10),
                Text(
                  'Diagnosis Ulang',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
