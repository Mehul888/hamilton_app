

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton_task/controller/photo_controller.dart';
import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  PhotoScreen({super.key, required this.userId});

  int userId;

  @override
  State<PhotoScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotoScreen> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PhotoController photoController = Get.put(PhotoController(widget.userId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Photos')),
      ),

      body: Obx(
        () => photoController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                      child: Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // Adjust the number of columns as needed
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: photoController.photoList.length,
                      itemBuilder: (context, index) {
                        var data = photoController.photoList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        data.thumbnailUrl,
                                        // Assuming 'thumbnailUrl' is the URL of the image
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Confirm Delete'),
                                            content: const Text(
                                                'Are you sure you want to delete this Image?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      false); // Return false when cancel is pressed
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  photoController
                                                      .deletePhotos(data.id);
                                                  Navigator.of(context).pop(
                                                      true); // Return true when delete is pressed
                                                },
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _getImage();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DateTimeSelectionScreen(
          //     ),
          //   ),
          // );

        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
