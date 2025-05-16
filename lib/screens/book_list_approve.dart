import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BookListApproveScreen extends StatefulWidget {
  const BookListApproveScreen({super.key});

  @override
  _BookListApproveScreenState createState() => _BookListApproveScreenState();
}

class _BookListApproveScreenState extends State<BookListApproveScreen> {
  List<dynamic> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      var response =
          await Dio().get('https://fci-library.me/api/Borrow/pending');
      if (response.statusCode == 200) {
        setState(() {
          requests = response.data;
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching requests: $e');
    }
  }

  Future<void> approveRequest(int borrowId) async {
    try {
      print("Approving borrow ID: $borrowId");
      var response = await Dio().post(
        'https://fci-library.me/api/Borrow/approve/$borrowId',
        data: {}, // مهم لبعض السيرفرات
      );
      if (response.statusCode == 200) {
        print('Request Approved');
        fetchRequests(); // نرجع نجيب البيانات بعد التحديث
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error approving request: $e');
    }
  }

  Future<void> denyRequest(int borrowId) async {
    try {
      print("Denying borrow ID: $borrowId");
      var response = await Dio().post(
        'https://fci-library.me/api/Borrow/deny/$borrowId',
        data: {},
      );
      if (response.statusCode == 200) {
        print('Request Denied');
        fetchRequests();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error denying request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E0),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.notifications_on),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFF8E0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: const Color(0xFFE0C496),
                  filled: true,
                  hintText: "Search Titles, Authors, or Topics",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("filter with"),
                Icon(Icons.filter_alt_sharp),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: const Radius.circular(10),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          var request = requests[index];
                          var bookTitle = request["bookTitle"] ?? "Unknown";
                          var borrowId = request["id"] ?? -1;

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2DEB3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.brown,
                                              child: Text("S"),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Student name: Static User"),
                                                Text("Department: Static Dept"),
                                                Text("ID: 123456"),
                                                Text("Academic Year: 3"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(color: Color(0xFF332417)),
                                        Row(
                                          children: [
                                            Text(
                                              bookTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 600,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xffB28F63),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            approveRequest(borrowId);
                                          },
                                          child: const Text("Approve",
                                              style: TextStyle(
                                                  color: Color(0xff332417))),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            denyRequest(borrowId);
                                          },
                                          child: const Text("Deny",
                                              style: TextStyle(
                                                  color: Color(0xff332417))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
