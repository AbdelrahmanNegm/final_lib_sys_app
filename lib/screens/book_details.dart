import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});
  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  bool isBookMarked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFBEECB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.brown,
              ),
              onPressed: () {
                setState(() {
                  isBookMarked = !isBookMarked;
                });
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth * 0.4,
                            height: screenWidth * 0.6,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('resources/images/book.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'Available',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Text(
                            'Principles of Digital Signal Processing',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'By Sankaran Palani',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildMetadataItem('Shelf', 'A-4b', screenWidth),
                              _buildMetadataItem('Pages', '700', screenWidth),
                              _buildMetadataItem(
                                  'Language', 'English', screenWidth),
                            ],
                          ),
                          SizedBox(height: screenWidth * 0.06),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD8A353),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Borrow Now',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.08),
                    Text(
                      "What's it about?",
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "This book provides a comprehensive introduction to all major topics in digital signal processing (DSP)...",
                      style: TextStyle(
                          fontSize: screenWidth * 0.035, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildMetadataItem(String label, String value, double screenWidth) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
    child: Container(
      width: screenWidth * 0.25,
      height: screenWidth * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFD8A353),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontSize: screenWidth * 0.03),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035),
            ),
          ],
        ),
      ),
    ),
  );
}
