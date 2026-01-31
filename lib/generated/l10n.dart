// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_center/generated/intl/messages_all.dart';

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

  static S? maybeOf(BuildContext context) => Localizations.of<S>(context, S);

  /// `Hello, `
  String get hello => Intl.message('Hello, ', name: 'hello', desc: '', args: []);

  /// `Wishing you health and happiness ❤️`
  String get subtitle => Intl.message(
      'Wishing you health and happiness ❤️',
      name: 'subtitle',
      desc: '',
      args: [],
    );

  /// `Specialized Clinics`
  String get Sign_in_title => Intl.message(
      'Specialized Clinics',
      name: 'Sign_in_title',
      desc: '',
      args: [],
    );

  /// `Forgot Password?`
  String get Forgot_Password => Intl.message(
      'Forgot Password?',
      name: 'Forgot_Password',
      desc: '',
      args: [],
    );

  /// `Reset Password`
  String get Reset_Password => Intl.message(
      'Reset Password',
      name: 'Reset_Password',
      desc: '',
      args: [],
    );

  /// `Have an Account?`
  String get Have_an_Account => Intl.message(
      'Have an Account?',
      name: 'Have_an_Account',
      desc: '',
      args: [],
    );

  /// `Do you agree to our `
  String get do_you_agree => Intl.message(
      'Do you agree to our ',
      name: 'do_you_agree',
      desc: '',
      args: [],
    );

  /// `Terms and Conditions`
  String get Terms_and_Conditions => Intl.message(
      'Terms and Conditions',
      name: 'Terms_and_Conditions',
      desc: '',
      args: [],
    );

  /// `Welcome Back!`
  String get welcome_back => Intl.message(
      'Welcome Back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );

  /// `Welcome`
  String get welcome => Intl.message('Welcome', name: 'welcome', desc: '', args: []);

  /// `Sign Out`
  String get sign_out => Intl.message('Sign Out', name: 'sign_out', desc: '', args: []);

  /// `Create Account`
  String get create_account => Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );

  /// `Email Address`
  String get email_address => Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );

  /// `Password`
  String get password => Intl.message('Password', name: 'password', desc: '', args: []);

  /// `Sign In`
  String get sign_in => Intl.message('Sign In', name: 'sign_in', desc: '', args: []);

  /// `Sign Up`
  String get sign_up => Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);

  /// `Send Reset Password Link`
  String get send_reset_password_link => Intl.message(
      'Send Reset Password Link',
      name: 'send_reset_password_link',
      desc: '',
      args: [],
    );

  /// `Enter Your Email Below To Get Reset Password Link`
  String get enter_your_email => Intl.message(
      'Enter Your Email Below To Get Reset Password Link',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );

  /// `Skip`
  String get skip => Intl.message('Skip', name: 'skip', desc: '', args: []);

  /// `Please verify your account!`
  String get verify => Intl.message(
      'Please verify your account!',
      name: 'verify',
      desc: '',
      args: [],
    );

  /// `Don't have an account?`
  String get dont_have_an_account => Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );

  /// `First Name`
  String get first_name => Intl.message('First Name', name: 'first_name', desc: '', args: []);

  /// `Last Name`
  String get last_name => Intl.message('Last Name', name: 'last_name', desc: '', args: []);

  /// `Check your email to reset your password`
  String get check_your_email => Intl.message(
      'Check your email to reset your password',
      name: 'check_your_email',
      desc: '',
      args: [],
    );

  /// `Success, Check your email to verify your account`
  String get success => Intl.message(
      'Success, Check your email to verify your account',
      name: 'success',
      desc: '',
      args: [],
    );

  /// `Book your appointments`
  String get book_your_appointment => Intl.message(
      'Book your appointments',
      name: 'book_your_appointment',
      desc: '',
      args: [],
    );

  /// `In our medical center, you can see your favorite doctor.`
  String get in_our_medical_center => Intl.message(
      'In our medical center, you can see your favorite doctor.',
      name: 'in_our_medical_center',
      desc: '',
      args: [],
    );

  /// `Explore a wide range`
  String get explore => Intl.message(
      'Explore a wide range',
      name: 'explore',
      desc: '',
      args: [],
    );

  /// `Of medical specialties for your healthcare needs.`
  String get of_medical_specialists => Intl.message(
      'Of medical specialties for your healthcare needs.',
      name: 'of_medical_specialists',
      desc: '',
      args: [],
    );

  /// `Discover doctor availability`
  String get discover_doctor_availability => Intl.message(
      'Discover doctor availability',
      name: 'discover_doctor_availability',
      desc: '',
      args: [],
    );

  /// `On specific days for easy planning of your visit.`
  String get on_specific_days => Intl.message(
      'On specific days for easy planning of your visit.',
      name: 'on_specific_days',
      desc: '',
      args: [],
    );

  /// `Next`
  String get next => Intl.message('Next', name: 'next', desc: '', args: []);

  /// `Today`
  String get today => Intl.message('Today', name: 'today', desc: '', args: []);

  /// `Dr. `
  String get dr => Intl.message('Dr. ', name: 'dr', desc: '', args: []);

  /// `Hani Abdel Momen`
  String get hany => Intl.message('Hani Abdel Momen', name: 'hany', desc: '', args: []);

  /// `General Surgery`
  String get general_surgery => Intl.message(
      'General Surgery',
      name: 'general_surgery',
      desc: '',
      args: [],
    );

  /// `Pediatrics`
  String get pediatrics => Intl.message('Pediatrics', name: 'pediatrics', desc: '', args: []);

  /// `Ear, Nose, and Throat (ENT)`
  String get ent => Intl.message(
      'Ear, Nose, and Throat (ENT)',
      name: 'ent',
      desc: '',
      args: [],
    );

  /// `Dentistry`
  String get dentistry => Intl.message('Dentistry', name: 'dentistry', desc: '', args: []);

  /// `Dermatology`
  String get dermatology => Intl.message('Dermatology', name: 'dermatology', desc: '', args: []);

  /// `Obstetrics and Gynecology`
  String get obgyn => Intl.message(
      'Obstetrics and Gynecology',
      name: 'obgyn',
      desc: '',
      args: [],
    );

  /// `Internal Medicine`
  String get internal_medicine => Intl.message(
      'Internal Medicine',
      name: 'internal_medicine',
      desc: '',
      args: [],
    );

  /// `Nutritional Therapy`
  String get nutrition_therapy => Intl.message(
      'Nutritional Therapy',
      name: 'nutrition_therapy',
      desc: '',
      args: [],
    );

  /// `Rheumatology and Joint`
  String get rheumatology_joint => Intl.message(
      'Rheumatology and Joint',
      name: 'rheumatology_joint',
      desc: '',
      args: [],
    );

  /// `Ophthalmology`
  String get ophthalmology => Intl.message(
      'Ophthalmology',
      name: 'ophthalmology',
      desc: '',
      args: [],
    );

  /// `Cardiology`
  String get cardiology => Intl.message('Cardiology', name: 'cardiology', desc: '', args: []);

  /// `Nephrology and Urology`
  String get nephrology_urology => Intl.message(
      'Nephrology and Urology',
      name: 'nephrology_urology',
      desc: '',
      args: [],
    );

  /// `Speech and Behavior Modification`
  String get speech_behavior_modification => Intl.message(
      'Speech and Behavior Modification',
      name: 'speech_behavior_modification',
      desc: '',
      args: [],
    );

  /// `Neurology`
  String get neurology => Intl.message('Neurology', name: 'neurology', desc: '', args: []);

  /// `Specialties`
  String get specialties => Intl.message('Specialties', name: 'specialties', desc: '', args: []);

  /// `All`
  String get all => Intl.message('All', name: 'all', desc: '', args: []);

  /// `Working Days`
  String get workingDays => Intl.message(
      'Working Days',
      name: 'workingDays',
      desc: '',
      args: [],
    );

  /// `Specialty`
  String get specialty => Intl.message('Specialty', name: 'specialty', desc: '', args: []);

  /// `Verified`
  String get verified => Intl.message('Verified', name: 'verified', desc: '', args: []);

  /// `Available`
  String get available => Intl.message('Available', name: 'available', desc: '', args: []);

  /// `Profile`
  String get profile => Intl.message('Profile', name: 'profile', desc: '', args: []);

  /// `Account`
  String get account => Intl.message('Account', name: 'account', desc: '', args: []);

  /// `Edit Profile`
  String get edit_profile => Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );

  /// `Address`
  String get address => Intl.message('Address', name: 'address', desc: '', args: []);

  /// `Mit Azzoun next to the Grand Mosque.`
  String get mit_azzoun => Intl.message(
      'Mit Azzoun next to the Grand Mosque.',
      name: 'mit_azzoun',
      desc: '',
      args: [],
    );

  /// `The Meezanieh Street, next to Dr. Abdullah Saleh's pharmacy.`
  String get street => Intl.message(
      'The Meezanieh Street, next to Dr. Abdullah Saleh\'s pharmacy.',
      name: 'street',
      desc: '',
      args: [],
    );

  /// `Clinics`
  String get clinics => Intl.message('Clinics', name: 'clinics', desc: '', args: []);

  /// `Joint Clinic`
  String get joint => Intl.message('Joint Clinic', name: 'joint', desc: '', args: []);

  /// `Language`
  String get language => Intl.message('Language', name: 'language', desc: '', args: []);

  /// `Booking...`
  String get booking => Intl.message('Booking...', name: 'booking', desc: '', args: []);

  /// `Phone`
  String get phone => Intl.message('Phone', name: 'phone', desc: '', args: []);

  /// `Landline`
  String get landline => Intl.message('Landline', name: 'landline', desc: '', args: []);

  /// `General`
  String get general => Intl.message('General', name: 'general', desc: '', args: []);

  /// `Monday`
  String get monday => Intl.message('Monday', name: 'monday', desc: '', args: []);

  /// `Tuesday`
  String get tuesday => Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);

  /// `Wednesday`
  String get wednesday => Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);

  /// `Thursday`
  String get thursday => Intl.message('Thursday', name: 'thursday', desc: '', args: []);

  /// `Friday`
  String get friday => Intl.message('Friday', name: 'friday', desc: '', args: []);

  /// `Saturday`
  String get saturday => Intl.message('Saturday', name: 'saturday', desc: '', args: []);

  /// `Sunday`
  String get sunday => Intl.message('Sunday', name: 'sunday', desc: '', args: []);

  /// `This field is required.`
  String get required => Intl.message(
      'This field is required.',
      name: 'required',
      desc: '',
      args: [],
    );

  /// `Phone number`
  String get phone_number => Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );

  /// `Gender`
  String get gender => Intl.message('Gender', name: 'gender', desc: '', args: []);

  /// `Male`
  String get male => Intl.message('Male', name: 'male', desc: '', args: []);

  /// `Female`
  String get female => Intl.message('Female', name: 'female', desc: '', args: []);

  /// `Blood type`
  String get blood_type => Intl.message('Blood type', name: 'blood_type', desc: '', args: []);

  /// `No user found for that email.`
  String get no_user_found => Intl.message(
      'No user found for that email.',
      name: 'no_user_found',
      desc: '',
      args: [],
    );

  /// `Wrong password provided for that user.`
  String get wrong_password => Intl.message(
      'Wrong password provided for that user.',
      name: 'wrong_password',
      desc: '',
      args: [],
    );

  /// `Check your Email and Password.`
  String get check_your_email_and_password => Intl.message(
      'Check your Email and Password.',
      name: 'check_your_email_and_password',
      desc: '',
      args: [],
    );

  /// `The password provided is too weak.`
  String get weak_password => Intl.message(
      'The password provided is too weak.',
      name: 'weak_password',
      desc: '',
      args: [],
    );

  /// `The account already exists for that email.`
  String get account_already_exists => Intl.message(
      'The account already exists for that email.',
      name: 'account_already_exists',
      desc: '',
      args: [],
    );

  /// `The email is invalid.`
  String get invalid_email => Intl.message(
      'The email is invalid.',
      name: 'invalid_email',
      desc: '',
      args: [],
    );

  /// `Blood Types`
  String get blood_types => Intl.message('Blood Types', name: 'blood_types', desc: '', args: []);

  /// `All`
  String get all_blood_types => Intl.message('All', name: 'all_blood_types', desc: '', args: []);

  /// `No blood types found 😥`
  String get no_blood_types_found => Intl.message(
      'No blood types found 😥',
      name: 'no_blood_types_found',
      desc: '',
      args: [],
    );

  /// `Experience`
  String get experience => Intl.message('Experience', name: 'experience', desc: '', args: []);

  /// `Rating`
  String get rating => Intl.message('Rating', name: 'rating', desc: '', args: []);

  /// `reviews`
  String get reviews => Intl.message('reviews', name: 'reviews', desc: '', args: []);

  /// `Patient Reviews`
  String get patientReviews => Intl.message(
      'Patient Reviews',
      name: 'patientReviews',
      desc: '',
      args: [],
    );

  /// `Specialist Practitioner`
  String get specialistPractitioner => Intl.message(
      'Specialist Practitioner',
      name: 'specialistPractitioner',
      desc: '',
      args: [],
    );

  /// `Total Charges`
  String get totalCharges => Intl.message(
      'Total Charges',
      name: 'totalCharges',
      desc: '',
      args: [],
    );

  /// `Book Now`
  String get bookNow => Intl.message('Book Now', name: 'bookNow', desc: '', args: []);

  /// `Not Working`
  String get notWorking => Intl.message('Not Working', name: 'notWorking', desc: '', args: []);

  /// `Yrs`
  String get years => Intl.message('Yrs', name: 'years', desc: '', args: []);

  /// `No reviews yet. Be the first to share your experience!`
  String get noReviewsYet => Intl.message(
      'No reviews yet. Be the first to share your experience!',
      name: 'noReviewsYet',
      desc: '',
      args: [],
    );

  /// `Our Doctors`
  String get ourDoctors => Intl.message('Our Doctors', name: 'ourDoctors', desc: '', args: []);

  /// `No Doctors Found`
  String get noDoctorsFound => Intl.message(
      'No Doctors Found',
      name: 'noDoctorsFound',
      desc: '',
      args: [],
    );

  /// `No doctors are currently available in this category.`
  String get noDoctorsInCategory => Intl.message(
      'No doctors are currently available in this category.',
      name: 'noDoctorsInCategory',
      desc: '',
      args: [],
    );

  /// `Home`
  String get home => Intl.message('Home', name: 'home', desc: '', args: []);

  /// `Appointments`
  String get appointments => Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );

  /// `Choose your blood type`
  String get choose_blood_type => Intl.message(
      'Choose your blood type',
      name: 'choose_blood_type',
      desc: '',
      args: [],
    );

  /// `A+`
  String get blood_type_A_positive => Intl.message(
      'A+',
      name: 'blood_type_A_positive',
      desc: '',
      args: [],
    );

  /// `A-`
  String get blood_type_A_negative => Intl.message(
      'A-',
      name: 'blood_type_A_negative',
      desc: '',
      args: [],
    );

  /// `B+`
  String get blood_type_B_positive => Intl.message(
      'B+',
      name: 'blood_type_B_positive',
      desc: '',
      args: [],
    );

  /// `B-`
  String get blood_type_B_negative => Intl.message(
      'B-',
      name: 'blood_type_B_negative',
      desc: '',
      args: [],
    );

  /// `AB+`
  String get blood_type_AB_positive => Intl.message(
      'AB+',
      name: 'blood_type_AB_positive',
      desc: '',
      args: [],
    );

  /// `AB-`
  String get blood_type_AB_negative => Intl.message(
      'AB-',
      name: 'blood_type_AB_negative',
      desc: '',
      args: [],
    );

  /// `O+`
  String get blood_type_O_positive => Intl.message(
      'O+',
      name: 'blood_type_O_positive',
      desc: '',
      args: [],
    );

  /// `O-`
  String get blood_type_O_negative => Intl.message(
      'O-',
      name: 'blood_type_O_negative',
      desc: '',
      args: [],
    );

  /// `Unknown`
  String get blood_type_unknown => Intl.message(
      'Unknown',
      name: 'blood_type_unknown',
      desc: '',
      args: [],
    );

  /// `Admin Dashboard`
  String get admin_dashboard => Intl.message(
      'Admin Dashboard',
      name: 'admin_dashboard',
      desc: '',
      args: [],
    );

  /// `An error occurred. Please try again later.`
  String get error_occurred => Intl.message(
      'An error occurred. Please try again later.',
      name: 'error_occurred',
      desc: '',
      args: [],
    );

  /// `No Appointments`
  String get no_appointments => Intl.message(
      'No Appointments',
      name: 'no_appointments',
      desc: '',
      args: [],
    );

  /// `You haven't booked any appointments yet.`
  String get no_appointments_subtitle => Intl.message(
      'You haven\'t booked any appointments yet.',
      name: 'no_appointments_subtitle',
      desc: '',
      args: [],
    );

  /// `My Appointments`
  String get my_appointments => Intl.message(
      'My Appointments',
      name: 'my_appointments',
      desc: '',
      args: [],
    );

  /// `Cancel Appointment`
  String get cancel_appointment => Intl.message(
      'Cancel Appointment',
      name: 'cancel_appointment',
      desc: '',
      args: [],
    );

  /// `Are you sure you want to cancel this appointment? This action cannot be undone.`
  String get cancel_appointment_confirmation => Intl.message(
      'Are you sure you want to cancel this appointment? This action cannot be undone.',
      name: 'cancel_appointment_confirmation',
      desc: '',
      args: [],
    );

  /// `No, keep it`
  String get no_keep_it => Intl.message('No, keep it', name: 'no_keep_it', desc: '', args: []);

  /// `Yes, cancel`
  String get yes_cancel => Intl.message('Yes, cancel', name: 'yes_cancel', desc: '', args: []);

  /// `Rate your experience`
  String get rate_your_experience => Intl.message(
      'Rate your experience',
      name: 'rate_your_experience',
      desc: '',
      args: [],
    );

  /// `How was your visit with Dr. {doctorName}?`
  String how_was_your_visit(Object doctorName) => Intl.message(
      'How was your visit with Dr. $doctorName?',
      name: 'how_was_your_visit',
      desc: '',
      args: [doctorName],
    );

  /// `Share your thoughts...`
  String get share_your_thoughts => Intl.message(
      'Share your thoughts...',
      name: 'share_your_thoughts',
      desc: '',
      args: [],
    );

  /// `Cancel`
  String get cancel => Intl.message('Cancel', name: 'cancel', desc: '', args: []);

  /// `Submit Review`
  String get submit_review => Intl.message(
      'Submit Review',
      name: 'submit_review',
      desc: '',
      args: [],
    );

  /// `Patient: {patientName}`
  String patient(Object patientName) => Intl.message(
      'Patient: $patientName',
      name: 'patient',
      desc: '',
      args: [patientName],
    );

  /// `Date: {date} at {time}`
  String date_at_time(String date, String time) => Intl.message(
      'Date: $date at $time',
      name: 'date_at_time',
      desc: '',
      args: [date, time],
    );

  /// `Cancel Appointment`
  String get cancel_appointment_button => Intl.message(
      'Cancel Appointment',
      name: 'cancel_appointment_button',
      desc: '',
      args: [],
    );

  /// `Rate & Review`
  String get rate_and_review => Intl.message(
      'Rate & Review',
      name: 'rate_and_review',
      desc: '',
      args: [],
    );

  /// `Booked on: {date}`
  String booked_on(Object date) => Intl.message(
      'Booked on: $date',
      name: 'booked_on',
      desc: '',
      args: [date],
    );

  /// `Appointment booked successfully!`
  String get appointment_booked_successfully => Intl.message(
      'Appointment booked successfully!',
      name: 'appointment_booked_successfully',
      desc: '',
      args: [],
    );

  /// `No users found`
  String get no_users_found => Intl.message(
      'No users found',
      name: 'no_users_found',
      desc: '',
      args: [],
    );

  /// `There are no users registered in the system yet.`
  String get no_users_registered => Intl.message(
      'There are no users registered in the system yet.',
      name: 'no_users_registered',
      desc: '',
      args: [],
    );

  /// `No Specialties`
  String get no_specialties => Intl.message(
      'No Specialties',
      name: 'no_specialties',
      desc: '',
      args: [],
    );

  /// `You haven't added any clinical specialties yet.`
  String get no_specialties_added => Intl.message(
      'You haven\'t added any clinical specialties yet.',
      name: 'no_specialties_added',
      desc: '',
      args: [],
    );

  /// `No Reviews`
  String get no_reviews => Intl.message('No Reviews', name: 'no_reviews', desc: '', args: []);

  /// `There are no patient reviews to display yet.`
  String get no_reviews_to_display => Intl.message(
      'There are no patient reviews to display yet.',
      name: 'no_reviews_to_display',
      desc: '',
      args: [],
    );

  /// `No doctors found`
  String get no_doctors_found => Intl.message(
      'No doctors found',
      name: 'no_doctors_found',
      desc: '',
      args: [],
    );

  /// `There are no doctors registered in the system.`
  String get no_doctors_registered => Intl.message(
      'There are no doctors registered in the system.',
      name: 'no_doctors_registered',
      desc: '',
      args: [],
    );

  /// `Add Doctor`
  String get add_doctor => Intl.message('Add Doctor', name: 'add_doctor', desc: '', args: []);

  /// `Manage Doctors`
  String get manage_doctors => Intl.message(
      'Manage Doctors',
      name: 'manage_doctors',
      desc: '',
      args: [],
    );

  /// `Delete Doctor`
  String get delete_doctor => Intl.message(
      'Delete Doctor',
      name: 'delete_doctor',
      desc: '',
      args: [],
    );

  /// `Are you sure you want to delete {doctorName}?`
  String delete_doctor_confirmation(Object doctorName) => Intl.message(
      'Are you sure you want to delete $doctorName?',
      name: 'delete_doctor_confirmation',
      desc: '',
      args: [doctorName],
    );

  /// `Delete`
  String get delete => Intl.message('Delete', name: 'delete', desc: '', args: []);

  /// `No Blood Records`
  String get no_blood_records => Intl.message(
      'No Blood Records',
      name: 'no_blood_records',
      desc: '',
      args: [],
    );

  /// `There are no blood donation records registered yet.`
  String get no_blood_records_registered => Intl.message(
      'There are no blood donation records registered yet.',
      name: 'no_blood_records_registered',
      desc: '',
      args: [],
    );

  /// `No appointments found`
  String get no_appointments_found => Intl.message(
      'No appointments found',
      name: 'no_appointments_found',
      desc: '',
      args: [],
    );

  /// `There are no appointments matching the selected filter.`
  String get no_appointments_matching_filter => Intl.message(
      'There are no appointments matching the selected filter.',
      name: 'no_appointments_matching_filter',
      desc: '',
      args: [],
    );

  /// `Confirmed`
  String get confirmed => Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);

  /// `Pending`
  String get pending => Intl.message('Pending', name: 'pending', desc: '', args: []);

  /// `Completed`
  String get completed => Intl.message('Completed', name: 'completed', desc: '', args: []);

  /// `Cancelled`
  String get cancelled => Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);

  /// `Appointments`
  String get manage_appointments => Intl.message(
      'Appointments',
      name: 'manage_appointments',
      desc: '',
      args: [],
    );

  /// `with Dr. {doctorName} ({doctorSpecialty})`
  String with_dr_specialty(Object doctorName, Object doctorSpecialty) => Intl.message(
      'with Dr. $doctorName ($doctorSpecialty)',
      name: 'with_dr_specialty',
      desc: '',
      args: [doctorName, doctorSpecialty],
    );

  /// `Reserved on: {date}`
  String reserved_on(Object date) => Intl.message(
      'Reserved on: $date',
      name: 'reserved_on',
      desc: '',
      args: [date],
    );

  /// `Confirm`
  String get confirm => Intl.message('Confirm', name: 'confirm', desc: '', args: []);

  /// `Complete`
  String get complete => Intl.message('Complete', name: 'complete', desc: '', args: []);

  /// `Loading Specialities...`
  String get loading_specialities => Intl.message(
      'Loading Specialities...',
      name: 'loading_specialities',
      desc: '',
      args: [],
    );

  /// `Add New Doctor`
  String get add_new_doctor => Intl.message(
      'Add New Doctor',
      name: 'add_new_doctor',
      desc: '',
      args: [],
    );

  /// `Edit Doctor Profile`
  String get edit_doctor_profile => Intl.message(
      'Edit Doctor Profile',
      name: 'edit_doctor_profile',
      desc: '',
      args: [],
    );

  /// `Save`
  String get save => Intl.message('Save', name: 'save', desc: '', args: []);

  /// `Basic Information`
  String get basic_information => Intl.message(
      'Basic Information',
      name: 'basic_information',
      desc: '',
      args: [],
    );

  /// `Specialization`
  String get specialization => Intl.message(
      'Specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );

  /// `Working Hours`
  String get working_hours => Intl.message(
      'Working Hours',
      name: 'working_hours',
      desc: '',
      args: [],
    );

  /// `Doctor Name (EN)`
  String get doctor_name_en => Intl.message(
      'Doctor Name (EN)',
      name: 'doctor_name_en',
      desc: '',
      args: [],
    );

  /// `Doctor Name (AR)`
  String get doctor_name_ar => Intl.message(
      'Doctor Name (AR)',
      name: 'doctor_name_ar',
      desc: '',
      args: [],
    );

  /// `Profile Image URL`
  String get profile_image_url => Intl.message(
      'Profile Image URL',
      name: 'profile_image_url',
      desc: '',
      args: [],
    );

  /// `Field is required`
  String get field_is_required => Intl.message(
      'Field is required',
      name: 'field_is_required',
      desc: '',
      args: [],
    );

  /// `Add Shift`
  String get add_shift => Intl.message('Add Shift', name: 'add_shift', desc: '', args: []);

  /// `No schedules added yet`
  String get no_schedules_added_yet => Intl.message(
      'No schedules added yet',
      name: 'no_schedules_added_yet',
      desc: '',
      args: [],
    );

  /// `Add Schedule`
  String get add_schedule => Intl.message(
      'Add Schedule',
      name: 'add_schedule',
      desc: '',
      args: [],
    );

  /// `Start Time`
  String get start_time => Intl.message('Start Time', name: 'start_time', desc: '', args: []);

  /// `End Time`
  String get end_time => Intl.message('End Time', name: 'end_time', desc: '', args: []);

  /// `Add`
  String get add => Intl.message('Add', name: 'add', desc: '', args: []);

  /// `Role updated successfully`
  String get role_updated_successfully => Intl.message(
      'Role updated successfully',
      name: 'role_updated_successfully',
      desc: '',
      args: [],
    );

  /// `User not found`
  String get user_not_found => Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );

  /// `User deleted successfully`
  String get user_deleted_successfully => Intl.message(
      'User deleted successfully',
      name: 'user_deleted_successfully',
      desc: '',
      args: [],
    );

  /// `Speciality added successfully`
  String get speciality_added_successfully => Intl.message(
      'Speciality added successfully',
      name: 'speciality_added_successfully',
      desc: '',
      args: [],
    );

  /// `Speciality deleted successfully`
  String get speciality_deleted_successfully => Intl.message(
      'Speciality deleted successfully',
      name: 'speciality_deleted_successfully',
      desc: '',
      args: [],
    );

  /// `Doctor added successfully`
  String get doctor_added_successfully => Intl.message(
      'Doctor added successfully',
      name: 'doctor_added_successfully',
      desc: '',
      args: [],
    );

  /// `Doctor updated successfully`
  String get doctor_updated_successfully => Intl.message(
      'Doctor updated successfully',
      name: 'doctor_updated_successfully',
      desc: '',
      args: [],
    );

  /// `Doctor deleted successfully`
  String get doctor_deleted_successfully => Intl.message(
      'Doctor deleted successfully',
      name: 'doctor_deleted_successfully',
      desc: '',
      args: [],
    );

  /// `Status updated to {newStatus}`
  String status_updated_to(Object newStatus) => Intl.message(
      'Status updated to $newStatus',
      name: 'status_updated_to',
      desc: '',
      args: [newStatus],
    );

  /// `Appointment deleted successfully`
  String get appointment_deleted_successfully => Intl.message(
      'Appointment deleted successfully',
      name: 'appointment_deleted_successfully',
      desc: '',
      args: [],
    );

  /// `Error During Communication`
  String get error_during_communication => Intl.message(
      'Error During Communication',
      name: 'error_during_communication',
      desc: '',
      args: [],
    );

  /// `Bad Request`
  String get bad_request => Intl.message('Bad Request', name: 'bad_request', desc: '', args: []);

  /// `Unauthorized`
  String get unauthorized => Intl.message(
      'Unauthorized',
      name: 'unauthorized',
      desc: '',
      args: [],
    );

  /// `Requested Info Not Found`
  String get requested_info_not_found => Intl.message(
      'Requested Info Not Found',
      name: 'requested_info_not_found',
      desc: '',
      args: [],
    );

  /// `Conflict Occurred`
  String get conflict_occurred => Intl.message(
      'Conflict Occurred',
      name: 'conflict_occurred',
      desc: '',
      args: [],
    );

  /// `Internal Server Error`
  String get internal_server_error => Intl.message(
      'Internal Server Error',
      name: 'internal_server_error',
      desc: '',
      args: [],
    );

  /// `No Internet Connection`
  String get no_internet_connection => Intl.message(
      'No Internet Connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );

  /// `Overview`
  String get overview => Intl.message('Overview', name: 'overview', desc: '', args: []);

  /// `Quick Actions`
  String get quick_actions => Intl.message(
      'Quick Actions',
      name: 'quick_actions',
      desc: '',
      args: [],
    );

  /// `System Status`
  String get system_status => Intl.message(
      'System Status',
      name: 'system_status',
      desc: '',
      args: [],
    );

  /// `Total Users`
  String get total_users => Intl.message('Total Users', name: 'total_users', desc: '', args: []);

  /// `Blood Records`
  String get blood_records => Intl.message(
      'Blood Records',
      name: 'blood_records',
      desc: '',
      args: [],
    );

  /// `Patient Reviews`
  String get patient_reviews => Intl.message(
      'Patient Reviews',
      name: 'patient_reviews',
      desc: '',
      args: [],
    );

  /// `Doctors`
  String get doctors => Intl.message('Doctors', name: 'doctors', desc: '', args: []);

  /// `Users`
  String get users => Intl.message('Users', name: 'users', desc: '', args: []);

  /// `Blood`
  String get blood => Intl.message('Blood', name: 'blood', desc: '', args: []);

  /// `specialities`
  String get specialities => Intl.message(
      'specialities',
      name: 'specialities',
      desc: '',
      args: [],
    );

  /// `Review submitted successfully!`
  String get review_submitted_successfully => Intl.message(
      'Review submitted successfully!',
      name: 'review_submitted_successfully',
      desc: '',
      args: [],
    );

  /// `Manage Users`
  String get manage_users => Intl.message(
      'Manage Users',
      name: 'manage_users',
      desc: '',
      args: [],
    );

  /// `Delete User`
  String get delete_user => Intl.message('Delete User', name: 'delete_user', desc: '', args: []);

  /// `Are you sure you want to permanently delete {userName}? This action cannot be undone.`
  String delete_user_confirmation(Object userName) => Intl.message(
      'Are you sure you want to permanently delete $userName? This action cannot be undone.',
      name: 'delete_user_confirmation',
      desc: '',
      args: [userName],
    );

  /// `Specialities`
  String get manage_specialities => Intl.message(
      'Specialities',
      name: 'manage_specialities',
      desc: '',
      args: [],
    );

  /// `Add Speciality`
  String get add_speciality => Intl.message(
      'Add Speciality',
      name: 'add_speciality',
      desc: '',
      args: [],
    );

  /// `Reviews`
  String get manage_reviews => Intl.message('Reviews', name: 'manage_reviews', desc: '', args: []);

  /// `Blood Donation Records`
  String get blood_donation_records => Intl.message(
      'Blood Donation Records',
      name: 'blood_donation_records',
      desc: '',
      args: [],
    );

  /// `Book Appointment`
  String get book_appointment => Intl.message(
      'Book Appointment',
      name: 'book_appointment',
      desc: '',
      args: [],
    );

  /// `Server Status`
  String get server_status => Intl.message(
      'Server Status',
      name: 'server_status',
      desc: '',
      args: [],
    );

  /// `Online`
  String get online => Intl.message('Online', name: 'online', desc: '', args: []);

  /// `Last Update`
  String get last_update => Intl.message('Last Update', name: 'last_update', desc: '', args: []);

  /// `Just now`
  String get just_now => Intl.message('Just now', name: 'just_now', desc: '', args: []);

  /// `Active Users`
  String get active_users => Intl.message(
      'Active Users',
      name: 'active_users',
      desc: '',
      args: [],
    );

  /// `Personal Information`
  String get personal_information => Intl.message(
      'Personal Information',
      name: 'personal_information',
      desc: '',
      args: [],
    );

  /// `Signed out successfully`
  String get signed_out_successfully => Intl.message(
      'Signed out successfully',
      name: 'signed_out_successfully',
      desc: '',
      args: [],
    );

  /// `Analytics & Reports`
  String get analytics_reports => Intl.message(
      'Analytics & Reports',
      name: 'analytics_reports',
      desc: '',
      args: [],
    );

  /// `Appointment Status`
  String get appointment_status => Intl.message(
      'Appointment Status',
      name: 'appointment_status',
      desc: '',
      args: [],
    );

  /// `Top Doctors`
  String get top_doctors => Intl.message('Top Doctors', name: 'top_doctors', desc: '', args: []);

  /// `Total Appointments`
  String get total_appointments => Intl.message(
      'Total Appointments',
      name: 'total_appointments',
      desc: '',
      args: [],
    );

  /// `Total Doctors`
  String get total_doctors => Intl.message(
      'Total Doctors',
      name: 'total_doctors',
      desc: '',
      args: [],
    );

  /// `Average Rating`
  String get average_rating => Intl.message(
      'Average Rating',
      name: 'average_rating',
      desc: '',
      args: [],
    );

  /// `Favorites`
  String get favorites => Intl.message('Favorites', name: 'favorites', desc: '', args: []);

  /// `My Favorite Doctors`
  String get my_favorites => Intl.message(
      'My Favorite Doctors',
      name: 'my_favorites',
      desc: '',
      args: [],
    );

  /// `No Favorites Yet`
  String get no_favorites => Intl.message(
      'No Favorites Yet',
      name: 'no_favorites',
      desc: '',
      args: [],
    );

  /// `Add to Favorites`
  String get add_to_favorites => Intl.message(
      'Add to Favorites',
      name: 'add_to_favorites',
      desc: '',
      args: [],
    );

  /// `Remove from Favorites`
  String get remove_from_favorites => Intl.message(
      'Remove from Favorites',
      name: 'remove_from_favorites',
      desc: '',
      args: [],
    );

  /// `Added to favorites`
  String get favorite_added => Intl.message(
      'Added to favorites',
      name: 'favorite_added',
      desc: '',
      args: [],
    );

  /// `Removed from favorites`
  String get favorite_removed => Intl.message(
      'Removed from favorites',
      name: 'favorite_removed',
      desc: '',
      args: [],
    );

  /// `Tap the heart icon on any doctor card to add them to your favorites`
  String get start_adding_favorites => Intl.message(
      'Tap the heart icon on any doctor card to add them to your favorites',
      name: 'start_adding_favorites',
      desc: '',
      args: [],
    );

  /// `Browse Doctors`
  String get browse_doctors => Intl.message(
      'Browse Doctors',
      name: 'browse_doctors',
      desc: '',
      args: [],
    );

  /// `Select Photo Source`
  String get select_photo_source => Intl.message(
      'Select Photo Source',
      name: 'select_photo_source',
      desc: '',
      args: [],
    );

  /// `Camera`
  String get camera => Intl.message('Camera', name: 'camera', desc: '', args: []);

  /// `Gallery`
  String get gallery => Intl.message('Gallery', name: 'gallery', desc: '', args: []);

  /// `Tap to change photo`
  String get tap_to_change_photo => Intl.message(
      'Tap to change photo',
      name: 'tap_to_change_photo',
      desc: '',
      args: [],
    );

  /// `Full Name`
  String get full_name => Intl.message('Full Name', name: 'full_name', desc: '', args: []);

  /// `This field is required`
  String get field_required => Intl.message(
      'This field is required',
      name: 'field_required',
      desc: '',
      args: [],
    );

  /// `Email`
  String get email => Intl.message('Email', name: 'email', desc: '', args: []);

  /// `Saving...`
  String get saving => Intl.message('Saving...', name: 'saving', desc: '', args: []);

  /// `Save Changes`
  String get save_changes => Intl.message(
      'Save Changes',
      name: 'save_changes',
      desc: '',
      args: [],
    );

  /// `Patient Information`
  String get patient_information => Intl.message(
      'Patient Information',
      name: 'patient_information',
      desc: '',
      args: [],
    );

  /// `Please enter patient name`
  String get please_enter_patient_name => Intl.message(
      'Please enter patient name',
      name: 'please_enter_patient_name',
      desc: '',
      args: [],
    );

  /// `Please enter phone number`
  String get please_enter_phone_number => Intl.message(
      'Please enter phone number',
      name: 'please_enter_phone_number',
      desc: '',
      args: [],
    );

  /// `Confirm Appointment`
  String get confirm_appointment => Intl.message(
      'Confirm Appointment',
      name: 'confirm_appointment',
      desc: '',
      args: [],
    );

  /// `Select Appointment Date`
  String get select_appointment_date => Intl.message(
      'Select Appointment Date',
      name: 'select_appointment_date',
      desc: '',
      args: [],
    );

  /// `Select Appointment Time`
  String get select_appointment_time => Intl.message(
      'Select Appointment Time',
      name: 'select_appointment_time',
      desc: '',
      args: [],
    );

  /// `Selected Date`
  String get selected_date => Intl.message(
      'Selected Date',
      name: 'selected_date',
      desc: '',
      args: [],
    );

  /// `Selected Time`
  String get selected_time => Intl.message(
      'Selected Time',
      name: 'selected_time',
      desc: '',
      args: [],
    );

  /// `Blood Records`
  String get manage_blood_records => Intl.message(
      'Blood Records',
      name: 'manage_blood_records',
      desc: '',
      args: [],
    );

  /// `Edit Doctor`
  String get edit_doctor => Intl.message('Edit Doctor', name: 'edit_doctor', desc: '', args: []);

  /// `Doctor Name`
  String get doctor_name => Intl.message('Doctor Name', name: 'doctor_name', desc: '', args: []);

  /// `Doctor added successfully`
  String get doctor_added => Intl.message(
      'Doctor added successfully',
      name: 'doctor_added',
      desc: '',
      args: [],
    );

  /// `Doctor updated successfully`
  String get doctor_updated => Intl.message(
      'Doctor updated successfully',
      name: 'doctor_updated',
      desc: '',
      args: [],
    );

  /// `Doctor deleted successfully`
  String get doctor_deleted => Intl.message(
      'Doctor deleted successfully',
      name: 'doctor_deleted',
      desc: '',
      args: [],
    );

  /// `Confirm Delete`
  String get confirm_delete => Intl.message(
      'Confirm Delete',
      name: 'confirm_delete',
      desc: '',
      args: [],
    );

  /// `Are you sure you want to delete this doctor?`
  String get delete_doctor_message => Intl.message(
      'Are you sure you want to delete this doctor?',
      name: 'delete_doctor_message',
      desc: '',
      args: [],
    );

  /// `Loading...`
  String get loading => Intl.message('Loading...', name: 'loading', desc: '', args: []);

  /// `No reviews found`
  String get no_reviews_found => Intl.message(
      'No reviews found',
      name: 'no_reviews_found',
      desc: '',
      args: [],
    );

  /// `Name must be at least 3 characters`
  String get name_must_be_3_chars => Intl.message(
      'Name must be at least 3 characters',
      name: 'name_must_be_3_chars',
      desc: '',
      args: [],
    );

  /// `Please enter a valid phone number`
  String get please_enter_valid_phone => Intl.message(
      'Please enter a valid phone number',
      name: 'please_enter_valid_phone',
      desc: '',
      args: [],
    );

  /// `Add Working Hours`
  String get add_working_hours => Intl.message(
      'Add Working Hours',
      name: 'add_working_hours',
      desc: '',
      args: [],
    );

  /// `Select Day`
  String get select_day => Intl.message('Select Day', name: 'select_day', desc: '', args: []);

  /// `Ticket Price`
  String get ticket_price => Intl.message(
      'Ticket Price',
      name: 'ticket_price',
      desc: '',
      args: [],
    );

  /// `Years of Experience`
  String get experience_years => Intl.message(
      'Years of Experience',
      name: 'experience_years',
      desc: '',
      args: [],
    );

  /// `Update`
  String get update => Intl.message('Update', name: 'update', desc: '', args: []);

  /// `English Name`
  String get english_name => Intl.message(
      'English Name',
      name: 'english_name',
      desc: '',
      args: [],
    );

  /// `Arabic Name`
  String get arabic_name => Intl.message('Arabic Name', name: 'arabic_name', desc: '', args: []);

  /// `English Bio`
  String get english_bio => Intl.message('English Bio', name: 'english_bio', desc: '', args: []);

  /// `Arabic Bio`
  String get arabic_bio => Intl.message('Arabic Bio', name: 'arabic_bio', desc: '', args: []);

  /// `Upload Image`
  String get upload_image => Intl.message(
      'Upload Image',
      name: 'upload_image',
      desc: '',
      args: [],
    );

  /// `Select Specialization`
  String get select_specialization => Intl.message(
      'Select Specialization',
      name: 'select_specialization',
      desc: '',
      args: [],
    );

  /// `Admin Dashboard`
  String get enhanced_dashboard_title => Intl.message(
      'Admin Dashboard',
      name: 'enhanced_dashboard_title',
      desc: '',
      args: [],
    );

  /// `Error loading dashboard`
  String get error_loading_dashboard => Intl.message(
      'Error loading dashboard',
      name: 'error_loading_dashboard',
      desc: '',
      args: [],
    );

  /// `Retry`
  String get retry => Intl.message('Retry', name: 'retry', desc: '', args: []);

  /// `Overview Statistics`
  String get overview_statistics => Intl.message(
      'Overview Statistics',
      name: 'overview_statistics',
      desc: '',
      args: [],
    );

  /// `admins`
  String get admins => Intl.message('admins', name: 'admins', desc: '', args: []);

  /// `today`
  String get today_appointments => Intl.message(
      'today',
      name: 'today_appointments',
      desc: '',
      args: [],
    );

  /// `Avg Rating`
  String get avg_rating => Intl.message('Avg Rating', name: 'avg_rating', desc: '', args: []);

  /// `Appointments`
  String get pending_appointments => Intl.message(
      'Appointments',
      name: 'pending_appointments',
      desc: '',
      args: [],
    );

  /// `Blood Requests`
  String get blood_requests => Intl.message(
      'Blood Requests',
      name: 'blood_requests',
      desc: '',
      args: [],
    );

  /// `Active requests`
  String get active_requests => Intl.message(
      'Active requests',
      name: 'active_requests',
      desc: '',
      args: [],
    );

  /// `Analytics`
  String get analytics => Intl.message('Analytics', name: 'analytics', desc: '', args: []);

  /// `Settings`
  String get settings => Intl.message('Settings', name: 'settings', desc: '', args: []);

  /// `Analytics`
  String get analytics_section => Intl.message(
      'Analytics',
      name: 'analytics_section',
      desc: '',
      args: [],
    );

  /// `View All`
  String get view_all => Intl.message('View All', name: 'view_all', desc: '', args: []);

  /// `Appointment Trends (Last 7 Days)`
  String get appointment_trends_last_7_days => Intl.message(
      'Appointment Trends (Last 7 Days)',
      name: 'appointment_trends_last_7_days',
      desc: '',
      args: [],
    );

  /// `Top Specialities`
  String get top_specialities => Intl.message(
      'Top Specialities',
      name: 'top_specialities',
      desc: '',
      args: [],
    );

  /// `Recent Activity`
  String get recent_activity => Intl.message(
      'Recent Activity',
      name: 'recent_activity',
      desc: '',
      args: [],
    );

  /// `items`
  String get items => Intl.message('items', name: 'items', desc: '', args: []);

  /// `No activities found`
  String get no_activities_found => Intl.message(
      'No activities found',
      name: 'no_activities_found',
      desc: '',
      args: [],
    );

  /// `Search activities...`
  String get search_activities => Intl.message(
      'Search activities...',
      name: 'search_activities',
      desc: '',
      args: [],
    );

  /// `All`
  String get filter_all => Intl.message('All', name: 'filter_all', desc: '', args: []);

  /// `Appointments`
  String get filter_appointments => Intl.message(
      'Appointments',
      name: 'filter_appointments',
      desc: '',
      args: [],
    );

  /// `Reviews`
  String get filter_reviews => Intl.message('Reviews', name: 'filter_reviews', desc: '', args: []);

  /// `Users`
  String get filter_users => Intl.message('Users', name: 'filter_users', desc: '', args: []);

  /// `Export Dashboard Data`
  String get export_dashboard_data => Intl.message(
      'Export Dashboard Data',
      name: 'export_dashboard_data',
      desc: '',
      args: [],
    );

  /// `Export Data`
  String get export_data => Intl.message('Export Data', name: 'export_data', desc: '', args: []);

  /// `Select export format:`
  String get select_export_format => Intl.message(
      'Select export format:',
      name: 'select_export_format',
      desc: '',
      args: [],
    );

  /// `CSV Format`
  String get csv_format => Intl.message('CSV Format', name: 'csv_format', desc: '', args: []);

  /// `Export as comma-separated values`
  String get export_csv_description => Intl.message(
      'Export as comma-separated values',
      name: 'export_csv_description',
      desc: '',
      args: [],
    );

  /// `JSON Format`
  String get json_format => Intl.message('JSON Format', name: 'json_format', desc: '', args: []);

  /// `Export as JSON data`
  String get export_json_description => Intl.message(
      'Export as JSON data',
      name: 'export_json_description',
      desc: '',
      args: [],
    );

  /// `Data will be copied to clipboard`
  String get data_copied_to_clipboard => Intl.message(
      'Data will be copied to clipboard',
      name: 'data_copied_to_clipboard',
      desc: '',
      args: [],
    );

  /// `CSV data copied to clipboard`
  String get csv_data_copied => Intl.message(
      'CSV data copied to clipboard',
      name: 'csv_data_copied',
      desc: '',
      args: [],
    );

  /// `JSON data copied to clipboard`
  String get json_data_copied => Intl.message(
      'JSON data copied to clipboard',
      name: 'json_data_copied',
      desc: '',
      args: [],
    );

  /// `New Appointment`
  String get new_appointment => Intl.message(
      'New Appointment',
      name: 'new_appointment',
      desc: '',
      args: [],
    );

  /// `{patientName} booked with {doctorName}`
  String patient_booked_with(Object patientName, Object doctorName) => Intl.message(
      '$patientName booked with $doctorName',
      name: 'patient_booked_with',
      desc: '',
      args: [patientName, doctorName],
    );

  /// `New Review`
  String get new_review => Intl.message('New Review', name: 'new_review', desc: '', args: []);

  /// `Review for {doctorName} - {rating} stars`
  String review_for_doctor(Object doctorName, Object rating) => Intl.message(
      'Review for $doctorName - $rating stars',
      name: 'review_for_doctor',
      desc: '',
      args: [doctorName, rating],
    );

  /// `Recently`
  String get recently => Intl.message('Recently', name: 'recently', desc: '', args: []);

  /// `{minutes}m ago`
  String minutes_ago(Object minutes) => Intl.message(
      '${minutes}m ago',
      name: 'minutes_ago',
      desc: '',
      args: [minutes],
    );

  /// `{hours}h ago`
  String hours_ago(Object hours) => Intl.message(
      '${hours}h ago',
      name: 'hours_ago',
      desc: '',
      args: [hours],
    );

  /// `{days}d ago`
  String days_ago(Object days) => Intl.message(
      '${days}d ago',
      name: 'days_ago',
      desc: '',
      args: [days],
    );

  /// `{count} doctors`
  String doctors_count(Object count) => Intl.message(
      '$count doctors',
      name: 'doctors_count',
      desc: '',
      args: [count],
    );

  /// `{count} appointments`
  String appointments_count(Object count) => Intl.message(
      '$count appointments',
      name: 'appointments_count',
      desc: '',
      args: [count],
    );

  /// `No data available`
  String get no_data_available => Intl.message(
      'No data available',
      name: 'no_data_available',
      desc: '',
      args: [],
    );

  /// `No speciality data available`
  String get no_speciality_data => Intl.message(
      'No speciality data available',
      name: 'no_speciality_data',
      desc: '',
      args: [],
    );

  /// `Welcome Back, Admin!`
  String get welcome_back_admin => Intl.message(
      'Welcome Back, Admin!',
      name: 'welcome_back_admin',
      desc: '',
      args: [],
    );

  /// `System operating normally`
  String get system_operating_normally => Intl.message(
      'System operating normally',
      name: 'system_operating_normally',
      desc: '',
      args: [],
    );

  /// `Last login: {time}`
  String last_login(Object time) => Intl.message(
      'Last login: $time',
      name: 'last_login',
      desc: '',
      args: [time],
    );

  /// `Live Statistics`
  String get live_statistics => Intl.message(
      'Live Statistics',
      name: 'live_statistics',
      desc: '',
      args: [],
    );

  /// `System Management`
  String get system_management => Intl.message(
      'System Management',
      name: 'system_management',
      desc: '',
      args: [],
    );

  /// `Add, edit, or remove doctors`
  String get manage_doctors_desc => Intl.message(
      'Add, edit, or remove doctors',
      name: 'manage_doctors_desc',
      desc: '',
      args: [],
    );

  /// `View and manage all appointments`
  String get manage_appointments_desc => Intl.message(
      'View and manage all appointments',
      name: 'manage_appointments_desc',
      desc: '',
      args: [],
    );

  /// `View and manage user accounts`
  String get manage_users_desc => Intl.message(
      'View and manage user accounts',
      name: 'manage_users_desc',
      desc: '',
      args: [],
    );

  /// `Moderate and respond to reviews`
  String get manage_reviews_desc => Intl.message(
      'Moderate and respond to reviews',
      name: 'manage_reviews_desc',
      desc: '',
      args: [],
    );

  /// `Manage blood bank records`
  String get manage_blood_records_desc => Intl.message(
      'Manage blood bank records',
      name: 'manage_blood_records_desc',
      desc: '',
      args: [],
    );

  /// `Add or edit specialities`
  String get manage_specialities_desc => Intl.message(
      'Add or edit specialities',
      name: 'manage_specialities_desc',
      desc: '',
      args: [],
    );

  /// `New doctor added`
  String get new_doctor_added => Intl.message(
      'New doctor added',
      name: 'new_doctor_added',
      desc: '',
      args: [],
    );

  /// `Appointment created`
  String get appointment_created => Intl.message(
      'Appointment created',
      name: 'appointment_created',
      desc: '',
      args: [],
    );

  /// `New review received`
  String get new_review_received => Intl.message(
      'New review received',
      name: 'new_review_received',
      desc: '',
      args: [],
    );

  /// `Notifications`
  String get notifications => Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );

  /// `No notifications found 🔕`
  String get no_notifications => Intl.message(
      'No notifications found 🔕',
      name: 'no_notifications',
      desc: '',
      args: [],
    );

  /// `Mark all as read`
  String get mark_all_as_read => Intl.message(
      'Mark all as read',
      name: 'mark_all_as_read',
      desc: '',
      args: [],
    );

  /// `Clear all`
  String get clear_all => Intl.message('Clear all', name: 'clear_all', desc: '', args: []);
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales => const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];

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
