import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/books_model.dart';
import '../async_module/book_service.dart';
import 'book_detail_screen.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late Future<List<Result>>
      _futureBooks; 
  bool _isInternetAvailable = true;
  List<Result> _allBooks = []; 
  List<Result> _displayedBooks = []; 

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _loadCachedBooks();
    _futureBooks = Future.value([]);
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _isInternetAvailable = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _loadCachedBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_books');
    if (cachedData != null) {
      final List<dynamic> decodedData = jsonDecode(cachedData);
      final cachedBooks =
          decodedData.map((json) => Result.fromJson(json)).toList();
      setState(() {
        _allBooks = cachedBooks;
        _displayedBooks = _allBooks;
        _futureBooks = Future.value(_allBooks);
      });
    } else {
      _futureBooks = Future.value([]);
    }
    if (_isInternetAvailable) {
      _fetchBooks();
    }
  }

  Future<void> _fetchBooks() async {
    _futureBooks = BookService().fetchBooks();
    _futureBooks.then((fetchedBooks) async {
      setState(() {
        _allBooks = fetchedBooks;
        _displayedBooks = _allBooks;
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('cached_books',
          jsonEncode(fetchedBooks.map((book) => book.toJson()).toList()));
    }).catchError((error) {});
  }

  void _refresh() {
    _checkInternetConnection();
    if (_isInternetAvailable) {
      _fetchBooks();
    } else {
      setState(() {});
    }
  }

  void _searchBooks(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedBooks = _allBooks;
      } else {
        _displayedBooks = _allBooks
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()) ||
                book.authors.any((author) =>
                    author.name.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gutenberg Books',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search books...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _searchBooks,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Result>>(
              future: _isInternetAvailable ? _futureBooks : Future.value([]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return _buildErrorScreen(snapshot.error);
                } else if (_displayedBooks.isEmpty) {
                  return const Center(child: Text('No books found.'));
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _displayedBooks.length,
                    itemBuilder: (context, index) {
                      final book = _displayedBooks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: book),
                            ),
                          );
                        },
                        child: _buildBookCard(book),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorScreen(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $error',
            style: GoogleFonts.lato(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 20),
          Text(
            _isInternetAvailable
                ? 'Something went wrong. Please try again.'
                : 'No internet connection. Please check your settings.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _refresh,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Result book) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: book.formats.imageJpeg != null
                ? ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      book.formats.imageJpeg,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.book, size: 80, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              book.authors.isNotEmpty
                  ? book.authors.map((a) => a.name).join(', ')
                  : 'Unknown Author',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Downloads: ${book.downloadCount}',
                  style:
                      GoogleFonts.lato(fontSize: 12, color: Colors.grey[700]),
                ),
                const Icon(Icons.download, color: Colors.blueGrey, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
