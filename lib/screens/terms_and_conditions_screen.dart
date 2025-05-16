import 'package:flutter/material.dart';

import '../constants.dart';

class LibraryTermsScreen extends StatefulWidget {
  const LibraryTermsScreen({super.key});

  @override
  State<LibraryTermsScreen> createState() => _LibraryTermsScreenState();
}

class _LibraryTermsScreenState extends State<LibraryTermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbeecb),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbeecb),
        centerTitle: true,
        title: const Text(
          "Library Borrowing Terms and Conditions",
          style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFb28f63),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader("1. Borrowing Period:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Books may be borrowed for a maximum period of "),
                    TextSpan(
                      text: "7 days ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(text: "If you need more time, you may "),
                    TextSpan(
                      text: "renew the borrowing period ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(
                        text: "before the due date, subject to availability."),
                  ],
                ),
              ),
              const _SectionHeader("2. Late Returns and Penalties:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Failure to return a book by the due date set by the librarian will result in "),
                    TextSpan(
                      text: "disciplinary action ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(text: "by the college."),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- A fine may be imposed for overdue books, and repeated late returns may result in the suspension of borrowing privileges."),
                  ],
                ),
              ),
              const _SectionHeader("3. Renewal Policy:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: "- Borrowers may "),
                    TextSpan(
                      text: "renew a book only once",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(
                        text: ", provided no other user has requested it."),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Renewal must be done before the due date to avoid penalties."),
                  ],
                ),
              ),
              const _SectionHeader("4. Borrowing Limit:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: "- Each user may borrow up to "),
                    TextSpan(
                      text: "3 books at a time",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Certain high-demand books may have additional restrictions on borrowing duration."),
                  ],
                ),
              ),
              const _SectionHeader("5. Book Condition and Responsibility:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: "- Borrowers must return books in "),
                    TextSpan(
                      text: "the same condition ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(text: "as they were issued."),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Any damage or loss of a borrowed book will result in a "),
                    TextSpan(
                      text: "replacement fee or repair charges ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                    TextSpan(text: ", as determined by the library."),
                  ],
                ),
              ),
              const _SectionHeader("6. Restricted Books:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: "- Some books may only be used "),
                    TextSpan(
                      text: "within the library premises",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- These books must be returned to the designated section before leaving the library."),
                  ],
                ),
              ),
              const _SectionHeader("7. User Account Suspension:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- If a user fails to comply with library rules, their borrowing privileges may be "),
                    TextSpan(
                      text: "temporarily or permanently revoked",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Any unresolved fines or overdue books must be cleared before borrowing new materials."),
                  ],
                ),
              ),
              const _SectionHeader("8. Library Conduct:"),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: "- Users must maintain a "),
                    TextSpan(
                      text: "quiet and respectful environment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFb28f63)),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            "- Misuse of library resources, including unauthorized removal of books, may lead to disciplinary actions."),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "By borrowing a book, you agree to abide by these terms and conditions. Failure to comply may result in penalties or loss of library privileges. If you have any questions, please contact the librarian for assistance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF332417)),
      ),
    );
  }
}
