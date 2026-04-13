// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Notes Sécurisées';

  @override
  String get addNote => 'Nouvelle Note';

  @override
  String get save => 'Enregistrer';

  @override
  String get titleHint => 'Titre';

  @override
  String get descriptionHint => 'Commencez à écrire...';

  @override
  String get noNotes => 'Aucune note pour le moment';

  @override
  String get titleRequired => 'Le titre est requis';

  @override
  String get descriptionRequired => 'La description est requise';

  @override
  String get unlockApp => 'Déverrouiller l\'application';

  @override
  String get useFingerprint =>
      'Utilisez votre empreinte digitale pour continuer';

  @override
  String get scan => 'Scanner';

  @override
  String get authRequired =>
      'L\'authentification est requise pour accéder à l\'application';

  @override
  String get scanFingerprintReason => 'Scannez votre empreinte';
}
