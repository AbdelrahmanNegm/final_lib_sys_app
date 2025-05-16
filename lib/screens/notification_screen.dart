import 'package:flutter/material.dart';

import '../constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbeecb),
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbeecb),
        centerTitle: true,
        title:  const Text(
          "Notifications",
          style: TextStyle(
              color: AppConstants.primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFFb28f63),
          ),
        ),
      ),

      body: ListView.separated(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:  const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.account_box_outlined,
                      color: Color(0xFFB28f63),
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Admin",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB28F63),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Hi,Heba👋! To take your book just go to the uni's library and ask the admin for it , hurry up ! or you will miss it again.✅",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "3 days ago",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return  const Divider(color: AppConstants.primaryColor,);
        },
      ),
    );
  }
}
