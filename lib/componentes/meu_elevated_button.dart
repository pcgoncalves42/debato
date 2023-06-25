import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeuElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? iconSize;
  final bool upperCase;
  final BoxFit? fit;
  final bool iconLeft;
  final bool hideIcon;
  final bool expanded;

  const MeuElevatedButton({Key? key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.padding,
    this.fontSize,
    this.iconSize,
    this.upperCase = true,
    this.fit,
    this.iconLeft = false,
    this.hideIcon = false,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    IconData iconData = iconLeft ? Icons.chevron_left : Icons.chevron_right;
    if(icon != null) iconData = icon!;

    Widget wIcon = Icon(iconData,
      color: Colors.white,
      size: iconSize ?? 26.0
    );

    Widget wText = Text(upperCase ? label.toUpperCase() : label,
      style: GoogleFonts.nunitoSans(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 19.0
      )
    );

    if(icon != null){
      wIcon =  Padding(
        padding: iconLeft ? const EdgeInsets.only(right: 6.0) : const EdgeInsets.only(left: 6.0),
        child: wIcon,
      );

      wText = Text(upperCase ? label.toUpperCase() : label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: fontSize ?? 18.0
        )
      );
    }

    Widget wTextWapper = Center(child: wText);

    if(fit != null){
      wTextWapper = Expanded(
        child: FittedBox(
          fit: fit!,
          alignment: Alignment.center,
          child: wText
        ),
      );
    }else if(expanded){
      wTextWapper = Expanded(child: wTextWapper);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        padding: padding,
        shadowColor: const Color(0x1a6080a0),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(!hideIcon && iconLeft) wIcon,
          wTextWapper,
          if(!hideIcon && !iconLeft) wIcon
        ],
      )
    );
  }
}
