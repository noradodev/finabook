import 'package:fina_exam/widgets/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'async_module/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await EasyLocalization.ensureInitialized(); // Initialize localization

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('km')], // Supported languages
        path: 'assets/translations', // Path to your translation files
        fallbackLocale: Locale('en'), // Fallback language
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Your App Name',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(), // Set the dark theme
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Switch theme based on preference
      home: const HomeScreen(),
      localizationsDelegates: context.localizationDelegates, // Add localization delegates
      supportedLocales: context.supportedLocales, // Supported locales
      locale: context.locale, // Current locale
    );
  }
}
