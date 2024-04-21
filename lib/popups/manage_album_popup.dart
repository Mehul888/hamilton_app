import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hamilton_task/controller/album_controller.dart';

class ManageAlbum extends StatelessWidget {
  ManageAlbum({super.key, required this.title, required this.buttonText});

  String title;
  String buttonText;
  AlbumController albumController = Get.put(AlbumController(1));

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
                    _buildTextField("Album Name", albumController.title),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Add your functionality here
                          if (title == "EDIT ALBUM") {
                            albumController.updateUserAlbum();
                            Navigator.pop(context);
                          } else {
                            albumController.abbAlbum();
                            Navigator.pop(context); // Close the dialog
                          }
                          // Close the dialog
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
            controller: controller,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
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
}
