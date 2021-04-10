import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegularText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const RegularText({Key key, this.text, this.color, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        fontSize: size,
        color: color,
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const BoldText({Key key, this.text, this.color, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ShadowBoldText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const ShadowBoldText({Key key, this.text, this.color, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
          fontSize: size,
          color: color,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ]),
    );
  }
}
