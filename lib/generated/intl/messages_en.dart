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

  static String m0(count) => "${count} appointments";

  static String m1(date) => "Booked on: ${date}";

  static String m2(date, time) => "Date: ${date} at ${time}";

  static String m3(days) => "${days}d ago";

  static String m4(doctorName) =>
      "Are you sure you want to delete ${doctorName}?";

  static String m5(userName) =>
      "Are you sure you want to permanently delete ${userName}? This action cannot be undone.";

  static String m6(count) => "${count} doctors";

  static String m7(hours) => "${hours}h ago";

  static String m8(doctorName) => "How was your visit with Dr. ${doctorName}?";

  static String m9(time) => "Last login: ${time}";

  static String m10(minutes) => "${minutes}m ago";

  static String m11(patientName) => "Patient: ${patientName}";

  static String m12(patientName, doctorName) =>
      "${patientName} booked with ${doctorName}";

  static String m13(date) => "Reserved on: ${date}";

  static String m14(doctorName, rating) =>
      "Review for ${doctorName} - ${rating} stars";

  static String m15(newStatus) => "Status updated to ${newStatus}";

  static String m16(doctorName, doctorSpecialty) =>
      "with Dr. ${doctorName} (${doctorSpecialty})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Forgot_Password": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "Have_an_Account": MessageLookupByLibrary.simpleMessage("Have an Account?"),
    "Reset_Password": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "Sign_in_title": MessageLookupByLibrary.simpleMessage(
      "Specialized Clinics",
    ),
    "Terms_and_Conditions": MessageLookupByLibrary.simpleMessage(
      "Terms and Conditions",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "account_already_exists": MessageLookupByLibrary.simpleMessage(
      "The account already exists for that email.",
    ),
    "active_requests": MessageLookupByLibrary.simpleMessage("Active requests"),
    "active_users": MessageLookupByLibrary.simpleMessage("Active Users"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "add_doctor": MessageLookupByLibrary.simpleMessage("Add Doctor"),
    "add_new_doctor": MessageLookupByLibrary.simpleMessage("Add New Doctor"),
    "add_schedule": MessageLookupByLibrary.simpleMessage("Add Schedule"),
    "add_shift": MessageLookupByLibrary.simpleMessage("Add Shift"),
    "add_speciality": MessageLookupByLibrary.simpleMessage("Add Speciality"),
    "add_to_favorites": MessageLookupByLibrary.simpleMessage(
      "Add to Favorites",
    ),
    "add_working_hours": MessageLookupByLibrary.simpleMessage(
      "Add Working Hours",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "admin_dashboard": MessageLookupByLibrary.simpleMessage("Admin Dashboard"),
    "admins": MessageLookupByLibrary.simpleMessage("admins"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "all_blood_types": MessageLookupByLibrary.simpleMessage("All"),
    "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
    "analytics_reports": MessageLookupByLibrary.simpleMessage(
      "Analytics & Reports",
    ),
    "analytics_section": MessageLookupByLibrary.simpleMessage("Analytics"),
    "appointment_booked_successfully": MessageLookupByLibrary.simpleMessage(
      "Appointment booked successfully!",
    ),
    "appointment_created": MessageLookupByLibrary.simpleMessage(
      "Appointment created",
    ),
    "appointment_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "Appointment deleted successfully",
    ),
    "appointment_status": MessageLookupByLibrary.simpleMessage(
      "Appointment Status",
    ),
    "appointment_trends_last_7_days": MessageLookupByLibrary.simpleMessage(
      "Appointment Trends (Last 7 Days)",
    ),
    "appointments": MessageLookupByLibrary.simpleMessage("Appointments"),
    "appointments_count": m0,
    "arabic_bio": MessageLookupByLibrary.simpleMessage("Arabic Bio"),
    "arabic_name": MessageLookupByLibrary.simpleMessage("Arabic Name"),
    "available": MessageLookupByLibrary.simpleMessage("Available"),
    "average_rating": MessageLookupByLibrary.simpleMessage("Average Rating"),
    "avg_rating": MessageLookupByLibrary.simpleMessage("Avg Rating"),
    "bad_request": MessageLookupByLibrary.simpleMessage("Bad Request"),
    "basic_information": MessageLookupByLibrary.simpleMessage(
      "Basic Information",
    ),
    "blood": MessageLookupByLibrary.simpleMessage("Blood"),
    "blood_donation_records": MessageLookupByLibrary.simpleMessage(
      "Blood Donation Records",
    ),
    "blood_records": MessageLookupByLibrary.simpleMessage("Blood Records"),
    "blood_requests": MessageLookupByLibrary.simpleMessage("Blood Requests"),
    "blood_type": MessageLookupByLibrary.simpleMessage("Blood type"),
    "blood_type_AB_negative": MessageLookupByLibrary.simpleMessage("AB-"),
    "blood_type_AB_positive": MessageLookupByLibrary.simpleMessage("AB+"),
    "blood_type_A_negative": MessageLookupByLibrary.simpleMessage("A-"),
    "blood_type_A_positive": MessageLookupByLibrary.simpleMessage("A+"),
    "blood_type_B_negative": MessageLookupByLibrary.simpleMessage("B-"),
    "blood_type_B_positive": MessageLookupByLibrary.simpleMessage("B+"),
    "blood_type_O_negative": MessageLookupByLibrary.simpleMessage("O-"),
    "blood_type_O_positive": MessageLookupByLibrary.simpleMessage("O+"),
    "blood_type_unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "blood_types": MessageLookupByLibrary.simpleMessage("Blood Types"),
    "bookNow": MessageLookupByLibrary.simpleMessage("Book Now"),
    "book_appointment": MessageLookupByLibrary.simpleMessage(
      "Book Appointment",
    ),
    "book_your_appointment": MessageLookupByLibrary.simpleMessage(
      "Book your appointments",
    ),
    "booked_on": m1,
    "booking": MessageLookupByLibrary.simpleMessage("Booking..."),
    "browse_doctors": MessageLookupByLibrary.simpleMessage("Browse Doctors"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancel_appointment": MessageLookupByLibrary.simpleMessage(
      "Cancel Appointment",
    ),
    "cancel_appointment_button": MessageLookupByLibrary.simpleMessage(
      "Cancel Appointment",
    ),
    "cancel_appointment_confirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel this appointment? This action cannot be undone.",
    ),
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "cardiology": MessageLookupByLibrary.simpleMessage("Cardiology"),
    "check_your_email": MessageLookupByLibrary.simpleMessage(
      "Check your email to reset your password",
    ),
    "check_your_email_and_password": MessageLookupByLibrary.simpleMessage(
      "Check your Email and Password.",
    ),
    "choose_blood_type": MessageLookupByLibrary.simpleMessage(
      "Choose your blood type",
    ),
    "clear_all": MessageLookupByLibrary.simpleMessage("Clear all"),
    "clinics": MessageLookupByLibrary.simpleMessage("Clinics"),
    "complete": MessageLookupByLibrary.simpleMessage("Complete"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirm_appointment": MessageLookupByLibrary.simpleMessage(
      "Confirm Appointment",
    ),
    "confirm_delete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
    "confirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "conflict_occurred": MessageLookupByLibrary.simpleMessage(
      "Conflict Occurred",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Create Account"),
    "csv_data_copied": MessageLookupByLibrary.simpleMessage(
      "CSV data copied to clipboard",
    ),
    "csv_format": MessageLookupByLibrary.simpleMessage("CSV Format"),
    "data_copied_to_clipboard": MessageLookupByLibrary.simpleMessage(
      "Data will be copied to clipboard",
    ),
    "date_at_time": m2,
    "days_ago": m3,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "delete_doctor": MessageLookupByLibrary.simpleMessage("Delete Doctor"),
    "delete_doctor_confirmation": m4,
    "delete_doctor_message": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this doctor?",
    ),
    "delete_user": MessageLookupByLibrary.simpleMessage("Delete User"),
    "delete_user_confirmation": m5,
    "dentistry": MessageLookupByLibrary.simpleMessage("Dentistry"),
    "dermatology": MessageLookupByLibrary.simpleMessage("Dermatology"),
    "discover_doctor_availability": MessageLookupByLibrary.simpleMessage(
      "Discover doctor availability",
    ),
    "do_you_agree": MessageLookupByLibrary.simpleMessage(
      "Do you agree to our ",
    ),
    "doctor_added": MessageLookupByLibrary.simpleMessage(
      "Doctor added successfully",
    ),
    "doctor_added_successfully": MessageLookupByLibrary.simpleMessage(
      "Doctor added successfully",
    ),
    "doctor_deleted": MessageLookupByLibrary.simpleMessage(
      "Doctor deleted successfully",
    ),
    "doctor_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "Doctor deleted successfully",
    ),
    "doctor_name": MessageLookupByLibrary.simpleMessage("Doctor Name"),
    "doctor_name_ar": MessageLookupByLibrary.simpleMessage("Doctor Name (AR)"),
    "doctor_name_en": MessageLookupByLibrary.simpleMessage("Doctor Name (EN)"),
    "doctor_updated": MessageLookupByLibrary.simpleMessage(
      "Doctor updated successfully",
    ),
    "doctor_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Doctor updated successfully",
    ),
    "doctors": MessageLookupByLibrary.simpleMessage("Doctors"),
    "doctors_count": m6,
    "dont_have_an_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "dr": MessageLookupByLibrary.simpleMessage("Dr. "),
    "edit_doctor": MessageLookupByLibrary.simpleMessage("Edit Doctor"),
    "edit_doctor_profile": MessageLookupByLibrary.simpleMessage(
      "Edit Doctor Profile",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_address": MessageLookupByLibrary.simpleMessage("Email Address"),
    "end_time": MessageLookupByLibrary.simpleMessage("End Time"),
    "english_bio": MessageLookupByLibrary.simpleMessage("English Bio"),
    "english_name": MessageLookupByLibrary.simpleMessage("English Name"),
    "enhanced_dashboard_title": MessageLookupByLibrary.simpleMessage(
      "Admin Dashboard",
    ),
    "ent": MessageLookupByLibrary.simpleMessage("Ear, Nose, and Throat (ENT)"),
    "enter_your_email": MessageLookupByLibrary.simpleMessage(
      "Enter Your Email Below To Get Reset Password Link",
    ),
    "error_during_communication": MessageLookupByLibrary.simpleMessage(
      "Error During Communication",
    ),
    "error_loading_dashboard": MessageLookupByLibrary.simpleMessage(
      "Error loading dashboard",
    ),
    "error_occurred": MessageLookupByLibrary.simpleMessage(
      "An error occurred. Please try again later.",
    ),
    "experience": MessageLookupByLibrary.simpleMessage("Experience"),
    "experience_years": MessageLookupByLibrary.simpleMessage(
      "Years of Experience",
    ),
    "explore": MessageLookupByLibrary.simpleMessage("Explore a wide range"),
    "export_csv_description": MessageLookupByLibrary.simpleMessage(
      "Export as comma-separated values",
    ),
    "export_dashboard_data": MessageLookupByLibrary.simpleMessage(
      "Export Dashboard Data",
    ),
    "export_data": MessageLookupByLibrary.simpleMessage("Export Data"),
    "export_json_description": MessageLookupByLibrary.simpleMessage(
      "Export as JSON data",
    ),
    "favorite_added": MessageLookupByLibrary.simpleMessage(
      "Added to favorites",
    ),
    "favorite_removed": MessageLookupByLibrary.simpleMessage(
      "Removed from favorites",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "female": MessageLookupByLibrary.simpleMessage("Female"),
    "field_is_required": MessageLookupByLibrary.simpleMessage(
      "Field is required",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filter_all": MessageLookupByLibrary.simpleMessage("All"),
    "filter_appointments": MessageLookupByLibrary.simpleMessage("Appointments"),
    "filter_reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "filter_users": MessageLookupByLibrary.simpleMessage("Users"),
    "first_name": MessageLookupByLibrary.simpleMessage("First Name"),
    "friday": MessageLookupByLibrary.simpleMessage("Friday"),
    "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "general_surgery": MessageLookupByLibrary.simpleMessage("General Surgery"),
    "hany": MessageLookupByLibrary.simpleMessage("Hani Abdel Momen"),
    "hello": MessageLookupByLibrary.simpleMessage("Hello, "),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hours_ago": m7,
    "how_was_your_visit": m8,
    "in_our_medical_center": MessageLookupByLibrary.simpleMessage(
      "In our medical center, you can see your favorite doctor.",
    ),
    "internal_medicine": MessageLookupByLibrary.simpleMessage(
      "Internal Medicine",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Internal Server Error",
    ),
    "invalid_email": MessageLookupByLibrary.simpleMessage(
      "The email is invalid.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("items"),
    "joint": MessageLookupByLibrary.simpleMessage("Joint Clinic"),
    "json_data_copied": MessageLookupByLibrary.simpleMessage(
      "JSON data copied to clipboard",
    ),
    "json_format": MessageLookupByLibrary.simpleMessage("JSON Format"),
    "just_now": MessageLookupByLibrary.simpleMessage("Just now"),
    "landline": MessageLookupByLibrary.simpleMessage("Landline"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "last_login": m9,
    "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
    "last_update": MessageLookupByLibrary.simpleMessage("Last Update"),
    "live_statistics": MessageLookupByLibrary.simpleMessage("Live Statistics"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "loading_specialities": MessageLookupByLibrary.simpleMessage(
      "Loading Specialities...",
    ),
    "male": MessageLookupByLibrary.simpleMessage("Male"),
    "manage_appointments": MessageLookupByLibrary.simpleMessage("Appointments"),
    "manage_appointments_desc": MessageLookupByLibrary.simpleMessage(
      "View and manage all appointments",
    ),
    "manage_blood_records": MessageLookupByLibrary.simpleMessage(
      "Blood Records",
    ),
    "manage_blood_records_desc": MessageLookupByLibrary.simpleMessage(
      "Manage blood bank records",
    ),
    "manage_doctors": MessageLookupByLibrary.simpleMessage("Manage Doctors"),
    "manage_doctors_desc": MessageLookupByLibrary.simpleMessage(
      "Add, edit, or remove doctors",
    ),
    "manage_reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
    "manage_reviews_desc": MessageLookupByLibrary.simpleMessage(
      "Moderate and respond to reviews",
    ),
    "manage_specialities": MessageLookupByLibrary.simpleMessage("Specialities"),
    "manage_specialities_desc": MessageLookupByLibrary.simpleMessage(
      "Add or edit specialities",
    ),
    "manage_users": MessageLookupByLibrary.simpleMessage("Manage Users"),
    "manage_users_desc": MessageLookupByLibrary.simpleMessage(
      "View and manage user accounts",
    ),
    "mark_all_as_read": MessageLookupByLibrary.simpleMessage(
      "Mark all as read",
    ),
    "minutes_ago": m10,
    "mit_azzoun": MessageLookupByLibrary.simpleMessage(
      "Mit Azzoun next to the Grand Mosque.",
    ),
    "monday": MessageLookupByLibrary.simpleMessage("Monday"),
    "my_appointments": MessageLookupByLibrary.simpleMessage("My Appointments"),
    "my_favorites": MessageLookupByLibrary.simpleMessage("My Favorite Doctors"),
    "name_must_be_3_chars": MessageLookupByLibrary.simpleMessage(
      "Name must be at least 3 characters",
    ),
    "nephrology_urology": MessageLookupByLibrary.simpleMessage(
      "Nephrology and Urology",
    ),
    "neurology": MessageLookupByLibrary.simpleMessage("Neurology"),
    "new_appointment": MessageLookupByLibrary.simpleMessage("New Appointment"),
    "new_doctor_added": MessageLookupByLibrary.simpleMessage(
      "New doctor added",
    ),
    "new_review": MessageLookupByLibrary.simpleMessage("New Review"),
    "new_review_received": MessageLookupByLibrary.simpleMessage(
      "New review received",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noDoctorsFound": MessageLookupByLibrary.simpleMessage("No Doctors Found"),
    "noDoctorsInCategory": MessageLookupByLibrary.simpleMessage(
      "No doctors are currently available in this category.",
    ),
    "noReviewsYet": MessageLookupByLibrary.simpleMessage(
      "No reviews yet. Be the first to share your experience!",
    ),
    "no_activities_found": MessageLookupByLibrary.simpleMessage(
      "No activities found",
    ),
    "no_appointments": MessageLookupByLibrary.simpleMessage("No Appointments"),
    "no_appointments_found": MessageLookupByLibrary.simpleMessage(
      "No appointments found",
    ),
    "no_appointments_matching_filter": MessageLookupByLibrary.simpleMessage(
      "There are no appointments matching the selected filter.",
    ),
    "no_appointments_subtitle": MessageLookupByLibrary.simpleMessage(
      "You haven\'t booked any appointments yet.",
    ),
    "no_blood_records": MessageLookupByLibrary.simpleMessage(
      "No Blood Records",
    ),
    "no_blood_records_registered": MessageLookupByLibrary.simpleMessage(
      "There are no blood donation records registered yet.",
    ),
    "no_blood_types_found": MessageLookupByLibrary.simpleMessage(
      "No blood types found 😥",
    ),
    "no_data_available": MessageLookupByLibrary.simpleMessage(
      "No data available",
    ),
    "no_doctors_found": MessageLookupByLibrary.simpleMessage(
      "No doctors found",
    ),
    "no_doctors_registered": MessageLookupByLibrary.simpleMessage(
      "There are no doctors registered in the system.",
    ),
    "no_favorites": MessageLookupByLibrary.simpleMessage("No Favorites Yet"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "No Internet Connection",
    ),
    "no_keep_it": MessageLookupByLibrary.simpleMessage("No, keep it"),
    "no_notifications": MessageLookupByLibrary.simpleMessage(
      "No notifications found 🔕",
    ),
    "no_reviews": MessageLookupByLibrary.simpleMessage("No Reviews"),
    "no_reviews_found": MessageLookupByLibrary.simpleMessage(
      "No reviews found",
    ),
    "no_reviews_to_display": MessageLookupByLibrary.simpleMessage(
      "There are no patient reviews to display yet.",
    ),
    "no_schedules_added_yet": MessageLookupByLibrary.simpleMessage(
      "No schedules added yet",
    ),
    "no_speciality_data": MessageLookupByLibrary.simpleMessage(
      "No speciality data available",
    ),
    "no_specialties": MessageLookupByLibrary.simpleMessage("No Specialties"),
    "no_specialties_added": MessageLookupByLibrary.simpleMessage(
      "You haven\'t added any clinical specialties yet.",
    ),
    "no_user_found": MessageLookupByLibrary.simpleMessage(
      "No user found for that email.",
    ),
    "no_users_found": MessageLookupByLibrary.simpleMessage("No users found"),
    "no_users_registered": MessageLookupByLibrary.simpleMessage(
      "There are no users registered in the system yet.",
    ),
    "notWorking": MessageLookupByLibrary.simpleMessage("Not Working"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "nutrition_therapy": MessageLookupByLibrary.simpleMessage(
      "Nutritional Therapy",
    ),
    "obgyn": MessageLookupByLibrary.simpleMessage("Obstetrics and Gynecology"),
    "of_medical_specialists": MessageLookupByLibrary.simpleMessage(
      "Of medical specialties for your healthcare needs.",
    ),
    "on_specific_days": MessageLookupByLibrary.simpleMessage(
      "On specific days for easy planning of your visit.",
    ),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "ophthalmology": MessageLookupByLibrary.simpleMessage("Ophthalmology"),
    "ourDoctors": MessageLookupByLibrary.simpleMessage("Our Doctors"),
    "overview": MessageLookupByLibrary.simpleMessage("Overview"),
    "overview_statistics": MessageLookupByLibrary.simpleMessage(
      "Overview Statistics",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "patient": m11,
    "patientReviews": MessageLookupByLibrary.simpleMessage("Patient Reviews"),
    "patient_booked_with": m12,
    "patient_information": MessageLookupByLibrary.simpleMessage(
      "Patient Information",
    ),
    "patient_reviews": MessageLookupByLibrary.simpleMessage("Patient Reviews"),
    "pediatrics": MessageLookupByLibrary.simpleMessage("Pediatrics"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "pending_appointments": MessageLookupByLibrary.simpleMessage(
      "Appointments",
    ),
    "personal_information": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "phone_number": MessageLookupByLibrary.simpleMessage("Phone number"),
    "please_enter_patient_name": MessageLookupByLibrary.simpleMessage(
      "Please enter patient name",
    ),
    "please_enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "Please enter phone number",
    ),
    "please_enter_valid_phone": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profile_image_url": MessageLookupByLibrary.simpleMessage(
      "Profile Image URL",
    ),
    "quick_actions": MessageLookupByLibrary.simpleMessage("Quick Actions"),
    "rate_and_review": MessageLookupByLibrary.simpleMessage("Rate & Review"),
    "rate_your_experience": MessageLookupByLibrary.simpleMessage(
      "Rate your experience",
    ),
    "rating": MessageLookupByLibrary.simpleMessage("Rating"),
    "recent_activity": MessageLookupByLibrary.simpleMessage("Recent Activity"),
    "recently": MessageLookupByLibrary.simpleMessage("Recently"),
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "Remove from Favorites",
    ),
    "requested_info_not_found": MessageLookupByLibrary.simpleMessage(
      "Requested Info Not Found",
    ),
    "required": MessageLookupByLibrary.simpleMessage("This field is required."),
    "reserved_on": m13,
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "review_for_doctor": m14,
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "Review submitted successfully!",
    ),
    "reviews": MessageLookupByLibrary.simpleMessage("reviews"),
    "rheumatology_joint": MessageLookupByLibrary.simpleMessage(
      "Rheumatology and Joint",
    ),
    "role_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "Role updated successfully",
    ),
    "saturday": MessageLookupByLibrary.simpleMessage("Saturday"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "save_changes": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "saving": MessageLookupByLibrary.simpleMessage("Saving..."),
    "search_activities": MessageLookupByLibrary.simpleMessage(
      "Search activities...",
    ),
    "search_by_name_or_specialty": MessageLookupByLibrary.simpleMessage(
      "Search by name or specialty",
    ),
    "search_users_hint": MessageLookupByLibrary.simpleMessage(
      "Search by name or email",
    ),
    "select_appointment_date": MessageLookupByLibrary.simpleMessage(
      "Select Appointment Date",
    ),
    "select_appointment_time": MessageLookupByLibrary.simpleMessage(
      "Select Appointment Time",
    ),
    "select_day": MessageLookupByLibrary.simpleMessage("Select Day"),
    "select_export_format": MessageLookupByLibrary.simpleMessage(
      "Select export format:",
    ),
    "select_photo_source": MessageLookupByLibrary.simpleMessage(
      "Select Photo Source",
    ),
    "select_specialization": MessageLookupByLibrary.simpleMessage(
      "Select Specialization",
    ),
    "selected_date": MessageLookupByLibrary.simpleMessage("Selected Date"),
    "selected_time": MessageLookupByLibrary.simpleMessage("Selected Time"),
    "send_reset_password_link": MessageLookupByLibrary.simpleMessage(
      "Send Reset Password Link",
    ),
    "server_status": MessageLookupByLibrary.simpleMessage("Server Status"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "share_your_thoughts": MessageLookupByLibrary.simpleMessage(
      "Share your thoughts...",
    ),
    "sign_in": MessageLookupByLibrary.simpleMessage("Sign In"),
    "sign_out": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signed_out_successfully": MessageLookupByLibrary.simpleMessage(
      "Signed out successfully",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "specialistPractitioner": MessageLookupByLibrary.simpleMessage(
      "Specialist Practitioner",
    ),
    "specialities": MessageLookupByLibrary.simpleMessage("specialities"),
    "speciality_added_successfully": MessageLookupByLibrary.simpleMessage(
      "Speciality added successfully",
    ),
    "speciality_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "Speciality deleted successfully",
    ),
    "specialization": MessageLookupByLibrary.simpleMessage("Specialization"),
    "specialties": MessageLookupByLibrary.simpleMessage("Specialties"),
    "specialty": MessageLookupByLibrary.simpleMessage("Specialty"),
    "speech_behavior_modification": MessageLookupByLibrary.simpleMessage(
      "Speech and Behavior Modification",
    ),
    "start_adding_favorites": MessageLookupByLibrary.simpleMessage(
      "Tap the heart icon on any doctor card to add them to your favorites",
    ),
    "start_time": MessageLookupByLibrary.simpleMessage("Start Time"),
    "status_updated_to": m15,
    "street": MessageLookupByLibrary.simpleMessage(
      "The Meezanieh Street, next to Dr. Abdullah Saleh\'s pharmacy.",
    ),
    "submit_review": MessageLookupByLibrary.simpleMessage("Submit Review"),
    "subtitle": MessageLookupByLibrary.simpleMessage(
      "Wishing you health and happiness ❤️",
    ),
    "success": MessageLookupByLibrary.simpleMessage(
      "Success, Check your email to verify your account",
    ),
    "sunday": MessageLookupByLibrary.simpleMessage("Sunday"),
    "system_management": MessageLookupByLibrary.simpleMessage(
      "System Management",
    ),
    "system_operating_normally": MessageLookupByLibrary.simpleMessage(
      "System operating normally",
    ),
    "system_status": MessageLookupByLibrary.simpleMessage("System Status"),
    "tap_to_change_photo": MessageLookupByLibrary.simpleMessage(
      "Tap to change photo",
    ),
    "thursday": MessageLookupByLibrary.simpleMessage("Thursday"),
    "ticket_price": MessageLookupByLibrary.simpleMessage("Ticket Price"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "today_appointments": MessageLookupByLibrary.simpleMessage("today"),
    "top_doctors": MessageLookupByLibrary.simpleMessage("Top Doctors"),
    "top_specialities": MessageLookupByLibrary.simpleMessage(
      "Top Specialities",
    ),
    "totalCharges": MessageLookupByLibrary.simpleMessage("Total Charges"),
    "total_appointments": MessageLookupByLibrary.simpleMessage(
      "Total Appointments",
    ),
    "total_doctors": MessageLookupByLibrary.simpleMessage("Total Doctors"),
    "total_users": MessageLookupByLibrary.simpleMessage("Total Users"),
    "tuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
    "unauthorized": MessageLookupByLibrary.simpleMessage("Unauthorized"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "upload_image": MessageLookupByLibrary.simpleMessage("Upload Image"),
    "user_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "User deleted successfully",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage("User not found"),
    "users": MessageLookupByLibrary.simpleMessage("Users"),
    "verified": MessageLookupByLibrary.simpleMessage("Verified"),
    "verify": MessageLookupByLibrary.simpleMessage(
      "Please verify your account!",
    ),
    "view_all": MessageLookupByLibrary.simpleMessage("View All"),
    "weak_password": MessageLookupByLibrary.simpleMessage(
      "The password provided is too weak.",
    ),
    "wednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "welcome_back": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "welcome_back_admin": MessageLookupByLibrary.simpleMessage(
      "Welcome Back, Admin!",
    ),
    "with_dr_specialty": m16,
    "workingDays": MessageLookupByLibrary.simpleMessage("Working Days"),
    "working_hours": MessageLookupByLibrary.simpleMessage("Working Hours"),
    "wrong_password": MessageLookupByLibrary.simpleMessage(
      "Wrong password provided for that user.",
    ),
    "years": MessageLookupByLibrary.simpleMessage("Yrs"),
    "yes_cancel": MessageLookupByLibrary.simpleMessage("Yes, cancel"),
  };
}
