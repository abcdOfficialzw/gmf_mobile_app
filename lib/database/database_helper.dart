import 'package:geodetic_monument_finder/database/database.dart';

import '../models/geodatic_points_model.dart';

class DatabaseHelper {
  static GeodaticPoint? getPoint({required String monumentName}) {
    for (Map<String, dynamic> point in Database.geodaticPoints) {
      print("Checking ${point["monument_name"]}");
      if (point["monument_name"].toString().toLowerCase() ==
          monumentName.toLowerCase()) {
        print("Found");
        return GeodaticPoint.fromJson(point);
      }
    }
    return null;
  }
}
