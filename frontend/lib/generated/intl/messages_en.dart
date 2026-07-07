// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(name) => "\"${name}\" deleted successfully";

  static String m1(amount, currency) => "Amount: ${amount} ${currency}";

  static String m2(category) => "Category: ${category}";

  static String m3(description) => "Description: ${description}";

  static String m4(name) => "Name: ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "add_expense": MessageLookupByLibrary.simpleMessage("Add Expense"),
    "add_new_category": MessageLookupByLibrary.simpleMessage(
      "Add New Category",
    ),
    "added_successfully": MessageLookupByLibrary.simpleMessage(
      "Added successfully",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "category_name": MessageLookupByLibrary.simpleMessage("Category Name"),
    "confirm_delete_expense": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this expense?",
    ),
    "confirm_deletion": MessageLookupByLibrary.simpleMessage(
      "Confirm Deletion",
    ),
    "continue_as_guest": MessageLookupByLibrary.simpleMessage(
      "Continue as Guest",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Date"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleted_successfully": m0,
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? Register here",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "expense_amount_label": m1,
    "expense_category_label": m2,
    "expense_description_label": m3,
    "expense_details": MessageLookupByLibrary.simpleMessage("Expense Details"),
    "expense_name_label": m4,
    "expenses_title": MessageLookupByLibrary.simpleMessage("Expenses"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "no_expenses": MessageLookupByLibrary.simpleMessage(
      "No expenses yet, try adding some!",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "password_length": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwords_match": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "positive_number": MessageLookupByLibrary.simpleMessage(
      "Must be greater than 0",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "repeat_password": MessageLookupByLibrary.simpleMessage("Repeat Password"),
    "required_field": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "select_category": MessageLookupByLibrary.simpleMessage(
      "Select a category",
    ),
    "select_date": MessageLookupByLibrary.simpleMessage("Select a date"),
    "select_option": MessageLookupByLibrary.simpleMessage("Select an option"),
    "tab_expenses": MessageLookupByLibrary.simpleMessage("Expenses"),
    "tab_stats": MessageLookupByLibrary.simpleMessage("Stats"),
    "valid_email": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address",
    ),
    "valid_number": MessageLookupByLibrary.simpleMessage(
      "Enter a valid number",
    ),
  };
}
