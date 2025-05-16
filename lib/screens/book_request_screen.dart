import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants.dart';

class BookRequestScreen extends StatefulWidget {
  const BookRequestScreen({super.key});

  @override
  State<BookRequestScreen> createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfff8e0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppConstants.primaryColor,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  // width: MediaQuery.of(context).size.width * 0.75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      controller: searchController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(

                          // labelText: "Email",
                          hintText: "Student Name, ID , Book Request",
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                          fillColor: const Color(0xFFDFC394),
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppConstants.primaryColor),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppConstants.primaryColor,
                              ))),
                      keyboardType: TextInputType.text,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Please enter your name";
                      //   }
                      //   return null;
                      // },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xfff8eeca),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                    itemCount: 5,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Card(
                          color: const Color(0xffefddb2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xFFE8C261),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Student Name: Heba Hamed Attia",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              "Department: Information Technology"),
                                          Text("ID: 2051234580"),
                                          Text("Academic Year: 4"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppConstants.primaryColor),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,

                                        // width: MediaQuery.of(context).size.width * 0.7,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFB28F63),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0xFF553C28),
                                                  offset: Offset(2, 5),
                                                  spreadRadius: 0.8,
                                                  blurRadius: 5)
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        "assets/images/book1.jpeg",
                                        width: 100,
                                        height: 120,
                                        fit: BoxFit.fill,
                                        // height: 100,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              "Exploring Computer Science With Schema by Oliver Grillmeyer",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 0.7,

                                            // width: MediaQuery.of(context).size.width * 0.7,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFB28F63),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color(0xFF553C28),
                                                      offset: Offset(1, 3),
                                                      spreadRadius: 0.8,
                                                      blurRadius: 5)
                                                ]),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text("Page: 582"),
                                          const Text(
                                              "Author: Oliver Grillmeyer"),
                                          const Text("Code: G0113"),
                                          const Text("Department: General"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: NiceButtons(
                                        stretch: true,
                                        startColor: const Color(0xffc5a479),
                                        endColor: const Color(0xffc5a479),
                                        borderColor: const Color(0xff9f8763),
                                        height: 45,
                                        gradientOrientation:
                                            GradientOrientation.Horizontal,
                                        onTap: (finish) {},
                                        child: const Text(
                                          'Approve',
                                          style: TextStyle(
                                              color: AppConstants.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: NiceButtons(
                                        stretch: true,
                                        startColor: const Color(0xffc5a479),
                                        endColor: const Color(0xffc5a479),
                                        borderColor: const Color(0xff9f8763),
                                        height: 45,
                                        gradientOrientation:
                                            GradientOrientation.Horizontal,
                                        onTap: (finish) {},
                                        child: const Text(
                                          'Deny',
                                          style: TextStyle(
                                              color: AppConstants.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(backgroundColor: AppConstants.primaryColor),
                                    //     onPressed: () {},
                                    //     child: const Text("Approve", style: TextStyle(color: Colors.white)),
                                    //   ),
                                    // ),
                                    // const SizedBox(width: 8),
                                    // Expanded(
                                    //   child: ElevatedButton(
                                    //     style: ElevatedButton.styleFrom(backgroundColor: AppConstants.iconsColor),
                                    //     onPressed: () {},
                                    //     child: const Text("Deny", style: TextStyle(color: Colors.black)),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
