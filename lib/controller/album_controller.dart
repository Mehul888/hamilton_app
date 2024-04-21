import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hamilton_task/models/user_album.dart';
import 'package:http/http.dart' as http;

import '../network/api_constant.dart';

class AlbumController extends GetxController {
  late int userId;
  AlbumController(this.userId);
  AlbumModel? albumModel;
  List<AlbumModel> albumList = [];
  var isLoading = false.obs;
  TextEditingController id = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
    print(userId);
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final response = await http
          .get(Uri.parse('${ApiConstant.baseUrl}users/$userId/albums'));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        albumList =
            responseData.map((item) => AlbumModel.fromJson(item)).toList();
        isLoading.value = false;
      } else {
        throw Exception('Failed to load data');
        isLoading.value = false;
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void updateUserAlbum() async {
    var apiUrl =
        Uri.parse('https://jsonplaceholder.typicode.com/albums/' + id.text);
    var data = {
      "title": title.text,
    };
    var response = await http.patch(
      apiUrl,
      body: data,
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('Updated album details: $responseData');
      print('Updated album successfully ');
    } else {
      print('Failed to update album. Status code: ${response.statusCode}');
    }
  }

  Future<void> deleteAlbum(int userId) async {
    final apiUrl = 'https://jsonplaceholder.typicode.com/albums/$userId';
    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print('Album with ID $userId deleted successfully.');
      } else {
        print('Failed to delete album. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting album: $e');
    }
  }

  void abbAlbum() async {
    var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    var data = {
      "title": title.text,
    };
    var response = await http.post(
      apiUrl,
      body: data,
    );
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      print('Add Album details: $responseData');
      print('Add Album successfully ');
    } else {
      print('Failed to Add Album. Status code: ${response.statusCode}');
    }
  }
}
