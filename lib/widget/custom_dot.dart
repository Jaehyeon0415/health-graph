import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomDotPainter extends FlDotPainter {
  CustomDotPainter({
    this.color = Colors.white,
    // this.image,
    double? radius,
  }) : radius = radius ?? 4.0;

  /// The fill color to use for the circle
  final Color color;

  // final ui.Image? image;

  /// Customizes the radius of the circle
  final double radius;

  /// Implementation of the parent class to draw the circle
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // if (image == null) return;

    canvas.drawCircle(
      offsetInCanvas,
      radius,
      Paint()
        ..color = color.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill,
    );

    // TODO: 이미지/아이콘 추가
    // canvas.drawImage(
    //   image!,
    //   offsetInCanvas,
    //   Paint(),
    // );
  }

  /// Implementation of the parent class to get the size of the circle
  @override
  Size getSize(FlSpot spot) => Size.fromRadius(radius);

  @override
  Color get mainColor => color;

  FlDotCirclePainter _lerp(
    FlDotCirclePainter a,
    FlDotCirclePainter b,
    double t,
  ) =>
      FlDotCirclePainter(
        color: Color.lerp(a.color, b.color, t)!,
        radius: ui.lerpDouble(a.radius, b.radius, t),
        strokeColor: Color.lerp(a.strokeColor, b.strokeColor, t)!,
        strokeWidth: ui.lerpDouble(a.strokeWidth, b.strokeWidth, t)!,
      );

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is! FlDotCirclePainter || b is! FlDotCirclePainter) {
      return b;
    }
    return _lerp(a, b, t);
  }

  @override
  bool hitTest(
    FlSpot spot,
    Offset touched,
    Offset center,
    double extraThreshold,
  ) {
    final distance = (touched - center).distance.abs();
    return distance < radius + extraThreshold;
  }

  /// Used for equality check, see [EquatableMixin].
  @override
  List<Object?> get props => [
        color,
        radius,
      ];
}