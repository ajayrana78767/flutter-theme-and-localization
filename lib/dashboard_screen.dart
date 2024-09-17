// ignore_for_file: unnecessary_const, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_theme_and_localization/language.dart';
import 'package:flutter_theme_and_localization/languages_constant.dart';
import 'package:flutter_theme_and_localization/main.dart';
import 'package:flutter_theme_and_localization/provider/locale_provider.dart';
import 'package:flutter_theme_and_localization/provider/theme_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).welcome_message,
        ),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Icon(
                themeProvider.themeMode == ThemeMode.light
                    ? Icons.brightness_6
                    : Icons.brightness_7,
                key: ValueKey(themeProvider.themeMode),
              ),
            ),
            onPressed: () {
              themeProvider.toggleTheme();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translation(context).theme_changed),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          PopupMenuButton<Language>(
            icon: const Icon(Icons.language),
            onSelected: (Language? language) async {
              if (language != null) {
                Locale _locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, _locale);
              }
            },
            itemBuilder: (context) {
              return Language.languageList().map((Language e) {
                return PopupMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(e.flag, style: const TextStyle(fontSize: 30)),
                      Text(e.name),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              translation(context).good_morning,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            translation(context)
                .todays_date(DateFormat.yMMMd().format(DateTime.now())),
            // 'Today\'s Date: ${DateFormat.yMMMd().format(DateTime.now())}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildFeatureCard(translation(context).theme_switcher,
                    Icons.brightness_6, context),
                _buildFeatureCard(
                    translation(context).language, Icons.language, context),
                _buildFeatureCard(
                    translation(context).profile, Icons.person, context),
                _buildFeatureCard(
                    translation(context).app_info, Icons.info, context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return BottomNavigationBar(
            currentIndex: 0, // You can manage the index state to switch tabs.
            type: BottomNavigationBarType.fixed,
            backgroundColor: themeProvider.themeMode == ThemeMode.light
                ? Colors.white
                : Colors.black, // Background adapts to theme.
            selectedItemColor: themeProvider.themeMode == ThemeMode.light
                ? Colors.blue // Select color for light theme
                : Colors.purpleAccent, // Select color for dark theme
            unselectedItemColor: themeProvider.themeMode == ThemeMode.light
                ? Colors.grey // Unselected color for light theme
                : Colors.grey.shade600, // Unselected color for dark theme
            elevation: 8.0, // Adds a bit of depth.
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.help),
                label: 'Help',
              ),
            ],
            onTap: (index) {
              // Handle tab navigation and state update logic here.
            },
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Define light and dark mode gradients
    final lightGradient = LinearGradient(
      colors: [Colors.blue.shade200, Colors.purple.shade200],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final darkGradient = LinearGradient(
      colors: [Colors.grey.shade900, Colors.black],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Choose gradient based on the current theme
    final currentGradient = themeProvider.themeMode == ThemeMode.light
        ? lightGradient
        : darkGradient;

    return GestureDetector(
      onTap: () {
        // Add a meaningful action or transition
      },
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:
                currentGradient, // Use the current gradient based on the theme
            boxShadow: [
              BoxShadow(
                color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.grey.shade300
                    : Colors.black54,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: themeProvider.themeMode == ThemeMode.light
                    ? Colors.white
                    : Colors.black,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
