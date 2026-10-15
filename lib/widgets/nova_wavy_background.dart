import 'dart:math' as math;
import 'package:flutter/material.dart';

class NovaWavyBackground extends StatefulWidget {
  final Widget? child;
  const NovaWavyBackground({super.key, this.child});

  @override
  State<NovaWavyBackground> createState() => _NovaWavyBackgroundState();
}

class _NovaWavyBackgroundState extends State<NovaWavyBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller1;
  late final AnimationController _controller2;
  late final AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    // Phase 1: 7000ms 0 -> 2pi
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..repeat();

    // Phase 2: 9500ms 2pi -> 0
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9500),
    )..repeat();

    // Phase 3: 12000ms 0 -> 2pi
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller1, _controller2, _controller3]),
      builder: (context, child) {
        final phase1 = _controller1.value * 2 * math.pi;
        final phase2 = (1.0 - _controller2.value) * 2 * math.pi;
        final phase3 = _controller3.value * 2 * math.pi;

        return CustomPaint(
          painter: _NovaWavyBackgroundPainter(
            phase1: phase1,
            phase2: phase2,
            phase3: phase3,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class _NovaWavyBackgroundPainter extends CustomPainter {
  final double phase1;
  final double phase2;
  final double phase3;

  _NovaWavyBackgroundPainter({
    required this.phase1,
    required this.phase2,
    required this.phase3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // 0. Base vertical gradient
    final bgRect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFEDE9FE), // Soft rich violet
          Color(0xFFF5F3FF),
          Color(0xFFFAF8FF),
          Color(0xFFEEF2FF),
          Color(0xFFDDD6FE), // Rich lavender
        ],
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // ----------------------------------------------------
    // 1. TOP WAVE LAYER 1 (Deep Royal Indigo to Violet)
    // ----------------------------------------------------
    final topWave1 = Path()..moveTo(0, 0);
    final startY1 = height * 0.17 + 25.0 * math.sin(phase1);
    topWave1.lineTo(0, startY1);
    final cp1X1 = width * 0.35;
    final cp1Y1 = height * 0.17 + 42.0 * math.cos(phase1);
    final cp2X1 = width * 0.68;
    final cp2Y1 = height * 0.17 - 38.0 * math.sin(phase1);
    final endY1 = height * 0.17 + 22.0 * math.cos(phase1);
    topWave1.cubicTo(cp1X1, cp1Y1, cp2X1, cp2Y1, width, endY1);
    topWave1.lineTo(width, 0);
    topWave1.close();

    final topWave1Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF1E1B4B).withValues(alpha: 0.88),
          const Color(0xFF312E81).withValues(alpha: 0.82),
          const Color(0xFF4F46E5).withValues(alpha: 0.80),
          const Color(0xFF7C3AED).withValues(alpha: 0.85),
        ],
      ).createShader(Rect.fromPoints(Offset.zero, Offset(width, height * 0.20)));
    canvas.drawPath(topWave1, topWave1Paint);

    // ----------------------------------------------------
    // 2. TOP WAVE LAYER 2 (Electric Violet to Magenta)
    // ----------------------------------------------------
    final topWave2 = Path()..moveTo(0, 0);
    final startY2 = height * 0.21 + 32.0 * math.cos(phase2);
    topWave2.lineTo(0, startY2);
    final cp1X2 = width * 0.28;
    final cp1Y2 = height * 0.21 - 48.0 * math.sin(phase2);
    final cp2X2 = width * 0.72;
    final cp2Y2 = height * 0.21 + 44.0 * math.cos(phase2);
    final endY2 = height * 0.21 - 28.0 * math.sin(phase2);
    topWave2.cubicTo(cp1X2, cp1Y2, cp2X2, cp2Y2, width, endY2);
    topWave2.lineTo(width, 0);
    topWave2.close();

    final topWave2Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF4338CA).withValues(alpha: 0.70),
          const Color(0xFF6366F1).withValues(alpha: 0.65),
          const Color(0xFFA855F7).withValues(alpha: 0.60),
          const Color(0xFFEC4899).withValues(alpha: 0.50),
        ],
      ).createShader(Rect.fromPoints(Offset.zero, Offset(width, height * 0.25)));
    canvas.drawPath(topWave2, topWave2Paint);

    // Luminous glowing neon stroke along top wave 2 crest
    final topCrestPath = Path()
      ..moveTo(0, startY2)
      ..cubicTo(cp1X2, cp1Y2, cp2X2, cp2Y2, width, endY2);

    final topCrestPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF38BDF8),
          Color(0xFF818CF8),
          Color(0xFFC084FC),
          Color(0xFFF472B6),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height * 0.15), Offset(width, height * 0.25)));
    canvas.drawPath(topCrestPath, topCrestPaint);

    // ----------------------------------------------------
    // 3. MIDDLE TRANSLUCENT FLUID RIBBONS (Behind Form Card)
    // ----------------------------------------------------
    final midRibbon1 = Path();
    final mid1StartY = height * 0.46 + 35.0 * math.sin(phase1 * 0.8);
    midRibbon1.moveTo(0, mid1StartY);
    final mid1Cp1X = width * 0.35;
    final mid1Cp1Y = height * 0.46 - 52.0 * math.cos(phase1 * 0.8);
    final mid1Cp2X = width * 0.65;
    final mid1Cp2Y = height * 0.46 + 50.0 * math.sin(phase1 * 0.8);
    final mid1EndY = height * 0.46 - 30.0 * math.cos(phase1 * 0.8);
    midRibbon1.cubicTo(mid1Cp1X, mid1Cp1Y, mid1Cp2X, mid1Cp2Y, width, mid1EndY);
    midRibbon1.lineTo(width, mid1EndY + 85.0);
    final bcp1X = width * 0.65;
    final bcp1Y = height * 0.46 + 50.0 * math.sin(phase1 * 0.8) + 85.0;
    final bcp2X = width * 0.35;
    final bcp2Y = height * 0.46 - 52.0 * math.cos(phase1 * 0.8) + 85.0;
    midRibbon1.cubicTo(bcp1X, bcp1Y, bcp2X, bcp2Y, 0, mid1StartY + 85.0);
    midRibbon1.close();

    final midRibbon1Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFF6366F1).withValues(alpha: 0.28),
          const Color(0xFF8B5CF6).withValues(alpha: 0.25),
          const Color(0xFFEC4899).withValues(alpha: 0.20),
          const Color(0xFF06B6D4).withValues(alpha: 0.22),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height * 0.42), Offset(width, height * 0.52)));
    canvas.drawPath(midRibbon1, midRibbon1Paint);

    final midRibbon2 = Path();
    final mid2StartY = height * 0.58 + 40.0 * math.cos(phase3);
    midRibbon2.moveTo(0, mid2StartY);
    final mid2Cp1X = width * 0.30;
    final mid2Cp1Y = height * 0.58 + 55.0 * math.sin(phase3);
    final mid2Cp2X = width * 0.70;
    final mid2Cp2Y = height * 0.58 - 45.0 * math.cos(phase3);
    final mid2EndY = height * 0.58 + 35.0 * math.sin(phase3);
    midRibbon2.cubicTo(mid2Cp1X, mid2Cp1Y, mid2Cp2X, mid2Cp2Y, width, mid2EndY);
    midRibbon2.lineTo(width, mid2EndY + 70.0);
    final bcp2X1 = width * 0.70;
    final bcp2Y1 = height * 0.58 - 45.0 * math.cos(phase3) + 70.0;
    final bcp2X2 = width * 0.30;
    final bcp2Y2 = height * 0.58 + 55.0 * math.sin(phase3) + 70.0;
    midRibbon2.cubicTo(bcp2X1, bcp2Y1, bcp2X2, bcp2Y2, 0, mid2StartY + 70.0);
    midRibbon2.close();

    final midRibbon2Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFF06B6D4).withValues(alpha: 0.20),
          const Color(0xFF4F46E5).withValues(alpha: 0.26),
          const Color(0xFFA855F7).withValues(alpha: 0.22),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height * 0.55), Offset(width, height * 0.65)));
    canvas.drawPath(midRibbon2, midRibbon2Paint);

    // ----------------------------------------------------
    // 4. BOTTOM WAVE LAYER 1 (Deep Royal Indigo Base)
    // ----------------------------------------------------
    final bottomWave1 = Path()..moveTo(0, height);
    final bot1StartY = height * 0.78 + 32.0 * math.sin(phase3);
    bottomWave1.lineTo(0, bot1StartY);
    final bot1Cp1X = width * 0.35;
    final bot1Cp1Y = height * 0.78 - 48.0 * math.cos(phase3);
    final bot1Cp2X = width * 0.68;
    final bot1Cp2Y = height * 0.78 + 42.0 * math.sin(phase3);
    final bot1EndY = height * 0.78 - 26.0 * math.cos(phase3);
    bottomWave1.cubicTo(bot1Cp1X, bot1Cp1Y, bot1Cp2X, bot1Cp2Y, width, bot1EndY);
    bottomWave1.lineTo(width, height);
    bottomWave1.close();

    final bottomWave1Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xFF1E1B4B).withValues(alpha: 0.92),
          const Color(0xFF2514A5).withValues(alpha: 0.88),
          const Color(0xFF4F46E5).withValues(alpha: 0.85),
          const Color(0xFF7C3AED).withValues(alpha: 0.90),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height), Offset(width, height * 0.75)));
    canvas.drawPath(bottomWave1, bottomWave1Paint);

    // ----------------------------------------------------
    // 5. BOTTOM WAVE LAYER 2 (Vivid Purple to Cyan Crest)
    // ----------------------------------------------------
    final bottomWave2 = Path()..moveTo(0, height);
    final bot2StartY = height * 0.83 + 36.0 * math.cos(phase1);
    bottomWave2.lineTo(0, bot2StartY);
    final bot2Cp1X = width * 0.28;
    final bot2Cp1Y = height * 0.83 + 52.0 * math.sin(phase1);
    final bot2Cp2X = width * 0.72;
    final bot2Cp2Y = height * 0.83 - 44.0 * math.cos(phase1);
    final bot2EndY = height * 0.83 + 32.0 * math.sin(phase1);
    bottomWave2.cubicTo(bot2Cp1X, bot2Cp1Y, bot2Cp2X, bot2Cp2Y, width, bot2EndY);
    bottomWave2.lineTo(width, height);
    bottomWave2.close();

    final bottomWave2Paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xFF6B21A8).withValues(alpha: 0.78),
          const Color(0xFF9333EA).withValues(alpha: 0.72),
          const Color(0xFFC026D3).withValues(alpha: 0.68),
          const Color(0xFF06B6D4).withValues(alpha: 0.62),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height), Offset(width, height * 0.80)));
    canvas.drawPath(bottomWave2, bottomWave2Paint);

    // Luminous glowing neon stroke along bottom wave 2 crest
    final bottomCrestPath = Path()
      ..moveTo(0, bot2StartY)
      ..cubicTo(bot2Cp1X, bot2Cp1Y, bot2Cp2X, bot2Cp2Y, width, bot2EndY);

    final bottomCrestPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF06B6D4),
          Color(0xFFE879F9),
          Color(0xFFF43F5E),
        ],
      ).createShader(Rect.fromPoints(Offset(0, height * 0.83), Offset(width, height * 0.88)));
    canvas.drawPath(bottomCrestPath, bottomCrestPaint);

    // ----------------------------------------------------
    // 6. FLOATING GLOWING ORBS / ACCENTS ALONG WAVES
    // ----------------------------------------------------
    // Top orb
    final topOrbCenter = Offset(width * 0.85, height * 0.12);
    final topOrbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF38BDF8).withValues(alpha: 0.45),
          const Color(0xFF818CF8).withValues(alpha: 0.20),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: topOrbCenter, radius: 45.0));
    canvas.drawCircle(topOrbCenter, 45.0, topOrbPaint);

    // Bottom accent orb
    final botOrbCenter = Offset(width * 0.15, height * 0.88);
    final botOrbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFEC4899).withValues(alpha: 0.40),
          const Color(0xFF9333EA).withValues(alpha: 0.18),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: botOrbCenter, radius: 55.0));
    canvas.drawCircle(botOrbCenter, 55.0, botOrbPaint);
  }

  @override
  bool shouldRepaint(covariant _NovaWavyBackgroundPainter oldDelegate) =>
      oldDelegate.phase1 != phase1 ||
      oldDelegate.phase2 != phase2 ||
      oldDelegate.phase3 != phase3;
}
