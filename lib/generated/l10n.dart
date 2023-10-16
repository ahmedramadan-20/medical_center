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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Wishing you health and happiness ❤️`
  String get subtitle {
    return Intl.message(
      'Wishing you health and happiness ❤️',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Specialized Clinics`
  String get Sign_in_title {
    return Intl.message(
      'Specialized Clinics',
      name: 'Sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get Forgot_Password {
    return Intl.message(
      'Forgot Password?',
      name: 'Forgot_Password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get Reset_Password {
    return Intl.message(
      'Reset Password',
      name: 'Reset_Password',
      desc: '',
      args: [],
    );
  }

  /// `Have an Account?`
  String get Have_an_Account {
    return Intl.message(
      'Have an Account?',
      name: 'Have_an_Account',
      desc: '',
      args: [],
    );
  }

  /// `Do you agree to our `
  String get do_you_agree {
    return Intl.message(
      'Do you agree to our ',
      name: 'do_you_agree',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get Terms_and_Conditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'Terms_and_Conditions',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcome_back {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Password Link`
  String get send_reset_password_link {
    return Intl.message(
      'Send Reset Password Link',
      name: 'send_reset_password_link',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Below To Get Reset Password Link`
  String get enter_your_email {
    return Intl.message(
      'Enter Your Email Below To Get Reset Password Link',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your account!`
  String get verify {
    return Intl.message(
      'Please verify your account!',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Check your email to reset your password`
  String get check_your_email {
    return Intl.message(
      'Check your email to reset your password',
      name: 'check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Success, Check your email to verify your account`
  String get success {
    return Intl.message(
      'Success, Check your email to verify your account',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Book your appointments`
  String get book_your_appointment {
    return Intl.message(
      'Book your appointments',
      name: 'book_your_appointment',
      desc: '',
      args: [],
    );
  }

  /// `In our medical center, you can see your favorite doctor.`
  String get in_our_medical_center {
    return Intl.message(
      'In our medical center, you can see your favorite doctor.',
      name: 'in_our_medical_center',
      desc: '',
      args: [],
    );
  }

  /// `Explore a wide range`
  String get explore {
    return Intl.message(
      'Explore a wide range',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Of medical specialties for your healthcare needs.`
  String get of_medical_specialists {
    return Intl.message(
      'Of medical specialties for your healthcare needs.',
      name: 'of_medical_specialists',
      desc: '',
      args: [],
    );
  }

  /// `Discover doctor availability`
  String get discover_doctor_availability {
    return Intl.message(
      'Discover doctor availability',
      name: 'discover_doctor_availability',
      desc: '',
      args: [],
    );
  }

  /// `On specific days for easy planning of your visit.`
  String get on_specific_days {
    return Intl.message(
      'On specific days for easy planning of your visit.',
      name: 'on_specific_days',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
