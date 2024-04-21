import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constant.dart';

Future getData({required String paramUri}) async {
  var response = await http.get(Uri.parse(ApiConstant.baseUrl + paramUri));

  // if (response.body.isNotEmpty) {
  //   var body = json.decode(response.body);
  //   return body;
  // }
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    var body = json.decode(response.body);
    return body;
  } else {
    // If the server did not return a 200 OK response, throw an error
    throw Exception('Failed to load data');
  }
}
