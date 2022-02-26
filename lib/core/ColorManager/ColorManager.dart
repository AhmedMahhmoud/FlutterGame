import 'package:flutter/material.dart';

class ColorManager {
  static List<Color> playersCardsColor = [
    HexColor.fromHex("DA5AA7"),
    HexColor.fromHex("2E9CDB"),
    HexColor.fromHex("6B446F"),
    HexColor.fromHex("25AE60"),
    failColor,
    HexColor.fromHex("6B4470"),
    HexColor.fromHex("FFAD1F")
  ];
  static Color primary = HexColor.fromHex("#BE0F24");
  static Color backGroundColor = HexColor.fromHex("#FAFAFA");
  static Color accentColor = HexColor.fromHex("#CAE8F0");
  static Color successColor = Colors.green[500];
  static Color failColor = HexColor.fromHex('EB5757');
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
