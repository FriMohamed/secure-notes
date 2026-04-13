// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Secure Notes';

  @override
  String get addNote => 'New Note';

  @override
  String get save => 'Save';

  @override
  String get titleHint => 'Title';

  @override
  String get descriptionHint => 'Start typing...';

  @override
  String get noNotes => 'No notes yet';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get descriptionRequired => 'Description is required';

  @override
  String get unlockApp => 'Unlock App';

  @override
  String get useFingerprint => 'Use your fingerprint to continue';

  @override
  String get scan => 'Scan';

  @override
  String get authRequired => 'Authentication is required to access the app';

  @override
  String get scanFingerprintReason => 'Scan your fingerprint';
}
