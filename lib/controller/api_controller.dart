import 'package:flutter/material.dart';

import '../helper/api_helper.dart';

class Apicontroller extends ChangeNotifier {
  List data = [];

  Apicontroller() {
    Search();
  }

  Search({
    String val = " ",
  }) async {
    data = await ApiHelper.apiHelper.getWallpapers(
      query: val,
    ) ??
        [];
    notifyListeners();
    return 0;
  }
}
