import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  final BuildContext context;
  final AppLocalizations? locale;

  AppLocale(this.context) : locale = AppLocalizations.of(context);

  String get likes => locale?.likes ?? 'Likes';
  String get followers => locale?.followers ?? '';
  String get autoLikes => locale?.autoLikes ?? '';
  String get views => locale?.views ?? '';
  String get comments => locale?.comments ?? '';
  String get perPost => locale?.perPost ?? '';
  String get subscription => locale?.subscription ?? '';
  String get otherSM => locale?.otherSM ?? '';
  String get buy => locale?.buy ?? '';
  String get all => locale?.all ?? '';
  String get reset => locale?.reset ?? '';
  String get next => locale?.next ?? '';
  String get userNameWrong => locale?.userNameWrong ?? '';
  String get urlWrong => locale?.urlWrong ?? '';
  String get emailWrong => locale?.emailWrong ?? '';
  String get privateProfile => locale?.privateProfile ?? '';
  String get addAccount => locale?.addAccount ?? '';
  String get impressionsDescr => locale?.impressionsDescr ?? '';
  String get reachDescr => locale?.reachDescr ?? '';
  String get savesDescr => locale?.savesDescr ?? '';
  String get gotIt => locale?.gotIt ?? '';
}
