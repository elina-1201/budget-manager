// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bs locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'bs';

  static String m0(name) => "\"${name}\" uspješno obrisano";

  static String m1(amount, currency) => "Iznos: ${amount} KM";

  static String m2(category) => "Kategorija: ${category}";

  static String m3(description) => "Opis: ${description}";

  static String m4(name) => "Naziv: ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Dodaj"),
    "add_expense": MessageLookupByLibrary.simpleMessage("Dodaj trošak"),
    "add_new_category": MessageLookupByLibrary.simpleMessage(
      "Dodaj novu kategoriju",
    ),
    "added_successfully": MessageLookupByLibrary.simpleMessage(
      "Uspješno dodano",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Iznos"),
    "cancel": MessageLookupByLibrary.simpleMessage("Odustani"),
    "category_name": MessageLookupByLibrary.simpleMessage("Naziv kategorije"),
    "confirm_delete_expense": MessageLookupByLibrary.simpleMessage(
      "Jeste li sigurni da želite obrisati ovaj trošak?",
    ),
    "confirm_deletion": MessageLookupByLibrary.simpleMessage(
      "Potvrdi brisanje",
    ),
    "continue_as_guest": MessageLookupByLibrary.simpleMessage(
      "Nastavi kao gost",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Datum"),
    "delete": MessageLookupByLibrary.simpleMessage("Obriši"),
    "deleted_successfully": m0,
    "description": MessageLookupByLibrary.simpleMessage("Opis"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Nemate račun? Registrujte se ovdje",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "expense_amount_label": m1,
    "expense_category_label": m2,
    "expense_description_label": m3,
    "expense_details": MessageLookupByLibrary.simpleMessage("Detalji troška"),
    "expense_name_label": m4,
    "expenses_title": MessageLookupByLibrary.simpleMessage("Troškovi"),
    "loading": MessageLookupByLibrary.simpleMessage("Učitavanje..."),
    "login": MessageLookupByLibrary.simpleMessage("Prijava"),
    "name": MessageLookupByLibrary.simpleMessage("Ime"),
    "no_expenses": MessageLookupByLibrary.simpleMessage(
      "Nema troškova zasad, pokušaj dodati neke!",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Lozinka"),
    "password_length": MessageLookupByLibrary.simpleMessage(
      "Lozinka mora imati najmanje 8 znakova",
    ),
    "passwords_match": MessageLookupByLibrary.simpleMessage(
      "Lozinke se ne podudaraju",
    ),
    "positive_number": MessageLookupByLibrary.simpleMessage(
      "Mora biti veće od 0",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Registracija"),
    "repeat_password": MessageLookupByLibrary.simpleMessage("Ponovi lozinku"),
    "required_field": MessageLookupByLibrary.simpleMessage(
      "Ovo polje je obavezno",
    ),
    "select_category": MessageLookupByLibrary.simpleMessage(
      "Odaberite kategoriju",
    ),
    "select_date": MessageLookupByLibrary.simpleMessage("Odaberite datum"),
    "select_option": MessageLookupByLibrary.simpleMessage("Odaberite opciju"),
    "tab_expenses": MessageLookupByLibrary.simpleMessage("Troškovi"),
    "tab_stats": MessageLookupByLibrary.simpleMessage("Statistika"),
    "valid_email": MessageLookupByLibrary.simpleMessage(
      "Unesite ispravnu email adresu",
    ),
    "valid_number": MessageLookupByLibrary.simpleMessage(
      "Unesite ispravan broj",
    ),
  };
}
