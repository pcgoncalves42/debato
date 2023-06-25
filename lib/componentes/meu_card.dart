import 'package:flutter/material.dart';

class MeuCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroud;
  final double? shadowOpacity;
  final double? width;
  final double? height;
  final Color? shadowColor;
  final double? shadowBlurRadius;
  final double? shadowSpreadRadius;
  final Offset? shadowOffset;
  final Border? border;
  final List<Color>? cores;
  final BorderRadius? borderRadius;

  const MeuCard({Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroud = Colors.white,
    this.width,
    this.height,
    this.shadowColor,
    this.shadowOpacity,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
    this.shadowOffset,
    this.cores,
    this.border,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(18.0),
          color: backgroud,
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? const Color(0x1a6080a0),
              offset: shadowOffset ?? const Offset(0, 0),
              blurRadius: shadowBlurRadius ?? 36,
            ),
          ],
        ),
        padding: padding,
        margin: margin,
        child: child
      );
  }
}
