class AddressModel {
  AddressModel({
    required this.page,
    required this.result,
  });
  late final Page page;
  late final Result result;

  AddressModel.fromJson(Map<String, dynamic> json) {
    page = Page.fromJson(json['page']);
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page.toJson();
    _data['result'] = result.toJson();
    return _data;
  }
}

class Page {
  Page({
    required this.total,
    required this.current,
    required this.size,
  });
  late final String total;
  late final String current;
  late final String size;

  Page.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['current'] = current;
    _data['size'] = size;
    return _data;
  }
}

class Result {
  Result({
    required this.crs,
    required this.type,
    required this.items,
  });
  late final String crs;
  late final String type;
  late final List<Items> items;

  Result.fromJson(Map<String, dynamic> json) {
    crs = json['crs'];
    type = json['type'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['crs'] = crs;
    _data['type'] = type;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.address,
    required this.point,
  });
  late final String id;
  late final Address address;
  late final Point point;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = Address.fromJson(json['address']);
    point = Point.fromJson(json['point']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['address'] = address.toJson();
    _data['point'] = point.toJson();
    return _data;
  }
}

class Address {
  Address({
    required this.zipcode,
    required this.category,
    required this.road,
    required this.parcel,
    required this.bldnm,
    required this.bldnmdc,
  });
  late final String zipcode;
  late final String category;
  late final String road;
  late final String parcel;
  late final String bldnm;
  late final String bldnmdc;

  Address.fromJson(Map<String, dynamic> json) {
    zipcode = json['zipcode'];
    category = json['category'];
    road = json['road'];
    parcel = json['parcel'];
    bldnm = json['bldnm'];
    bldnmdc = json['bldnmdc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['zipcode'] = zipcode;
    _data['category'] = category;
    _data['road'] = road;
    _data['parcel'] = parcel;
    _data['bldnm'] = bldnm;
    _data['bldnmdc'] = bldnmdc;
    return _data;
  }
}

class Point {
  Point({
    required this.x,
    required this.y,
  });
  late final String x;
  late final String y;

  Point.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['x'] = x;
    _data['y'] = y;
    return _data;
  }
}
