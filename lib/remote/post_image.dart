import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static Future<bool> postImage(File file) async {
    print('Loading');
    final response = await http.post(
      Uri.parse('http://127.0.0.1:3000/image'),
      body: file.readAsBytesSync(),
    );

    final responseJson = json.decode(response.body);

    print(responseJson);
    return true;
  }
}

class ResponseData {
  final int statusCode;
  final String message;
  const ResponseData({
    required this.statusCode,
    required this.message,
  });
  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
        statusCode: json['status_code'], message: json['message']);
  }
}
