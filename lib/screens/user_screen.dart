import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton_task/controller/user_controller.dart';

import '../popups/manage_user_pupup.dart';
import 'album_screen.dart';

class UserScreen extends StatelessWidget {
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('User')),
      ),

      body: Obx(
        () => userController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: userController.userList.length,
                      itemBuilder: (context, index) {
                        var data = userController.userList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AlbumScreen(userId: data.id),
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
                                          data.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          data.username,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          data.email,
                                          style: const TextStyle(
                                            fontSize: 14,
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
                                          userController.id.text =
                                              data.id.toString();
                                          userController.name.text = data.name;
                                          userController.username.text =
                                              data.username;
                                          userController.email.text =
                                              data.email;
                                          userController.phone.text =
                                              data.phone;
                                          userController.website.text =
                                              data.website;
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ManageUserDialog(
                                                title: "EDIT USER",
                                                buttonText: 'UPDATE',
                                              );
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
                                                          false); // Return false when cancel is pressed
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      userController
                                                          .deleteUser(data.id);
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
          userController.id.clear();
          userController.name.clear();
          userController.username.clear();
          userController.email.clear();
          userController.phone.clear();
          userController.website.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ManageUserDialog(
                title: "ADD USER",
                buttonText: "ADD",
              );
            },
          );
        },
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
