import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart'; 
import '../ui/home_page.dart';
import '../ui/books_page.dart';
import '../ui/setting_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<ScreenData> _screens = [
    ScreenData('home', Icons.home, const HomePage()), // Use localization keys
    ScreenData('books', Icons.book, BookScreen()),
    ScreenData('settings', Icons.settings, const SettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[_selectedIndex].titleKey.tr(), // Translate the title
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: _screens[_selectedIndex].widget,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.yellowAccent.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 150, 135, 1),
              );
            }
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 56, 58, 46),
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: _screens
              .map((screen) => NavigationDestination(
                    selectedIcon: Icon(
                      screen.icon,
                      color: const Color.fromARGB(255, 187, 168, 0),
                    ),
                    icon: Icon(screen.icon),
                    label: screen.titleKey.tr(), // Translate the label
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ScreenData {
  final String titleKey; // Change title to titleKey for localization
  final IconData icon;
  final Widget widget;

  ScreenData(this.titleKey, this.icon, this.widget);
}
