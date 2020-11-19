import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xff6A56E6);
const primaryColorDark = Color(0xff2e1aae);
const primaryColorLight = Color(0xffffffff);
const errorColor = Color(0xffeb3d00);
const accentColor1 = Color(0xffffa400);
const disabledColor = Color(0xffedecf5);
const textColor = Color(0xff3d3a5b);
const textColorDisabled = Color(0xffbebfd1);

// Text Styles
const title1 =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: textColor);
const title2 =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: textColor);
const title3 =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor);
const title4 =
    TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor);
const title5 = TextStyle(
    fontSize: 15, fontWeight: FontWeight.bold, color: textColorDisabled);
const bodyText1 = TextStyle(fontSize: 20, color: textColor);
const hint1 =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: disabledColor);
final buttonText = ([Color color = primaryColorLight]) =>
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color);

// Animation
const animationDuration = Duration(milliseconds: 300);

abstract class VMAssets {
  static const active = 'assets/active.svg';
  static const avatar_default = 'assets/avatar_default.svg';
  static const btn_ratio_checked = 'assets/btn_ratio_checked.svg';
  static const btn_ratio_unchecked = 'assets/btn_ratio_unchecked.svg';
  static const chevron_left = 'assets/chevron_left.svg';
  static const clock = 'assets/clock.svg';
  static const cross_small = 'assets/cross_small.svg';
  static const cross = 'assets/cross.svg';
  static const finder = 'assets/finder.svg';
  static const load = 'assets/load.svg';
  static const logo = 'assets/logo.svg';
  static const manual = 'assets/manual.svg';
  static const menu = 'assets/menu.svg';
  static const no_internet = 'assets/no_internet.svg';
  static const preloader = 'assets/preloader.svg';
  static const profile_default = 'assets/profile_default.svg';
  static const remove_round = 'assets/remove_round.svg';
  static const scan = 'assets/scan.svg';
  static const success = 'assets/success.svg';
  static const welcome_label = 'assets/welcome_label.svg';
}
