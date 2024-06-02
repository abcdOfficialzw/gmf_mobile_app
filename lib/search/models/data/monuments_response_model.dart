class MonumentsResponseModel {
  bool? isEmpty;
  List<Monuments>? monuments;
  int? page;
  int? perPage;
  int? total;

  MonumentsResponseModel(
      {this.isEmpty, this.monuments, this.page, this.perPage, this.total});

  MonumentsResponseModel.fromJson(Map<String, dynamic> json) {
    isEmpty = json['is_empty'];
    if (json['monuments'] != null) {
      monuments = <Monuments>[];
      json['monuments'].forEach((v) {
        monuments!.add(new Monuments.fromJson(v));
      });
    }
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_empty'] = this.isEmpty;
    if (this.monuments != null) {
      data['monuments'] = this.monuments!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}

class Monuments {
  String? condition;
  int? deltaId;
  Deltapoints? deltapoints;
  int? gaussId;
  Gausspoints? gausspoints;
  int? id;
  String? monumentImage;
  String? monumentName;
  String? topo;
  int? utmId;
  Utmpoints? utmpoints;
  int? wgs84Id;
  Wgs84points? wgs84points;

  Monuments(
      {this.condition,
        this.deltaId,
        this.deltapoints,
        this.gaussId,
        this.gausspoints,
        this.id,
        this.monumentImage,
        this.monumentName,
        this.topo,
        this.utmId,
        this.utmpoints,
        this.wgs84Id,
        this.wgs84points});

  Monuments.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    deltaId = json['delta_id'];
    deltapoints = json['deltapoints'] != null
        ? new Deltapoints.fromJson(json['deltapoints'])
        : null;
    gaussId = json['gauss_id'];
    gausspoints = json['gausspoints'] != null
        ? new Gausspoints.fromJson(json['gausspoints'])
        : null;
    id = json['id'];
    monumentImage = json['monument_image'];
    monumentName = json['monument_name'];
    topo = json['topo'];
    utmId = json['utm_id'];
    utmpoints = json['utmpoints'] != null
        ? new Utmpoints.fromJson(json['utmpoints'])
        : null;
    wgs84Id = json['wgs84_id'];
    wgs84points = json['wgs84points'] != null
        ? new Wgs84points.fromJson(json['wgs84points'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['delta_id'] = this.deltaId;
    if (this.deltapoints != null) {
      data['deltapoints'] = this.deltapoints!.toJson();
    }
    data['gauss_id'] = this.gaussId;
    if (this.gausspoints != null) {
      data['gausspoints'] = this.gausspoints!.toJson();
    }
    data['id'] = this.id;
    data['monument_image'] = this.monumentImage;
    data['monument_name'] = this.monumentName;
    data['topo'] = this.topo;
    data['utm_id'] = this.utmId;
    if (this.utmpoints != null) {
      data['utmpoints'] = this.utmpoints!.toJson();
    }
    data['wgs84_id'] = this.wgs84Id;
    if (this.wgs84points != null) {
      data['wgs84points'] = this.wgs84points!.toJson();
    }
    return data;
  }
}

class Deltapoints {
  String? deltaE;
  String? deltaLat;
  String? deltaLon;
  String? deltaN;
  String? deltaX;
  String? deltaY;
  int? id;

  Deltapoints(
      {this.deltaE,
        this.deltaLat,
        this.deltaLon,
        this.deltaN,
        this.deltaX,
        this.deltaY,
        this.id});

  Deltapoints.fromJson(Map<String, dynamic> json) {
    deltaE = json['delta_e'];
    deltaLat = json['delta_lat'];
    deltaLon = json['delta_lon'];
    deltaN = json['delta_n'];
    deltaX = json['delta_x'];
    deltaY = json['delta_y'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delta_e'] = this.deltaE;
    data['delta_lat'] = this.deltaLat;
    data['delta_lon'] = this.deltaLon;
    data['delta_n'] = this.deltaN;
    data['delta_x'] = this.deltaX;
    data['delta_y'] = this.deltaY;
    data['id'] = this.id;
    return data;
  }
}

class Gausspoints {
  String? gaussLo;
  String? gaussX;
  String? gaussY;
  int? id;

  Gausspoints({this.gaussLo, this.gaussX, this.gaussY, this.id});

  Gausspoints.fromJson(Map<String, dynamic> json) {
    gaussLo = json['gauss_lo'];
    gaussX = json['gauss_x'];
    gaussY = json['gauss_y'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gauss_lo'] = this.gaussLo;
    data['gauss_x'] = this.gaussX;
    data['gauss_y'] = this.gaussY;
    data['id'] = this.id;
    return data;
  }
}

class Utmpoints {
  int? id;
  String? utmCm;
  String? utmEast;
  String? utmNorth;

  Utmpoints({this.id, this.utmCm, this.utmEast, this.utmNorth});

  Utmpoints.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    utmCm = json['utm_cm'];
    utmEast = json['utm_east'];
    utmNorth = json['utm_north'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['utm_cm'] = this.utmCm;
    data['utm_east'] = this.utmEast;
    data['utm_north'] = this.utmNorth;
    return data;
  }
}

class Wgs84points {
  int? id;
  String? wgs84Lat;
  String? wgs84Lon;

  Wgs84points({this.id, this.wgs84Lat, this.wgs84Lon});

  Wgs84points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wgs84Lat = json['wgs84_lat'];
    wgs84Lon = json['wgs84_lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wgs84_lat'] = this.wgs84Lat;
    data['wgs84_lon'] = this.wgs84Lon;
    return data;
  }
}
