import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/disease_model.dart';
import '../models/cf_engine.dart';
import 'result_page.dart';

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage>
    with TickerProviderStateMixin {
  final Map<String, double> selectedSymptoms = {};
  late AnimationController _headerController;
  late AnimationController _fabController;
  late Animation<double> _headerAnim;
  late Animation<double> _fabScaleAnim;
  final ScrollController _scrollController = ScrollController();

  static const List<Map<String, dynamic>> cfOptions = [
    {
      'label': 'Sangat Yakin',
      'sublabel': '100%',
      'value': 1.0,
      'color': Color(0xFF00C853),
      'icon': Icons.check_circle_rounded,
    },
    {
      'label': 'Cukup Yakin',
      'sublabel': '60%',
      'value': 0.6,
      'color': Color(0xFFFFAB00),
      'icon': Icons.help_rounded,
    },
    {
      'label': 'Kurang Yakin',
      'sublabel': '40%',
      'value': 0.4,
      'color': Color(0xFFFF5722),
      'icon': Icons.remove_circle_rounded,
    },
  ];

  // Warna tema utama
  static const Color _primary = Color(0xFF00897B); // teal-green
  static const Color _primaryDark = Color(0xFF00695C);
  static const Color _accent = Color(0xFF64FFDA);
  static const Color _bgDark = Color(0xFF0D1F1C);
  static const Color _bgCard = Color(0xFF1A2E2B);
  static const Color _bgCardLight = Color(0xFF1E3530);

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _headerAnim = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    );
    _fabScaleAnim = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _fabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void toggleSymptom(String id, double cfUser) {
    HapticFeedback.lightImpact();
    setState(() {
      if (selectedSymptoms.containsKey(id)) {
        selectedSymptoms.remove(id);
      } else {
        selectedSymptoms[id] = cfUser;
      }
    });
    if (selectedSymptoms.isNotEmpty) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  void updateCfUser(String id, double cfUser) {
    HapticFeedback.selectionClick();
    setState(() {
      if (selectedSymptoms.containsKey(id)) {
        selectedSymptoms[id] = cfUser;
      }
    });
  }

  void clearSelection() {
    HapticFeedback.mediumImpact();
    setState(() {
      selectedSymptoms.clear();
    });
    _fabController.reverse();
  }

  void runDiagnosis() {
    HapticFeedback.heavyImpact();
    final results = CfEngine.diagnose(selectedSymptoms);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => ResultPage(results: results),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _bgDark,
        body: Column(
          children: [
            // ══════════════════════════ HEADER ══════════════════════════
            _buildHeader(),

            // ══════════════════════════ LIST GEJALA ══════════════════════════
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.fromLTRB(16, 8, 16, 120),
                itemCount: kSymptoms.length,
                itemBuilder: (context, index) {
                  return _buildSymptomCard(kSymptoms[index], index);
                },
              ),
            ),
          ],
        ),

        // ══════════════════════════ BOTTOM FAB ══════════════════════════
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerAnim,
      builder: (context, child) {
        return FadeTransition(
          opacity: _headerAnim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.3),
              end: Offset.zero,
            ).animate(_headerAnim),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF004D40), Color(0xFF00897B)],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: back + reset
                Row(
                  children: [
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
                    const Spacer(),
                    if (selectedSymptoms.isNotEmpty)
                      GestureDetector(
                        onTap: clearSelection,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.refresh_rounded,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              const Text(
                                'Reset',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Judul
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.biotech_rounded,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diagnosis Penyakit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'Tanaman Padi',
                          style: TextStyle(
                            color: Color(0xFFB2DFDB),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Info box
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.touch_app_rounded,
                          color: Color(0xFF64FFDA), size: 22),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Pilih gejala yang terlihat, lalu tentukan tingkat keyakinan Anda.',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Legenda CF
                Row(
                  children: cfOptions.map((opt) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: (opt['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: (opt['color'] as Color).withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: opt['color'],
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                opt['label'],
                                style: TextStyle(
                                    color: opt['color'],
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomCard(Symptom symptom, int index) {
    final isSelected = selectedSymptoms.containsKey(symptom.id);
    final currentCf = selectedSymptoms[symptom.id] ?? 1.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + index * 40),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => toggleSymptom(symptom.id, currentCf),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      const Color(0xFF00897B).withOpacity(0.25),
                      const Color(0xFF004D40).withOpacity(0.35),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [_bgCard, _bgCardLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? _primary.withOpacity(0.7)
                  : Colors.white.withOpacity(0.07),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: _primary.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Column(
            children: [
              // ── Baris utama ──
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nomor + checkbox
                    Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF00C853),
                                      Color(0xFF00897B)
                                    ],
                                  )
                                : null,
                            color: isSelected
                                ? null
                                : Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1.5),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 16)
                              : Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 14),

                    // Nama + deskripsi
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symptom.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? _accent
                                  : Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            symptom.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Badge CF jika dipilih
                    if (isSelected)
                      _cfBadge(currentCf),
                  ],
                ),
              ),

              // ── Panel keyakinan (expandable) ──
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: isSelected
                    ? _buildCfPanel(symptom.id, currentCf)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cfBadge(double cf) {
    final opt = cfOptions.firstWhere(
      (o) => (o['value'] as double) == cf,
      orElse: () => cfOptions.first,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: (opt['color'] as Color).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: (opt['color'] as Color).withOpacity(0.5)),
      ),
      child: Text(
        opt['sublabel'],
        style: TextStyle(
          color: opt['color'],
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCfPanel(String id, double currentCf) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: Colors.white.withOpacity(0.1),
            height: 1,
          ),
          const SizedBox(height: 12),
          Text(
            'Seberapa yakin Anda dengan gejala ini?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: cfOptions.map((opt) {
              final isActive = currentCf == opt['value'];
              return Expanded(
                child: GestureDetector(
                  onTap: () => updateCfUser(id, opt['value']),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isActive
                          ? LinearGradient(
                              colors: [
                                (opt['color'] as Color).withOpacity(0.3),
                                (opt['color'] as Color).withOpacity(0.15),
                              ],
                            )
                          : null,
                      color: isActive
                          ? null
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive
                            ? (opt['color'] as Color).withOpacity(0.8)
                            : Colors.white.withOpacity(0.1),
                        width: isActive ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          opt['icon'],
                          color: isActive
                              ? opt['color']
                              : Colors.white.withOpacity(0.3),
                          size: 20,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          opt['sublabel'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? opt['color']
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                        Text(
                          opt['label'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            color: isActive
                                ? (opt['color'] as Color).withOpacity(0.8)
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: _bgCard,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indikator gejala terpilih
          Row(
            children: [
              // Animasi counter
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '${selectedSymptoms.length}',
                  key: ValueKey(selectedSymptoms.length),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _accent,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gejala Terpilih',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    selectedSymptoms.isEmpty
                        ? 'Pilih minimal 1 gejala'
                        : 'dari ${kSymptoms.length} total gejala',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Mini pills preview
              if (selectedSymptoms.isNotEmpty)
                SizedBox(
                  width: 80,
                  height: 24,
                  child: Stack(
                    children: List.generate(
                      selectedSymptoms.length.clamp(0, 3),
                      (i) => Positioned(
                        left: i * 18.0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00C853), Color(0xFF00897B)],
                            ),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: _bgCard, width: 2),
                          ),
                          child: const Icon(Icons.check,
                              color: Colors.white, size: 12),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          // Tombol Analisis
          GestureDetector(
            onTap: selectedSymptoms.isEmpty ? null : runDiagnosis,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: selectedSymptoms.isNotEmpty
                    ? const LinearGradient(
                        colors: [Color(0xFF00C853), Color(0xFF00897B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: selectedSymptoms.isEmpty
                    ? Colors.white.withOpacity(0.08)
                    : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: selectedSymptoms.isNotEmpty
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00C853).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.biotech_rounded,
                    color: selectedSymptoms.isNotEmpty
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Analisis Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedSymptoms.isNotEmpty
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (selectedSymptoms.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white, size: 18),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
