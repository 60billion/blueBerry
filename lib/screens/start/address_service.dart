import 'package:blueberry/constants/keys.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:dio/dio.dart';

class AddressService {
  void searchAddressByStr(String text) async {
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
    logger.d(response.data);
    logger.d(response.data is Map);
  }
}
