// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(count) => "${count} مواعيد";

  static String m1(date) => "تم الحجز في: ${date}";

  static String m2(date, time) => "التاريخ: ${date} في ${time}";

  static String m3(days) => "منذ ${days} يوم";

  static String m4(doctorName) => "هل أنت متأكد أنك تريد حذف ${doctorName}؟";

  static String m5(userName) =>
      "هل أنت متأكد أنك تريد حذف ${userName} نهائيًا؟ لا يمكن التراجع عن هذا الإجراء.";

  static String m6(count) => "${count} أطباء";

  static String m7(hours) => "منذ ${hours} ساعة";

  static String m8(doctorName) => "كيف كانت زيارتك مع د. ${doctorName}؟";

  static String m9(time) => "آخر تسجيل دخول: ${time}";

  static String m10(minutes) => "منذ ${minutes} دقيقة";

  static String m11(patientName) => "المريض: ${patientName}";

  static String m12(patientName, doctorName) =>
      "${patientName} حجز مع ${doctorName}";

  static String m13(date) => "محجوز في: ${date}";

  static String m14(doctorName, rating) =>
      "تقييم للدكتور ${doctorName} - ${rating} نجوم";

  static String m15(newStatus) => "تم تحديث الحالة إلى ${newStatus}";

  static String m16(doctorName, doctorSpecialty) =>
      "مع د. ${doctorName} (${doctorSpecialty})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Forgot_Password": MessageLookupByLibrary.simpleMessage(
      "هل نسيت كلمة المرور؟",
    ),
    "Have_an_Account": MessageLookupByLibrary.simpleMessage("هل لديك حساب؟"),
    "Reset_Password": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "Sign_in_title": MessageLookupByLibrary.simpleMessage("العيادات التخصصية"),
    "Terms_and_Conditions": MessageLookupByLibrary.simpleMessage(
      "الشروط والأحكام",
    ),
    "account": MessageLookupByLibrary.simpleMessage("الحساب"),
    "account_already_exists": MessageLookupByLibrary.simpleMessage(
      "الحساب موجود بالفعل لهذا البريد الإلكتروني.",
    ),
    "active_requests": MessageLookupByLibrary.simpleMessage("الطلبات النشطة"),
    "active_users": MessageLookupByLibrary.simpleMessage("المستخدمون النشطون"),
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "add_doctor": MessageLookupByLibrary.simpleMessage("إضافة طبيب"),
    "add_new_doctor": MessageLookupByLibrary.simpleMessage("إضافة طبيب جديد"),
    "add_schedule": MessageLookupByLibrary.simpleMessage("إضافة جدول"),
    "add_shift": MessageLookupByLibrary.simpleMessage("إضافة وردية"),
    "add_speciality": MessageLookupByLibrary.simpleMessage("إضافة تخصص"),
    "add_to_favorites": MessageLookupByLibrary.simpleMessage("إضافة للمفضلة"),
    "add_working_hours": MessageLookupByLibrary.simpleMessage(
      "إضافة ساعات عمل",
    ),
    "address": MessageLookupByLibrary.simpleMessage("العنوان"),
    "admin_dashboard": MessageLookupByLibrary.simpleMessage("لوحة التحكم"),
    "admins": MessageLookupByLibrary.simpleMessage("مسؤولين"),
    "all": MessageLookupByLibrary.simpleMessage("جميع التخصصات"),
    "all_blood_types": MessageLookupByLibrary.simpleMessage("الكل"),
    "analytics": MessageLookupByLibrary.simpleMessage("التحليلات"),
    "analytics_reports": MessageLookupByLibrary.simpleMessage(
      "التحليلات والتقارير",
    ),
    "analytics_section": MessageLookupByLibrary.simpleMessage("التحليلات"),
    "appointment_booked_successfully": MessageLookupByLibrary.simpleMessage(
      "تم حجز الموعد بنجاح!",
    ),
    "appointment_created": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء موعد",
    ),
    "appointment_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "تم حذف الموعد بنجاح",
    ),
    "appointment_status": MessageLookupByLibrary.simpleMessage("حالة الموعد"),
    "appointment_trends_last_7_days": MessageLookupByLibrary.simpleMessage(
      "اتجاهات المواعيد (آخر 7 أيام)",
    ),
    "appointments": MessageLookupByLibrary.simpleMessage("المواعيد"),
    "appointments_count": m0,
    "arabic_bio": MessageLookupByLibrary.simpleMessage("النبذة بالعربية"),
    "arabic_name": MessageLookupByLibrary.simpleMessage("الاسم بالعربية"),
    "available": MessageLookupByLibrary.simpleMessage("متاح"),
    "average_rating": MessageLookupByLibrary.simpleMessage("متوسط التقييم"),
    "avg_rating": MessageLookupByLibrary.simpleMessage("متوسط التقييم"),
    "bad_request": MessageLookupByLibrary.simpleMessage("طلب غير صحيح"),
    "basic_information": MessageLookupByLibrary.simpleMessage(
      "المعلومات الأساسية",
    ),
    "blood": MessageLookupByLibrary.simpleMessage("الدم"),
    "blood_donation_records": MessageLookupByLibrary.simpleMessage(
      "سجلات التبرع بالدم",
    ),
    "blood_records": MessageLookupByLibrary.simpleMessage("سجلات الدم"),
    "blood_requests": MessageLookupByLibrary.simpleMessage("طلبات الدم"),
    "blood_type": MessageLookupByLibrary.simpleMessage("فصيلة الدم"),
    "blood_type_AB_negative": MessageLookupByLibrary.simpleMessage("AB-"),
    "blood_type_AB_positive": MessageLookupByLibrary.simpleMessage("AB+"),
    "blood_type_A_negative": MessageLookupByLibrary.simpleMessage("A-"),
    "blood_type_A_positive": MessageLookupByLibrary.simpleMessage("A+"),
    "blood_type_B_negative": MessageLookupByLibrary.simpleMessage("B-"),
    "blood_type_B_positive": MessageLookupByLibrary.simpleMessage("B+"),
    "blood_type_O_negative": MessageLookupByLibrary.simpleMessage("O-"),
    "blood_type_O_positive": MessageLookupByLibrary.simpleMessage("O+"),
    "blood_type_unknown": MessageLookupByLibrary.simpleMessage("غير معروف"),
    "blood_types": MessageLookupByLibrary.simpleMessage("فصائل الدم"),
    "bookNow": MessageLookupByLibrary.simpleMessage("احجز الآن"),
    "book_appointment": MessageLookupByLibrary.simpleMessage("حجز موعد"),
    "book_your_appointment": MessageLookupByLibrary.simpleMessage(
      "احجز مواعيدك",
    ),
    "booked_on": m1,
    "booking": MessageLookupByLibrary.simpleMessage("جاري الحجز..."),
    "browse_doctors": MessageLookupByLibrary.simpleMessage("تصفح الأطباء"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancel_appointment": MessageLookupByLibrary.simpleMessage("إلغاء الموعد"),
    "cancel_appointment_button": MessageLookupByLibrary.simpleMessage(
      "إلغاء الموعد",
    ),
    "cancel_appointment_confirmation": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد إلغاء هذا الموعد؟ لا يمكن التراجع عن هذا الإجراء.",
    ),
    "cancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
    "cardiology": MessageLookupByLibrary.simpleMessage("القلب"),
    "check_your_email": MessageLookupByLibrary.simpleMessage(
      "تحقق من بريدك الإلكتروني لإعادة تعيين كلمة المرور",
    ),
    "check_your_email_and_password": MessageLookupByLibrary.simpleMessage(
      "برجاء التأكد من الايميل وكلمة المرور.",
    ),
    "choose_blood_type": MessageLookupByLibrary.simpleMessage("اختر فصيلة دمك"),
    "clear_all": MessageLookupByLibrary.simpleMessage("مسح الكل"),
    "clinics": MessageLookupByLibrary.simpleMessage("العيادات"),
    "complete": MessageLookupByLibrary.simpleMessage("إكمال"),
    "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirm_appointment": MessageLookupByLibrary.simpleMessage("تأكيد الموعد"),
    "confirm_delete": MessageLookupByLibrary.simpleMessage("تأكيد الحذف"),
    "confirmed": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "conflict_occurred": MessageLookupByLibrary.simpleMessage("حدث تعارض"),
    "create_account": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "csv_data_copied": MessageLookupByLibrary.simpleMessage(
      "تم نسخ بيانات CSV إلى الحافظة",
    ),
    "csv_format": MessageLookupByLibrary.simpleMessage("صيغة CSV"),
    "data_copied_to_clipboard": MessageLookupByLibrary.simpleMessage(
      "سيتم نسخ البيانات إلى الحافظة",
    ),
    "date_at_time": m2,
    "days_ago": m3,
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "delete_doctor": MessageLookupByLibrary.simpleMessage("حذف طبيب"),
    "delete_doctor_confirmation": m4,
    "delete_doctor_message": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من حذف هذا الطبيب؟",
    ),
    "delete_user": MessageLookupByLibrary.simpleMessage("حذف المستخدم"),
    "delete_user_confirmation": m5,
    "dentistry": MessageLookupByLibrary.simpleMessage("الأسنان"),
    "dermatology": MessageLookupByLibrary.simpleMessage("الجلدية"),
    "discover_doctor_availability": MessageLookupByLibrary.simpleMessage(
      "اكتشف توافر الأطباء",
    ),
    "do_you_agree": MessageLookupByLibrary.simpleMessage("هل توافق على "),
    "doctor_added": MessageLookupByLibrary.simpleMessage(
      "تم إضافة الطبيب بنجاح",
    ),
    "doctor_added_successfully": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة الطبيب بنجاح",
    ),
    "doctor_deleted": MessageLookupByLibrary.simpleMessage(
      "تم حذف الطبيب بنجاح",
    ),
    "doctor_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "تم حذف الطبيب بنجاح",
    ),
    "doctor_name": MessageLookupByLibrary.simpleMessage("اسم الطبيب"),
    "doctor_name_ar": MessageLookupByLibrary.simpleMessage("اسم الطبيب (AR)"),
    "doctor_name_en": MessageLookupByLibrary.simpleMessage("اسم الطبيب (EN)"),
    "doctor_updated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الطبيب بنجاح",
    ),
    "doctor_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الطبيب بنجاح",
    ),
    "doctors": MessageLookupByLibrary.simpleMessage("الأطباء"),
    "doctors_count": m6,
    "dont_have_an_account": MessageLookupByLibrary.simpleMessage(
      "ليس لديك حساب؟",
    ),
    "dr": MessageLookupByLibrary.simpleMessage("د. "),
    "edit_doctor": MessageLookupByLibrary.simpleMessage("تعديل طبيب"),
    "edit_doctor_profile": MessageLookupByLibrary.simpleMessage(
      "تعديل ملف الطبيب",
    ),
    "edit_profile": MessageLookupByLibrary.simpleMessage(
      "تعديل الصفحة الشخصية",
    ),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "email_address": MessageLookupByLibrary.simpleMessage(
      "عنوان البريد الإلكتروني",
    ),
    "end_time": MessageLookupByLibrary.simpleMessage("وقت الانتهاء"),
    "english_bio": MessageLookupByLibrary.simpleMessage("النبذة بالإنجليزية"),
    "english_name": MessageLookupByLibrary.simpleMessage("الاسم بالإنجليزية"),
    "enhanced_dashboard_title": MessageLookupByLibrary.simpleMessage(
      "لوحة تحكم الإدارة",
    ),
    "ent": MessageLookupByLibrary.simpleMessage("أنف وأذن وحنجرة"),
    "enter_your_email": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدك الإلكتروني أدناه للحصول على رابط إعادة تعيين كلمة المرور",
    ),
    "error_during_communication": MessageLookupByLibrary.simpleMessage(
      "خطأ أثناء الاتصال",
    ),
    "error_loading_dashboard": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحميل لوحة التحكم",
    ),
    "error_occurred": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق.",
    ),
    "experience": MessageLookupByLibrary.simpleMessage("الخبرة"),
    "experience_years": MessageLookupByLibrary.simpleMessage("سنوات الخبرة"),
    "explore": MessageLookupByLibrary.simpleMessage("استكشف مجموعة واسعة"),
    "export_csv_description": MessageLookupByLibrary.simpleMessage(
      "تصدير كملف قيم مفصولة بفواصل",
    ),
    "export_dashboard_data": MessageLookupByLibrary.simpleMessage(
      "تصدير بيانات لوحة التحكم",
    ),
    "export_data": MessageLookupByLibrary.simpleMessage("تصدير البيانات"),
    "export_json_description": MessageLookupByLibrary.simpleMessage(
      "تصدير كبيانات JSON",
    ),
    "favorite_added": MessageLookupByLibrary.simpleMessage(
      "تمت الإضافة للمفضلة",
    ),
    "favorite_removed": MessageLookupByLibrary.simpleMessage(
      "تمت الإزالة من المفضلة",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "female": MessageLookupByLibrary.simpleMessage("أنثى"),
    "field_is_required": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
    "filter_all": MessageLookupByLibrary.simpleMessage("الكل"),
    "filter_appointments": MessageLookupByLibrary.simpleMessage("المواعيد"),
    "filter_reviews": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "filter_users": MessageLookupByLibrary.simpleMessage("المستخدمين"),
    "first_name": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
    "friday": MessageLookupByLibrary.simpleMessage("الجمعة"),
    "full_name": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
    "gender": MessageLookupByLibrary.simpleMessage("النوع"),
    "general": MessageLookupByLibrary.simpleMessage("عام"),
    "general_surgery": MessageLookupByLibrary.simpleMessage("الجراحة العامة"),
    "hany": MessageLookupByLibrary.simpleMessage("هاني عبد المؤمن"),
    "hello": MessageLookupByLibrary.simpleMessage("مرحبًا، "),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "hours_ago": m7,
    "how_was_your_visit": m8,
    "in_our_medical_center": MessageLookupByLibrary.simpleMessage(
      "في مركزنا الطبي، يمكنك رؤية طبيبك المفضل بسهولة.",
    ),
    "internal_medicine": MessageLookupByLibrary.simpleMessage("الباطنة"),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "خطأ في الخادم الداخلي",
    ),
    "invalid_email": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير صالح.",
    ),
    "items": MessageLookupByLibrary.simpleMessage("عناصر"),
    "joint": MessageLookupByLibrary.simpleMessage("عيادة المفاصل"),
    "json_data_copied": MessageLookupByLibrary.simpleMessage(
      "تم نسخ بيانات JSON إلى الحافظة",
    ),
    "json_format": MessageLookupByLibrary.simpleMessage("صيغة JSON"),
    "just_now": MessageLookupByLibrary.simpleMessage("الآن"),
    "landline": MessageLookupByLibrary.simpleMessage("الأرضي"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "last_login": m9,
    "last_name": MessageLookupByLibrary.simpleMessage("الاسم الأخير"),
    "last_update": MessageLookupByLibrary.simpleMessage("آخر تحديث"),
    "live_statistics": MessageLookupByLibrary.simpleMessage(
      "الإحصائيات المباشرة",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("جاري التحميل..."),
    "loading_specialities": MessageLookupByLibrary.simpleMessage(
      "تحميل التخصصات...",
    ),
    "male": MessageLookupByLibrary.simpleMessage("ذكر"),
    "manage_appointments": MessageLookupByLibrary.simpleMessage("المواعيد"),
    "manage_appointments_desc": MessageLookupByLibrary.simpleMessage(
      "عرض وإدارة جميع المواعيد",
    ),
    "manage_blood_records": MessageLookupByLibrary.simpleMessage("سجلات الدم"),
    "manage_blood_records_desc": MessageLookupByLibrary.simpleMessage(
      "إدارة سجلات بنك الدم",
    ),
    "manage_doctors": MessageLookupByLibrary.simpleMessage("إدارة الأطباء"),
    "manage_doctors_desc": MessageLookupByLibrary.simpleMessage(
      "إضافة، تعديل، أو حذف الأطباء",
    ),
    "manage_reviews": MessageLookupByLibrary.simpleMessage("التقييمات"),
    "manage_reviews_desc": MessageLookupByLibrary.simpleMessage(
      "الإشراف والرد على التقييمات",
    ),
    "manage_specialities": MessageLookupByLibrary.simpleMessage("التخصصات"),
    "manage_specialities_desc": MessageLookupByLibrary.simpleMessage(
      "إضافة أو تعديل التخصصات",
    ),
    "manage_users": MessageLookupByLibrary.simpleMessage("إدارة المستخدمين"),
    "manage_users_desc": MessageLookupByLibrary.simpleMessage(
      "عرض وإدارة حسابات المستخدمين",
    ),
    "mark_all_as_read": MessageLookupByLibrary.simpleMessage(
      "تحديد الكل كمقروء",
    ),
    "minutes_ago": m10,
    "mit_azzoun": MessageLookupByLibrary.simpleMessage(
      "ميت عزون بجوار المسجد الكبير",
    ),
    "monday": MessageLookupByLibrary.simpleMessage("الأثنين"),
    "my_appointments": MessageLookupByLibrary.simpleMessage("مواعيدي"),
    "my_favorites": MessageLookupByLibrary.simpleMessage("الأطباء المفضلون"),
    "name_must_be_3_chars": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون الاسم 3 أحرف على الأقل",
    ),
    "nephrology_urology": MessageLookupByLibrary.simpleMessage(
      "الكلى والمسالك",
    ),
    "neurology": MessageLookupByLibrary.simpleMessage("الأعصاب"),
    "new_appointment": MessageLookupByLibrary.simpleMessage("موعد جديد"),
    "new_doctor_added": MessageLookupByLibrary.simpleMessage(
      "تم إضافة طبيب جديد",
    ),
    "new_review": MessageLookupByLibrary.simpleMessage("تقييم جديد"),
    "new_review_received": MessageLookupByLibrary.simpleMessage(
      "تم استلام تقييم جديد",
    ),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noDoctorsFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على أطباء",
    ),
    "noDoctorsInCategory": MessageLookupByLibrary.simpleMessage(
      "لا يوجد أطباء متاحون حاليًا في هذا القسم.",
    ),
    "noReviewsYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد تقييمات بعد. كن أول من يشارك تجربته!",
    ),
    "no_activities_found": MessageLookupByLibrary.simpleMessage(
      "لا توجد نشاطات",
    ),
    "no_appointments": MessageLookupByLibrary.simpleMessage("لا توجد مواعيد"),
    "no_appointments_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مواعيد",
    ),
    "no_appointments_matching_filter": MessageLookupByLibrary.simpleMessage(
      "لا توجد مواعيد مطابقة للفلتر المحدد.",
    ),
    "no_appointments_subtitle": MessageLookupByLibrary.simpleMessage(
      "لم تقم بحجز أي مواعيد حتى الآن.",
    ),
    "no_blood_records": MessageLookupByLibrary.simpleMessage(
      "لا توجد سجلات دم",
    ),
    "no_blood_records_registered": MessageLookupByLibrary.simpleMessage(
      "لا توجد سجلات تبرع بالدم مسجلة حتى الآن.",
    ),
    "no_blood_types_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على فصيلة الدم 😥",
    ),
    "no_data_available": MessageLookupByLibrary.simpleMessage(
      "لا توجد بيانات متاحة",
    ),
    "no_doctors_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على أطباء",
    ),
    "no_doctors_registered": MessageLookupByLibrary.simpleMessage(
      "لا يوجد أطباء مسجلون في النظام.",
    ),
    "no_favorites": MessageLookupByLibrary.simpleMessage("لا توجد مفضلات بعد"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "لا يوجد اتصال بالإنترنت",
    ),
    "no_keep_it": MessageLookupByLibrary.simpleMessage("لا، احتفظ به"),
    "no_notifications": MessageLookupByLibrary.simpleMessage(
      "لا توجد إشعارات 🔕",
    ),
    "no_reviews": MessageLookupByLibrary.simpleMessage("لا توجد تقييمات"),
    "no_reviews_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على تقييمات",
    ),
    "no_reviews_to_display": MessageLookupByLibrary.simpleMessage(
      "لا توجد تقييمات للمرضى لعرضها حتى الآن.",
    ),
    "no_schedules_added_yet": MessageLookupByLibrary.simpleMessage(
      "لم يتم إضافة جداول بعد",
    ),
    "no_speciality_data": MessageLookupByLibrary.simpleMessage(
      "لا توجد بيانات عن التخصصات",
    ),
    "no_specialties": MessageLookupByLibrary.simpleMessage("لا توجد تخصصات"),
    "no_specialties_added": MessageLookupByLibrary.simpleMessage(
      "لم تقم بإضافة أي تخصصات سريرية حتى الآن.",
    ),
    "no_user_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مستخدم لهذا البريد الإلكتروني.",
    ),
    "no_users_found": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مستخدمين",
    ),
    "no_users_registered": MessageLookupByLibrary.simpleMessage(
      "لا يوجد مستخدمون مسجلون في النظام حتى الآن.",
    ),
    "notWorking": MessageLookupByLibrary.simpleMessage("لا يعمل"),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "nutrition_therapy": MessageLookupByLibrary.simpleMessage(
      "التغذية العلاجية",
    ),
    "obgyn": MessageLookupByLibrary.simpleMessage("النساء والتوليد"),
    "of_medical_specialists": MessageLookupByLibrary.simpleMessage(
      "من التخصصات الطبية لاحتياجاتك الصحية",
    ),
    "on_specific_days": MessageLookupByLibrary.simpleMessage(
      "في أيام معينة لتخطيط زيارتك بسهولة",
    ),
    "online": MessageLookupByLibrary.simpleMessage("متصل"),
    "ophthalmology": MessageLookupByLibrary.simpleMessage("العيون"),
    "ourDoctors": MessageLookupByLibrary.simpleMessage("أطباؤنا"),
    "overview": MessageLookupByLibrary.simpleMessage("نظرة عامة"),
    "overview_statistics": MessageLookupByLibrary.simpleMessage(
      "إحصائيات عامة",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "patient": m11,
    "patientReviews": MessageLookupByLibrary.simpleMessage("تقييمات المرضى"),
    "patient_booked_with": m12,
    "patient_information": MessageLookupByLibrary.simpleMessage(
      "معلومات المريض",
    ),
    "patient_reviews": MessageLookupByLibrary.simpleMessage("تقييمات المرضى"),
    "pediatrics": MessageLookupByLibrary.simpleMessage("الأطفال"),
    "pending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "pending_appointments": MessageLookupByLibrary.simpleMessage("المواعيد"),
    "personal_information": MessageLookupByLibrary.simpleMessage(
      "المعلومات الشخصية",
    ),
    "phone": MessageLookupByLibrary.simpleMessage("التليفون"),
    "phone_number": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "please_enter_patient_name": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال اسم المريض",
    ),
    "please_enter_phone_number": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال رقم الهاتف",
    ),
    "please_enter_valid_phone": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال رقم هاتف صحيح",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("الصفحة الشخصية"),
    "profile_image_url": MessageLookupByLibrary.simpleMessage(
      "رابط صورة الملف الشخصي",
    ),
    "quick_actions": MessageLookupByLibrary.simpleMessage("إجراءات سريعة"),
    "rate_and_review": MessageLookupByLibrary.simpleMessage("تقييم ومراجعة"),
    "rate_your_experience": MessageLookupByLibrary.simpleMessage("قيم تجربتك"),
    "rating": MessageLookupByLibrary.simpleMessage("التقييم"),
    "recent_activity": MessageLookupByLibrary.simpleMessage("النشاطات الأخيرة"),
    "recently": MessageLookupByLibrary.simpleMessage("مؤخراً"),
    "remove_from_favorites": MessageLookupByLibrary.simpleMessage(
      "إزالة من المفضلة",
    ),
    "requested_info_not_found": MessageLookupByLibrary.simpleMessage(
      "المعلومات المطلوبة غير موجودة",
    ),
    "required": MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
    "reserved_on": m13,
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "review_for_doctor": m14,
    "review_submitted_successfully": MessageLookupByLibrary.simpleMessage(
      "تم إرسال التقييم بنجاح!",
    ),
    "reviews": MessageLookupByLibrary.simpleMessage("تقييمات"),
    "rheumatology_joint": MessageLookupByLibrary.simpleMessage(
      "المفاصل والرماتيزم",
    ),
    "role_updated_successfully": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الدور بنجاح",
    ),
    "saturday": MessageLookupByLibrary.simpleMessage("السبت"),
    "save": MessageLookupByLibrary.simpleMessage("حفظ"),
    "save_changes": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
    "saving": MessageLookupByLibrary.simpleMessage("جاري الحفظ..."),
    "search_activities": MessageLookupByLibrary.simpleMessage(
      "البحث في النشاطات...",
    ),
    "select_appointment_date": MessageLookupByLibrary.simpleMessage(
      "اختر تاريخ الموعد",
    ),
    "select_appointment_time": MessageLookupByLibrary.simpleMessage(
      "اختر وقت الموعد",
    ),
    "select_day": MessageLookupByLibrary.simpleMessage("اختر اليوم"),
    "select_export_format": MessageLookupByLibrary.simpleMessage(
      "اختر صيغة التصدير:",
    ),
    "select_photo_source": MessageLookupByLibrary.simpleMessage(
      "اختر مصدر الصورة",
    ),
    "select_specialization": MessageLookupByLibrary.simpleMessage(
      "اختر التخصص",
    ),
    "selected_date": MessageLookupByLibrary.simpleMessage("التاريخ المحدد"),
    "selected_time": MessageLookupByLibrary.simpleMessage("الوقت المحدد"),
    "send_reset_password_link": MessageLookupByLibrary.simpleMessage(
      "إرسال رابط إعادة تعيين كلمة المرور",
    ),
    "server_status": MessageLookupByLibrary.simpleMessage("حالة الخادم"),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "share_your_thoughts": MessageLookupByLibrary.simpleMessage(
      "شارك بأفكارك...",
    ),
    "sign_in": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "sign_out": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "sign_up": MessageLookupByLibrary.simpleMessage("التسجيل"),
    "signed_out_successfully": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الخروج بنجاح",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "specialistPractitioner": MessageLookupByLibrary.simpleMessage(
      "اخصائي ممارس",
    ),
    "specialities": MessageLookupByLibrary.simpleMessage("تخصصات"),
    "speciality_added_successfully": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة التخصص بنجاح",
    ),
    "speciality_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "تم حذف التخصص بنجاح",
    ),
    "specialization": MessageLookupByLibrary.simpleMessage("التخصص"),
    "specialties": MessageLookupByLibrary.simpleMessage("التخصصات"),
    "specialty": MessageLookupByLibrary.simpleMessage("التخصص"),
    "speech_behavior_modification": MessageLookupByLibrary.simpleMessage(
      "تخاطب وتعديل السلوك",
    ),
    "start_adding_favorites": MessageLookupByLibrary.simpleMessage(
      "اضغط على أيقونة القلب على أي بطاقة طبيب لإضافتها إلى المفضلة",
    ),
    "start_time": MessageLookupByLibrary.simpleMessage("وقت البدء"),
    "status_updated_to": m15,
    "street": MessageLookupByLibrary.simpleMessage(
      "شارع الميزانيه بجوار صيدلية الدكتور عبدالله صالح.",
    ),
    "submit_review": MessageLookupByLibrary.simpleMessage("إرسال التقييم"),
    "subtitle": MessageLookupByLibrary.simpleMessage(
      "نتمنى لك الصحة والسعادة ❤️",
    ),
    "success": MessageLookupByLibrary.simpleMessage(
      "نجاح، تحقق من بريدك الإلكتروني للتحقق من حسابك",
    ),
    "sunday": MessageLookupByLibrary.simpleMessage("الأحد"),
    "system_management": MessageLookupByLibrary.simpleMessage("إدارة النظام"),
    "system_operating_normally": MessageLookupByLibrary.simpleMessage(
      "النظام يعمل بشكل طبيعي",
    ),
    "system_status": MessageLookupByLibrary.simpleMessage("حالة النظام"),
    "tap_to_change_photo": MessageLookupByLibrary.simpleMessage(
      "اضغط لتغيير الصورة",
    ),
    "thursday": MessageLookupByLibrary.simpleMessage("الخميس"),
    "ticket_price": MessageLookupByLibrary.simpleMessage("سعر الكشف"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "today_appointments": MessageLookupByLibrary.simpleMessage("اليوم"),
    "top_doctors": MessageLookupByLibrary.simpleMessage("أفضل الأطباء"),
    "top_specialities": MessageLookupByLibrary.simpleMessage("أفضل التخصصات"),
    "totalCharges": MessageLookupByLibrary.simpleMessage("إجمالي الرسوم"),
    "total_appointments": MessageLookupByLibrary.simpleMessage(
      "إجمالي المواعيد",
    ),
    "total_doctors": MessageLookupByLibrary.simpleMessage("إجمالي الأطباء"),
    "total_users": MessageLookupByLibrary.simpleMessage("إجمالي المستخدمين"),
    "tuesday": MessageLookupByLibrary.simpleMessage("الثلاثاء"),
    "unauthorized": MessageLookupByLibrary.simpleMessage("غير مصرح به"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "upload_image": MessageLookupByLibrary.simpleMessage("رفع صورة"),
    "user_deleted_successfully": MessageLookupByLibrary.simpleMessage(
      "تم حذف المستخدم بنجاح",
    ),
    "user_not_found": MessageLookupByLibrary.simpleMessage(
      "المستخدم غير موجود",
    ),
    "users": MessageLookupByLibrary.simpleMessage("المستخدمون"),
    "verified": MessageLookupByLibrary.simpleMessage("موثق"),
    "verify": MessageLookupByLibrary.simpleMessage(
      "من فضلك، قم بالتحقق من حسابك!",
    ),
    "view_all": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "weak_password": MessageLookupByLibrary.simpleMessage("كلمة المرور ضعيفة."),
    "wednesday": MessageLookupByLibrary.simpleMessage("الأربعاء"),
    "welcome": MessageLookupByLibrary.simpleMessage("مرحبًا"),
    "welcome_back": MessageLookupByLibrary.simpleMessage("مرحبًا مرة أخرى!"),
    "welcome_back_admin": MessageLookupByLibrary.simpleMessage(
      "مرحباً بعودتك، أيها المسؤول!",
    ),
    "with_dr_specialty": m16,
    "workingDays": MessageLookupByLibrary.simpleMessage("أيام العمل"),
    "working_hours": MessageLookupByLibrary.simpleMessage("ساعات العمل"),
    "wrong_password": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور غير صحيحة.",
    ),
    "years": MessageLookupByLibrary.simpleMessage("سنوات"),
    "yes_cancel": MessageLookupByLibrary.simpleMessage("نعم، إلغاء"),
  };
}
