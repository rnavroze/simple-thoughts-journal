// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"appName" : MessageLookupByLibrary.simpleMessage("Thoughts Journal"),
		"title" : MessageLookupByLibrary.simpleMessage("Title"),
		"titleError" : MessageLookupByLibrary.simpleMessage("Please enter a title."),
		"details" : MessageLookupByLibrary.simpleMessage("Details"),
		"detailsError" : MessageLookupByLibrary.simpleMessage("Please enter details."),
		"mentalDistortions" : MessageLookupByLibrary.simpleMessage("Cognitive Distortions"),
		"nSelected" : (n) => "${n} selected",
		"halt" : MessageLookupByLibrary.simpleMessage("HALT"),
		"haltSolutionEdit" : MessageLookupByLibrary.simpleMessage("Did addressing your HALT solve your problem?"),
		"rationalThought" : MessageLookupByLibrary.simpleMessage("Rational Thoughts"),
		"addNewEntry" : MessageLookupByLibrary.simpleMessage("Add New Entry"),
		"finishEditing" : MessageLookupByLibrary.simpleMessage("Finish Editing"),
		"addEntryTitle" : MessageLookupByLibrary.simpleMessage("Add Journal Entry"),
		"editEntryTitle" : MessageLookupByLibrary.simpleMessage("Edit Journal Entry"),
		"warning" : MessageLookupByLibrary.simpleMessage("Warning"),
		"exitEditorWarning" : MessageLookupByLibrary.simpleMessage("Are you sure you wish to go back without saving this entry?"),
		"yes" : MessageLookupByLibrary.simpleMessage("Yes"),
		"no" : MessageLookupByLibrary.simpleMessage("No"),
		"confirmDelete" : MessageLookupByLibrary.simpleMessage("Confirm Delete"),
		"confirmDeleteMessage" : MessageLookupByLibrary.simpleMessage("Are you sure you would like to delete this entry?"),
		"delete" : MessageLookupByLibrary.simpleMessage("Delete"),
		"cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
		"explainDistortions" : MessageLookupByLibrary.simpleMessage("Cognitive distortions are simply ways that our mind convinces us of something that isn’t really true. These inaccurate thoughts are usually used to reinforce negative thinking or emotions — telling ourselves things that sound rational and accurate, but really only serve to keep us feeling bad about ourselves. By learning to correctly identify them: a person can then answer the negative thinking back: and refute it."),
		"explainHalt" : MessageLookupByLibrary.simpleMessage("You can choose whether you are feeling hungry, angry, lonely or tired below. Often times, bad moods stem from these feelings being unaddressed. Once you are done saving this journal entry, try addressing these feelings: for example: by eating something if you're feeling hungry or taking a nap if you're feeling tired. Later, come back to this journal entry and see if you are still feeling that way."),
		"chooseHalt" : MessageLookupByLibrary.simpleMessage("Choose HALT"),
		"hungry" : MessageLookupByLibrary.simpleMessage("Hungry"),
		"angry" : MessageLookupByLibrary.simpleMessage("Angry"),
		"lonely" : MessageLookupByLibrary.simpleMessage("Lonely"),
		"tired" : MessageLookupByLibrary.simpleMessage("Tired"),
		"chooseDistortions" : MessageLookupByLibrary.simpleMessage("Choose Distortions"),
		"illustrationsBy" : MessageLookupByLibrary.simpleMessage("Illustrations by Sarah Grohol"),
		"haltSolutionView" : MessageLookupByLibrary.simpleMessage("Addressing my HALT solved my problem."),
		"noDistortionsSelected" : MessageLookupByLibrary.simpleMessage("No distortions selected."),
		"noHaltSelected" : MessageLookupByLibrary.simpleMessage("No HALT selected."),
		"level" : (n) => "Thought Level: ${n}",
		"notSelected" : MessageLookupByLibrary.simpleMessage("Not selected"),
		"viewEntry" : MessageLookupByLibrary.simpleMessage("View Journal Entry"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"en": () => Future.value(null),

};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case "en":
        return _$en;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps
