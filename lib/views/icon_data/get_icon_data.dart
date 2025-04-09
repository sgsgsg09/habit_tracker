import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData getIconData(String iconName) {
  switch (iconName) {
    case 'tint':
      return FontAwesomeIcons.droplet;
    case 'running':
      return FontAwesomeIcons.personRunning;
    case 'pills':
      return FontAwesomeIcons.pills;
    case 'spa':
      return FontAwesomeIcons.spa;
    case 'book':
      return FontAwesomeIcons.book;
    case 'sun':
      return FontAwesomeIcons.sun;
    case 'yin_yang':
      return FontAwesomeIcons.yinYang;
    case 'walking':
      return FontAwesomeIcons.personWalking;
    case 'journal_whills':
      return FontAwesomeIcons.bookJournalWhills;
    case 'code':
      return FontAwesomeIcons.code;
    case 'heart':
      return FontAwesomeIcons.heart;
    case 'star':
      return FontAwesomeIcons.star;
    default:
      return FontAwesomeIcons.circleQuestion;
  }
}
