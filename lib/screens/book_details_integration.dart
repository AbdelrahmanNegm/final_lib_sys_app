import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_app/screens/book_model.dart';

class BookDetailsIntegration extends StatefulWidget {
  final int bookId;
  final Book? book;

  const BookDetailsIntegration({
    super.key,
    required this.bookId,
    this.book,
  });

  @override
  State<BookDetailsIntegration> createState() => _BookDetailsIntegrationState();
}

class _BookDetailsIntegrationState extends State<BookDetailsIntegration> {
  bool isBookMarked = false;
  Map<String, dynamic>? bookData;
  bool isLoading = true;
  bool isRequested = false;

  @override
  void initState() {
    super.initState();
    fetchBookDetails();
  }

  Future<void> fetchBookDetails() async {
    final url = 'https://fci-library.me/api/book/${widget.bookId}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          bookData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load book details');
      }
    } catch (e) {
      print('Error fetching book details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> borrowBook() async {
    const url = 'https://fci-library.me/api/borrow/request';

    final dueDate = DateTime.now().add(const Duration(days: 7));
    final formattedDate = dueDate.toIso8601String();

    final payload = jsonEncode({
      "userId": 2,
      "bookId": widget.bookId,
      "dueDate": formattedDate,
    });
    print('borrowBook called!');

    print("Sending request with: $payload");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: payload,
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          isRequested = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تمت العملية بنجاح ✅")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("فشلت العملية: ${response.body}")),
        );
      }
    } catch (e) {
      print("Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حصل استثناء: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFBEECB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2DEB3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookData == null
              ? const Center(child: Text("Error loading book details"))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;

                    return SingleChildScrollView(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: const Color(0xFFF2DEB3), // اللون العلوي
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                child: Column(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.4,
                                      height: screenWidth * 0.6,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: bookData!["image"] != null
                                            ? _buildBookImage(
                                                bookData!["image"])
                                            : null,
                                      ),
                                    ),
                                    // SizedBox(height: screenWidth * 0.04),
                                    // Text(
                                    //   bookData!["isAvailable"] == true
                                    //       ? "Available"
                                    //       : "Not Available",
                                    //   style: TextStyle(
                                    //     color: bookData!["isAvailable"] == true
                                    //         ? Colors.green
                                    //         : Colors.red,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    SizedBox(height: screenWidth * 0.04),
                                    Text(
                                      bookData!["name"] ?? "Unknown Title",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenWidth * 0.02),
                                    Text(
                                      "By ${bookData!["authorNames"] ?? "Unknown"}",
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                    SizedBox(height: screenWidth * 0.04),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildMetadataItem(
                                          'Shelf',
                                          bookData!["shelf"] ?? "N/A",
                                          screenWidth,
                                          const Color(0xFFE0C496),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),

                              // الخط الرمادي بين الجزءين
                              // Container(
                              //   width: double.infinity,
                              //   height: 1,
                              //   color: Colors.grey[300],
                              // ),
                              Container(
                                width: double.infinity,
                                height: 2,
                                color: Colors.grey[300],
                              ),
                              Container(
                                height: screenWidth * 1,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFFBEECB)),
                              )
                            ],
                          ),

                          // الزر في المنتصف باستخدام Stack
                          Positioned(
                            top: screenWidth * 1.2,
                            left: screenWidth * 0.2,
                            right: screenWidth * 0.2,
                            child: IgnorePointer(
                              ignoring:
                                  isLoading, // تجاهل اللمس فقط لما البيانات لسه بتحميل
                              child: AnimatedOpacity(
                                opacity: isLoading ? 0.0 : 1.0,
                                duration: const Duration(milliseconds: 500),
                                child: GestureDetector(
                                  onTap: () {
                                    print("isLoading: $isLoading");

                                    print("Button tapped");
                                    print("isRequested: $isRequested");
                                    print(
                                        "isAvailable: ${bookData!["isAvailable"]}");

                                    if (!isRequested &&
                                        bookData!["isAvailable"] == true) {
                                      print("Calling borrowBook()");
                                      borrowBook();
                                    } else {
                                      print("Borrow conditions not met.");
                                    }
                                  },
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            endIndent: 10,
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth *
                                              0.6, // قلل العرض شوية علشان يبان الخطين
                                          height: screenWidth * 0.18,
                                          decoration: BoxDecoration(
                                            color: isRequested
                                                ? Colors.green
                                                : const Color(0xFFD8A353),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            border: Border.all(
                                              color: const Color(0xFFFFF8E0),
                                              width: 9.0,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isRequested
                                                  ? "Requested"
                                                  : "Borrow Now",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.045,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 10,
                                            indent: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   height: screenWidth * .01,
                                  //   decoration:
                                  //       BoxDecoration(color: Colors.grey),
                                  // )
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(color: Color(0xFFFF)),
                          // ),
                          Positioned(
                              top: screenWidth * 0.0,
                              right: screenWidth * 0.4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFBEECB),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    bookData!["isAvailable"] == true
                                        ? "Available"
                                        : "Not Available",
                                    style: TextStyle(
                                      color: bookData!["isAvailable"] == true
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  DecorationImage? _buildBookImage(String base64String) {
    try {
      return DecorationImage(
        image: MemoryImage(base64Decode(base64String)),
        fit: BoxFit.cover,
      );
    } catch (e) {
      print('Error decoding image: $e');
      return null;
    }
  }
}

Widget _buildMetadataItem(
    String label, String value, double screenWidth, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
    child: Container(
      width: screenWidth * 0.30,
      height: screenWidth * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(label,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.03)),
              const SizedBox(width: 2),
              const VerticalDivider(
                width: 8, // المسافة الأفقية التي يأخذها
                thickness: 1, // سُمك الخط
                color: Colors.black,
                indent: 10, // المسافة من الأعلى
                endIndent: 10, // المسافة من الأسفل
              ),
              Text(value,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035)),
            ],
          ),
        ),
      ),
    ),
  );
}
