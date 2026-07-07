// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `No expenses yet, try adding some!`
  String get no_expenses {
    return Intl.message(
      'No expenses yet, try adding some!',
      name: 'no_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account? Register here`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account? Register here',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continue_as_guest {
    return Intl.message(
      'Continue as Guest',
      name: 'continue_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Repeat Password`
  String get repeat_password {
    return Intl.message(
      'Repeat Password',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get add_expense {
    return Intl.message('Add Expense', name: 'add_expense', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Select a date`
  String get select_date {
    return Intl.message(
      'Select a date',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Added successfully`
  String get added_successfully {
    return Intl.message(
      'Added successfully',
      name: 'added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Select a category`
  String get select_category {
    return Intl.message(
      'Select a category',
      name: 'select_category',
      desc: '',
      args: [],
    );
  }

  /// `Add New Category`
  String get add_new_category {
    return Intl.message(
      'Add New Category',
      name: 'add_new_category',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get category_name {
    return Intl.message(
      'Category Name',
      name: 'category_name',
      desc: '',
      args: [],
    );
  }

  /// `Select an option`
  String get select_option {
    return Intl.message(
      'Select an option',
      name: 'select_option',
      desc: '',
      args: [],
    );
  }

  /// `Expense Details`
  String get expense_details {
    return Intl.message(
      'Expense Details',
      name: 'expense_details',
      desc: '',
      args: [],
    );
  }

  /// `Name: {name}`
  String expense_name_label(String name) {
    return Intl.message(
      'Name: $name',
      name: 'expense_name_label',
      desc: 'Label for expense name with placeholder',
      args: [name],
    );
  }

  /// `Description: {description}`
  String expense_description_label(String description) {
    return Intl.message(
      'Description: $description',
      name: 'expense_description_label',
      desc: 'Label for expense description with placeholder',
      args: [description],
    );
  }

  /// `Amount: {amount} {currency}`
  String expense_amount_label(String amount, Object currency) {
    return Intl.message(
      'Amount: $amount $currency',
      name: 'expense_amount_label',
      desc: 'Label for expense amount with placeholder',
      args: [amount, currency],
    );
  }

  /// `Category: {category}`
  String expense_category_label(String category) {
    return Intl.message(
      'Category: $category',
      name: 'expense_category_label',
      desc: 'Label for expense category with placeholder',
      args: [category],
    );
  }

  /// `Expenses`
  String get expenses_title {
    return Intl.message('Expenses', name: 'expenses_title', desc: '', args: []);
  }

  /// `Confirm Deletion`
  String get confirm_deletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirm_deletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this expense?`
  String get confirm_delete_expense {
    return Intl.message(
      'Are you sure you want to delete this expense?',
      name: 'confirm_delete_expense',
      desc: '',
      args: [],
    );
  }

  /// `"{name}" deleted successfully`
  String deleted_successfully(String name) {
    return Intl.message(
      '"$name" deleted successfully',
      name: 'deleted_successfully',
      desc: 'Message shown after an expense is deleted',
      args: [name],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Expenses`
  String get tab_expenses {
    return Intl.message('Expenses', name: 'tab_expenses', desc: '', args: []);
  }

  /// `Stats`
  String get tab_stats {
    return Intl.message('Stats', name: 'tab_stats', desc: '', args: []);
  }

  /// `This field is required`
  String get required_field {
    return Intl.message(
      'This field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get valid_email {
    return Intl.message(
      'Enter a valid email address',
      name: 'valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Must be greater than 0`
  String get positive_number {
    return Intl.message(
      'Must be greater than 0',
      name: 'positive_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number`
  String get valid_number {
    return Intl.message(
      'Enter a valid number',
      name: 'valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_length {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_length',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_match',
      desc: '',
      args: [],
    );
  }

  /// `Pick a color`
  String get pickColor {
    return Intl.message('Pick a color', name: 'pickColor', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bs'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
