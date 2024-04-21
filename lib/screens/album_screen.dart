import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton_task/controller/album_controller.dart';
import 'package:hamilton_task/screens/photos_screen.dart';

import '../popups/manage_album_popup.dart';
import '../popups/manage_user_pupup.dart';

class AlbumScreen extends StatelessWidget {
  AlbumScreen({super.key, required this.userId});

  int userId;

  @override
  Widget build(BuildContext context) {
    AlbumController albumController = Get.put(AlbumController(userId));
    print(userId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Album')),
      ),

      body: Obx(
        () => albumController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: albumController.albumList.length,
                      itemBuilder: (context, index) {
                        var data = albumController.albumList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoScreen(
                                    userId: data.userId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          albumController.id.text =
                                              data.id.toString();
                                          albumController.title.text =
                                              data.title;

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ManageAlbum(
                                                  title: "EDIT ALBUM",
                                                  buttonText: "UPDATE");
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline_outlined,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Delete'),
                                                content: const Text(
                                                    'Are you sure you want to delete this User?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop(
                                                          false);
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      albumController
                                                          .deleteAlbum(data.id);
                                                      Navigator.of(context).pop(
                                                          true);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          albumController.title.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ManageAlbum(title: "ADD ALBUM", buttonText: "ADD");
            },
          );
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
