// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get appName {
    return Intl.message("Thoughts Journal", name: 'appName');
  }

  String get title {
    return Intl.message("Title", name: 'title');
  }

  String get titleError {
    return Intl.message("Please enter a title.", name: 'titleError');
  }

  String get details {
    return Intl.message("Details", name: 'details');
  }

  String get detailsError {
    return Intl.message("Please enter details.", name: 'detailsError');
  }

  String get mentalDistortions {
    return Intl.message("Cognitive Distortions", name: 'mentalDistortions');
  }

  String nSelected(n) {
    return Intl.message("${n} selected", name: 'nSelected', args: [n]);
  }

  String get halt {
    return Intl.message("HALT", name: 'halt');
  }

  String get haltSolutionEdit {
    return Intl.message("Did addressing your HALT solve your problem?", name: 'haltSolutionEdit');
  }

  String get rationalThought {
    return Intl.message("Rational Thoughts", name: 'rationalThought');
  }

  String get addNewEntry {
    return Intl.message("Add New Entry", name: 'addNewEntry');
  }

  String get finishEditing {
    return Intl.message("Finish Editing", name: 'finishEditing');
  }

  String get addEntryTitle {
    return Intl.message("Add Journal Entry", name: 'addEntryTitle');
  }

  String get editEntryTitle {
    return Intl.message("Edit Journal Entry", name: 'editEntryTitle');
  }

  String get warning {
    return Intl.message("Warning", name: 'warning');
  }

  String get exitEditorWarning {
    return Intl.message("Are you sure you wish to go back without saving this entry?", name: 'exitEditorWarning');
  }

  String get yes {
    return Intl.message("Yes", name: 'yes');
  }

  String get no {
    return Intl.message("No", name: 'no');
  }

  String get confirmDelete {
    return Intl.message("Confirm Delete", name: 'confirmDelete');
  }

  String get confirmDeleteMessage {
    return Intl.message("Are you sure you would like to delete this entry?", name: 'confirmDeleteMessage');
  }

  String get delete {
    return Intl.message("Delete", name: 'delete');
  }

  String get cancel {
    return Intl.message("Cancel", name: 'cancel');
  }

  String get explainDistortions {
    return Intl.message("Cognitive distortions are simply ways that our mind convinces us of something that isn’t really true. These inaccurate thoughts are usually used to reinforce negative thinking or emotions — telling ourselves things that sound rational and accurate, but really only serve to keep us feeling bad about ourselves. By learning to correctly identify them: a person can then answer the negative thinking back: and refute it.", name: 'explainDistortions');
  }

  String get explainHalt {
    return Intl.message("You can choose whether you are feeling hungry, angry, lonely or tired below. Often times, bad moods stem from these feelings being unaddressed. Once you are done saving this journal entry, try addressing these feelings: for example: by eating something if you're feeling hungry or taking a nap if you're feeling tired. Later, come back to this journal entry and see if you are still feeling that way.", name: 'explainHalt');
  }

  String get chooseHalt {
    return Intl.message("Choose HALT", name: 'chooseHalt');
  }

  String get hungry {
    return Intl.message("Hungry", name: 'hungry');
  }

  String get angry {
    return Intl.message("Angry", name: 'angry');
  }

  String get lonely {
    return Intl.message("Lonely", name: 'lonely');
  }

  String get tired {
    return Intl.message("Tired", name: 'tired');
  }

  String get chooseDistortions {
    return Intl.message("Choose Distortions", name: 'chooseDistortions');
  }

  String get illustrationsBy {
    return Intl.message("Illustrations by Sarah Grohol", name: 'illustrationsBy');
  }

  String get haltSolutionView {
    return Intl.message("Addressing my HALT solved my problem.", name: 'haltSolutionView');
  }

  String get noDistortionsSelected {
    return Intl.message("No distortions selected.", name: 'noDistortionsSelected');
  }

  String get noHaltSelected {
    return Intl.message("No HALT selected.", name: 'noHaltSelected');
  }

  String level(n) {
    return Intl.message("Thought Level: ${n}", name: 'level', args: [n]);
  }

  String get notSelected {
    return Intl.message("Not selected", name: 'notSelected');
  }

  String get viewEntry {
    return Intl.message("View Journal Entry", name: 'viewEntry');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps
