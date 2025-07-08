import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  List<String> results = [];
  bool isLoading = false;

  Future<List<String>> searchFromApi(String query) async {
    final url = Uri.parse('http://192.168.1.5:3000/api/search/home/$query'); // ✏️ غيّر IP و Port حسب حالتك

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // عدل هذا حسب شكل استجابتك
      return List<String>.from(data['results'] ?? []);
    } else {
      throw Exception('فشل في جلب البيانات');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Stack(
          children: [
            // Top bar
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 390,
                height: 44,
                decoration: const BoxDecoration(),
              ),
            ),

            // Search bar
            Positioned(
              left: 24,
              top: 68,
              right: 24,
              child: Row(
                children: [
                  // Input field
                  Expanded(
                    child: Container(
                      height: 51,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEBF3F1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            color: Color(0xFF98A09C),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Search icon
                  Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Color(0xFF147351),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () async {
                        if (searchText.trim().isEmpty) return;
                        setState(() => isLoading = true);

                        try {
                          final data = await searchFromApi(searchText);
                          setState(() {
                            results = data;
                            isLoading = false;
                          });
                        } catch (e) {
                          debugPrint('Error: $e');
                          setState(() {
                            results = [];
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Search results
            Positioned(
              top: 140,
              left: 24,
              right: 24,
              bottom: 0,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : results.isEmpty
                  ? const Center(
                child: Text(
                  'no results',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(results[index]),
                  leading: const Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
