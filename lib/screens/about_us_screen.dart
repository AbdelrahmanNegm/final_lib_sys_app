import 'package:flutter/material.dart';

import '../constants.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.iconsColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              color: const Color(0xFFeed9ab),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Color(0xFFb28f63), offset: Offset(5, 5))
              ]),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                            children: [
                              TextSpan(
                                text: "Welcome to ",
                              ),
                              TextSpan(
                                text: "FCI Library !",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    color: AppConstants.redColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "We are an academic/public library dedicated to providing a vast collection of books and resources to support students and researchers in accessing knowledge easily.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const _SectionHeader("Our Mission:"),
                const _SectionText(
                  "Our goal is to facilitate access to educational materials and promote a culture of reading and scientific research through an advanced borrowing system.",
                ),
                const _SectionHeader("Our Services:"),
                const _SectionText(
                  "We offer a range of services, including:",
                ),
                const _BulletPoint(
                    "Borrowing books for a limited period with renewal options."),
                const _BulletPoint(
                    "Access to electronic references and digital resources."),
                const _BulletPoint("Designated study and reading areas."),
                const _BulletPoint("Educational events and workshops."),
                const SizedBox(height: 16),
                const _SectionHeader("How to Borrow Books"),
                const _SectionText(
                  "You can browse the available books, reserve one via the app, and pick it up from the library at the designated time. If needed, you can renew the borrowing period before the due date.",
                ),
              ],
            ),
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.redColor),
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
