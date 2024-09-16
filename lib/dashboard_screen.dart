import 'package:flutter/material.dart';
import 'package:flutter_theme_and_localization/language.dart';
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
        title: Text('Welcome to My App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.light
                ? Icons.brightness_6
                : Icons.brightness_7),
            onPressed: () {
              themeProvider.toggleTheme(); // Toggle theme using provider
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.language),
          //   onPressed: () {
          //     localeProvider.toggleLocale(); // Toggle language using provider
          //   },
          // ),
          Container(
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(Icons.language),
              onChanged: (bool){},
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Good Morning, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Today\'s Date: ${DateFormat.yMMMd().format(DateTime.now())}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildFeatureCard('Theme Switcher', Icons.brightness_6),
                _buildFeatureCard('Language', Icons.language),
                _buildFeatureCard('Profile', Icons.person),
                _buildFeatureCard('App Info', Icons.info),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
        currentIndex: 0,
        onTap: (index) {
          // Handle tab navigation
        },
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
