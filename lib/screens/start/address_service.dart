import 'package:blueberry/constants/keys.dart';
import 'package:blueberry/data/ad_model.dart';
import 'package:blueberry/data/address_model.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  Future<Ad_model> searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
      'size': 30,
    };
    final response = await Dio()
        .get("http://api.vworld.kr/req/search", queryParameters: formData)
        .catchError((e) {
      logger.d(e.message);
    });
    Ad_model ad_model = Ad_model.fromJson(response.data["response"]);
    logger.d(ad_model);

    return ad_model;
  }

  Future<Address_model> searchAddressByCoordinate(
      {required double log, required double lat}) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'getAddress',
      'type': 'BOTH',
      'service': 'address',
      'point': "$log,$lat",
    };
    final response = await Dio()
        .get("http://api.vworld.kr/req/address", queryParameters: formData)
        .catchError((e) {
      logger.d(e.message);
    });
    Address_model add_model = Address_model.fromJson(response.data["response"]);
    logger.d(add_model);

    return add_model;
  }
}
