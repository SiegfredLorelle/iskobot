import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iskobot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Darker background
      appBar: AppBar(
        backgroundColor: Colors.black87, // Darker AppBar
        title: const Text(
          'Iskobot',
          style: TextStyle(
              color: Colors.white), // Set the AppBar title text color to white
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, How may I help you today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .white, // Ensure text is visible on dark background
                    ),
                  ),
                  const SizedBox(height: 10), // Spacing between text and cards
                  const Text(
                    'Sample Inquiries',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color:
                          Colors.white70, // Slightly dimmed white for contrast
                    ),
                  ),
                  const SizedBox(height: 10), // Spacing between text and cards
                  SizedBox(
                    height: 100, // Fixed height for the scrollable area
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 150, // Adjust width as needed
                            height: 80, // Adjust height as needed
                            child: const InquiryCard(
                              text: 'Ask for the current school year schedule',
                            ),
                          ),
                          SizedBox(width: 5), // Spacer between items
                          Container(
                            width: 150, // Adjust width as needed
                            height: 80, // Adjust height as needed
                            child: const InquiryCard(
                              text:
                                  'Ask for learning materials on Operating System',
                            ),
                          ),
                          SizedBox(width: 5), // Spacer between items
                          Container(
                            width: 150, // Adjust width as needed
                            height: 80, // Adjust height as needed
                            child: const InquiryCard(
                              text: 'Ask for course advice',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade800,
                hintText: 'Type your message...',
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class InquiryCard extends StatelessWidget {
  final String text;

  const InquiryCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
