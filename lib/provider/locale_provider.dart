import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('en'); // Default to English

  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == 'en') {
      _locale = Locale('es'); // Switch to Spanish
    } else {
      _locale = Locale('en'); // Switch back to English
    }
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
