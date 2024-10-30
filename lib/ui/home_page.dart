import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.label),
            title: Text(
              'Home - Item ${index + 1}',
              style: GoogleFonts.lato(),
            ),
            subtitle: Text(
              'This is some more detailed text for item ${index + 1}.',
              style: GoogleFonts.lato(),
            ),
          ),
        );
      },
    );
  }
}
