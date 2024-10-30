import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    ScreenData('Home', Icons.home, const HomePage()),
    ScreenData('Books', Icons.book,  BookScreen()),
    ScreenData('Settings', Icons.settings, const  SettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                _screens[_selectedIndex].title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: innerBoxIsScrolled ? Colors.yellowAccent : Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.notifications),
                ),
              ],
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: _screens[_selectedIndex].widget,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.yellowAccent.withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
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
          indicatorColor: Colors.yellowAccent.withOpacity(0.2),
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
                    label: screen.title,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ScreenData {
  final String title;
  final IconData icon;
  final Widget widget;

  ScreenData(this.title, this.icon, this.widget);
}
