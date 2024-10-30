import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Finabook',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Finabook is a comprehensive platform designed to bring a rich selection of literature to readers worldwide. Our mission is to make reading accessible, engaging, and convenient, empowering people through knowledge and stories.',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Lecturer',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://media.licdn.com/dms/image/D5603AQFv64ZHa565yg/profile-displayphoto-shrink_200_200/0/1694137148713?e=2147483647&v=beta&t=56K9-MDfBA7yDPSo8Dud_9xXv0hhRKdGujXvUerdam8',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                      Text(
                        'Oum Saokosal',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Our Team',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: teamMembers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          member['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.grey[300],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        member['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> teamMembers = [
  {
    'name': 'Rado No',
    'image': 'assets/images/rado.jpg',
  },
  {
    'name': 'Sreng Visal',
    'image': 'assets/images/visal.jpg',
  },
  {
    'name': 'Keo Kamuth',
    'image': 'assets/images/muth.jpg',
  },
  {
    'name': 'Sean Silvano',
    'image': 'assets/images/sean.jpg',
  },
];
