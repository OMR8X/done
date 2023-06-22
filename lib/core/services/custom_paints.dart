import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProgressIndecatorsPainter extends CustomPainter {
  final List<double> data;
  final BuildContext context;
  late double mXUs, mW, mH;
  final double padding;

  ProgressIndecatorsPainter({
    required this.context,
    required this.data,
    this.padding = 3,
  });
  @override
  void paint(Canvas canvas, Size size) {
    initV(size);
    for (int i = 0; i < data.length; i++) {
      Offset os = Offset(((i + 1) * mXUs) - (mXUs / 2), mH / 2);
      Rect rect = Rect.fromCenter(center: os, width: mXUs / 1.3, height: mH);
      canvas.drawRect(
          rect,
          getPainter(
            color: Theme.of(context).dividerColor,
          ));
      double percent = data[i];
      rect = Rect.fromLTRB((os.dx - (mXUs / 2.6)), mH, (os.dx + (mXUs / 2.6)),
          mH - (mH * percent));
      canvas.drawRect(
          rect, getPainter(color: Colors.red, fill: true, shader: true));
    }
  }

  void initV(Size size) {
    mW = size.width;
    mH = size.height;
    mH = size.height;
    mXUs = (size.width / data.length);
    mXUs += data.length % 2 == 0 ? mXUs / 10 : 0;
  }

  Paint getPainter(
      {bool colored = true,
      bool shader = false,
      bool fill = false,
      Color? color}) {
    var rect = Offset.zero & Size(mW, mH);
    Paint paint = Paint()
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..color = colored
          ? (color ?? Theme.of(context).primaryColor)
          : Colors.transparent
      ..strokeWidth = 3;
    if (shader) {
      paint.strokeCap = StrokeCap.round;
      paint.shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).primaryColor.withOpacity(0.1),
          Theme.of(context).primaryColor.withOpacity(0.3),
          Theme.of(context).primaryColor.withOpacity(0.6),
          Theme.of(context).primaryColor.withOpacity(1),
          Theme.of(context).primaryColor.withOpacity(1),
          Theme.of(context).primaryColor,
        ],
      ).createShader(rect);
    }

    return paint;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircularTimeProgressIndecatorPainter extends CustomPainter {
  final Color backGroundColor;
  final Color progressColor;
  final double? lineWidth;
  final double value;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final String? title, subTitle;
  double mainAngle = pi + (pi / 2);
  CircularTimeProgressIndecatorPainter({
    required this.backGroundColor,
    required this.progressColor,
    required this.value,
    this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.lineWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset c = Offset(size.width / 2, size.height / 2);
    Rect rect =
        Rect.fromCenter(center: c, width: c.dx * 1.5, height: c.dy * 1.5);
    canvas.drawArc(rect, pi / 4, -(mainAngle), false, circlePainter());
    canvas.drawArc(rect, pi / 4, -(mainAngle * value), false,
        circlePainter(color: progressColor));
    drawText(canvas, size);
    ///////////////////
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  Paint circlePainter({Color? color}) {
    Paint paint = Paint();
    paint.color = color ?? backGroundColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = lineWidth ?? 10;
    return paint;
  }

  void drawText(Canvas canvas, Size size) {
    double fontSize = 15;
    TextStyle titleStyle =
        this.titleStyle ?? const TextStyle(fontFamily: 'ReadexPro');
    TextStyle subTitleStyle =
        this.subTitleStyle ?? const TextStyle(fontFamily: 'ReadexPro');
    titleStyle = titleStyle.copyWith(fontSize: fontSize * 2);
    subTitleStyle = subTitleStyle.copyWith(fontSize: fontSize / 1.5);
    // 1
    final ParagraphBuilder titleParagraphBuilder = ParagraphBuilder(
      ParagraphStyle(
          fontSize: 22,
          fontFamily: titleStyle.fontFamily,
          fontStyle: titleStyle.fontStyle,
          fontWeight: titleStyle.fontWeight,
          textAlign: TextAlign.center),
    )
      ..pushStyle(titleStyle.getTextStyle())
      ..addText(title ?? '%${(value * 100).round().toString()}');
    // 2
    final ParagraphBuilder subTitleParagraphBuilder = ParagraphBuilder(
      ParagraphStyle(
          fontSize: 22,
          fontFamily: subTitleStyle.fontFamily,
          fontStyle: subTitleStyle.fontStyle,
          fontWeight: subTitleStyle.fontWeight,
          textAlign: TextAlign.center),
    )
      ..pushStyle(subTitleStyle.getTextStyle())
      ..addText(subTitle ?? "مدة الدراسة");
    //
    final Paragraph titleParagraph = titleParagraphBuilder.build()
      ..layout(ParagraphConstraints(width: size.width));
    final Paragraph subTitleParagraph = subTitleParagraphBuilder.build()
      ..layout(ParagraphConstraints(width: size.width));
    //
    canvas.drawParagraph(
        titleParagraph, Offset(0, (size.width / 2) - (fontSize * 2)));
    canvas.drawParagraph(
        subTitleParagraph, Offset(0, (size.width / 2) + (fontSize * 2)));
  }
}
