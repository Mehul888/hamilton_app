import 'dart:convert';

import 'package:get/get.dart';
import 'package:hamilton_task/models/photo_model.dart';
import 'package:http/http.dart' as http;
import '../network/api_constant.dart';

class PhotoController extends GetxController {

  late int userId;

  PhotoController(this.userId);

  PhotoModel? photoModel;
  List<PhotoModel> photoList = [];
  var isLoading = false.obs;


  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      final response =
      await http.get(Uri.parse('${ApiConstant.baseUrl}albums/$userId/photos'));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON array
        List<dynamic> responseData = json.decode(response.body);

        photoList =
            responseData.map((item) => PhotoModel.fromJson(item)).toList();
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

  Future<void> deletePhotos(int userId) async {

    final apiUrl = 'https://jsonplaceholder.typicode.com/photos/$userId';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Photo with ID $userId deleted successfully.');

      } else {
        print('Failed to delete Photo. Status code: ${response.statusCode}');

      }
    } catch (e) {
      print('Error deleting photo: $e');

    }
  }
}


