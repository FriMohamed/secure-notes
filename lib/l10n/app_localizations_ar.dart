// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ملاحظات آمنة';

  @override
  String get addNote => 'ملاحظة جديدة';

  @override
  String get save => 'حفظ';

  @override
  String get titleHint => 'العنوان';

  @override
  String get descriptionHint => 'ابدأ الكتابة...';

  @override
  String get noNotes => 'لا توجد ملاحظات بعد';

  @override
  String get titleRequired => 'العنوان مطلوب';

  @override
  String get descriptionRequired => 'الوصف مطلوب';

  @override
  String get unlockApp => 'فتح التطبيق';

  @override
  String get useFingerprint => 'استخدم بصمتك للمتابعة';

  @override
  String get scan => 'مسح';

  @override
  String get authRequired => 'المصادقة مطلوبة للوصول إلى التطبيق';

  @override
  String get scanFingerprintReason => 'قم بمسح بصمتك';
}
