import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamilton_task/models/user_model.dart';
import 'package:hamilton_task/network/api_constant.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  UserModel? userModel;
  List<UserModel> userList = [];
  var isLoading = false.obs;
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController website = TextEditingController();

  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final response =
          await http.get(Uri.parse(ApiConstant.baseUrl + ApiConstant.userUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON array
        List<dynamic> responseData = json.decode(response.body);

        userList =
            responseData.map((item) => UserModel.fromJson(item)).toList();
        isLoading.value = false;
      } else {
        // If the server did not return a 200 OK response, throw an error
        throw Exception('Failed to load data');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void updateUserDetail() async {
    var apiUrl =
        Uri.parse('https://jsonplaceholder.typicode.com/users/' + id.text);
    var data = {
      "name": name.text,
      "username": username.text,
      "email": email.text,
      "phone": phone.text,
      "website": website.text,
    };
    var response = await http.patch(
      apiUrl,
      body: data,
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('Updated user details: $responseData');
      print('Updated user successfully ');
    } else {
      print(
          'Failed to update user details. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(int userId) async {
    final apiUrl = 'https://jsonplaceholder.typicode.com/users/$userId';
    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print('User with ID $userId deleted successfully.');
      } else {
        print('Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  void abbUser() async {
    var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var data = {
      "name": name.text,
      "username": username.text,
      "email": email.text,
      "phone": phone.text,
      "website": website.text,
    };
    var response = await http.post(
      apiUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      print('Add user details: $responseData');
      print('Add user successfully ');
    } else {
      print('Failed to Add user details. Status code: ${response.statusCode}');
    }
  }
}
