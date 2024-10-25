import 'package:tugas1/model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class Api {
  final String baseUrl = "https://4d61-202-51-113-149.ngrok-free.app";
  Client client = Client();

Future<List<Blog>> getBlogs() async {
  try {
    final response = await client.get(Uri.parse("$baseUrl/api/blog"));
    
    print("Response status: ${response.statusCode}");
    
    // Log the response body to see what is being returned
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      // Attempt to parse the response as JSON
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Ensure the 'data' key exists in the response
      if (jsonResponse.containsKey('data')) {
        List<dynamic> data = jsonResponse['data'];
        List<Blog> blogs = data.map<Blog>((item) => Blog.fromJson(item)).toList();
        return blogs;
      } else {
        print("Response JSON does not contain 'data': $jsonResponse");
        return [];
      }
    } else {
      print("Error fetching blogs: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Exception occurred while fetching blogs: $e");
    return [];
  }
}


  // Endpoint to create a blog
  Future<bool> createBlog(Blog data) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/api/blog"),
        headers: {"Content-Type": "application/json"},
        body: blogToJson(data),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error creating blog: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Exception occurred while creating blog: $e");
      return false;
    }
  }
}
