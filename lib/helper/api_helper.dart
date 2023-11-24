import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<List?> getWallpapers({
    String query = "savings",
  }) async {
    String WallApi =
        'https://pixabay.com/api/?key=38359285-b3dce53fdcc47898d599b68df&q=$query&orientation=horizontal&image_type=photo&order=popular&per_page=200';

    http.Response respons = await http.get(
      Uri.parse(
        WallApi,
      ),
    );

    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body);
      print(respons.body);
      print("data:${data['hits']}");
      List allData = data['hits'];
      return allData;
    }
  }
}
