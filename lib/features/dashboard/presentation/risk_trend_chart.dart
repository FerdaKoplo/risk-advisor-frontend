import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../data/dashboard_model.dart';

class RiskTrendChart extends StatelessWidget {
  final List<TrendPoint> data;
  final double height;

  const RiskTrendChart({super.key, required this.data, this.height = 180});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(height: height, child: Center(child: Text('No data', style: AppStyles.body)));
    }

    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: CustomPaint(
          painter: _LineChartPainter(data),
          child: Container(),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<TrendPoint> data;
  _LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..color = AppColors.primary.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final paintGrid = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;

    // chart margins
    final double left = 8;
    final double right = 8;
    final double top = 8;
    final double bottom = 24;

    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;

    final values = data.map((e) => e.value.toDouble()).toList();
    final maxVal = (values.reduce((a, b) => a > b ? a : b) * 1.1).clamp(1.0, double.infinity);
    final minVal = (values.reduce((a, b) => a < b ? a : b) * 0.9);

    // draw horizontal grid lines (3 lines)
    for (int i = 0; i <= 3; i++) {
      final y = top + chartHeight * (i / 3);
      canvas.drawLine(Offset(left, y), Offset(left + chartWidth, y), paintGrid);
    }

    // compute points
    final stepX = chartWidth / (values.length - 1);
    final points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final x = left + stepX * i;
      // map value to y (invert because canvas y increases downwards)
      final normalized = (values[i] - minVal) / (maxVal - minVal);
      final y = top + chartHeight * (1 - normalized.clamp(0.0, 1.0));
      points.add(Offset(x, y));
    }

    // draw fill area
    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      for (var p in points) {
        path.lineTo(p.dx, p.dy);
      }
      // close to bottom
      path.lineTo(points.last.dx, top + chartHeight);
      path.lineTo(points.first.dx, top + chartHeight);
      path.close();
      canvas.drawPath(path, paintFill);
    }

    // draw line
    final pathLine = Path();
    if (points.isNotEmpty) {
      pathLine.moveTo(points.first.dx, points.first.dy);
      for (var i = 1; i < points.length; i++) {
        // draw smooth curve using quadratic bezier
        final prev = points[i - 1];
        final cur = points[i];
        final mid = Offset((prev.dx + cur.dx) / 2, (prev.dy + cur.dy) / 2);
        pathLine.quadraticBezierTo(prev.dx, prev.dy, mid.dx, mid.dy);
      }
      // connect last point
      pathLine.lineTo(points.last.dx, points.last.dy);
      canvas.drawPath(pathLine, paintLine);
    }

    // draw data points
    final paintDot = Paint()..color = AppColors.primary;
    for (var p in points) {
      canvas.drawCircle(p, 3.6, paintDot);
    }

    // draw labels (x-axis)
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final labelStyle = AppStyles.body.copyWith(fontSize: 11);
    final visibleLabelCount = data.length <= 7 ? data.length : 7;
    final stepLabel = (data.length / visibleLabelCount).ceil();

    for (int i = 0; i < data.length; i += stepLabel) {
      final lp = data[i].label;
      textPainter.text = TextSpan(text: lp, style: labelStyle);
      textPainter.layout();
      final px = left + stepX * i - textPainter.width / 2;
      final py = top + chartHeight + 6;
      textPainter.paint(canvas, Offset(px, py));
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
