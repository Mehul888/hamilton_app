import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/user_controller.dart';

class ManageUserDialog extends StatelessWidget {
  ManageUserDialog({super.key, required this.title, required this.buttonText});

  String title;
  String buttonText;

  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      titlePadding: const EdgeInsets.all(10),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Name", userController.name),
                    const SizedBox(height: 10),
                    _buildTextField("Username", userController.username),
                    const SizedBox(height: 10),
                    _buildTextField("Email", userController.email),
                    const SizedBox(height: 10),
                    _buildTextField("Phone Number", userController.phone),
                    const SizedBox(height: 10),
                    _buildTextField("Website", userController.website),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (title == "EDIT USER") {
                            userController.updateUserDetail();
                            Navigator.pop(context); // Close the dialog
                          } else {
                            userController.abbUser();
                            Navigator.pop(context); // Close the dialog
                          }
                        },
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(String labelText, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$labelText:",
        style: const TextStyle(fontSize: 14),
      ),
      SizedBox(
        height: 40,
        child: TextField(
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          controller: controller,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: '',
            fillColor: Colors.grey[200],
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsets.only(
              left: 12,
              top: 6,
              bottom: 6,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ),
    ],
  );
}
