import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/books_model.dart';

class BookDetailScreen extends StatelessWidget {
  final Result book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCoverImage(),
            _buildInfoSection(),
            // _buildDescriptionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(book.formats.imageJpeg ?? ''),
          fit: BoxFit.cover,
        ),
      ),
      child: book.formats.imageJpeg == null
          ? const Center(child: Icon(Icons.book, size: 100, color: Colors.grey))
          : null,
    );
  }

  // Info Section with title, author, and download count
  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book.title,
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            book.authors.isNotEmpty
                ? book.authors.map((a) => a.name).join(', ')
                : 'Unknown Author',
            style: GoogleFonts.lato(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.download, color: Colors.blueGrey),
              const SizedBox(width: 8),
              Text(
                'Downloads: ${book.downloadCount}',
                style: GoogleFonts.lato(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // // Description Section
  // Widget _buildDescriptionSection() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Description',
  //           style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(height: 8),
         
  //       ],
  //     ),
  //   );
  // }
}
