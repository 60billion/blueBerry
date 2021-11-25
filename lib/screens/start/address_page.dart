import 'package:blueberry/data/ad_model.dart';
import 'package:blueberry/data/address_model.dart';
import 'package:blueberry/screens/start/address_service.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _address = TextEditingController();
  Ad_model? _ad_model;
  Address_model? _add_model;
  bool _isSearch = false;
  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double userDeviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _address,
            onFieldSubmitted: (text) async {
              _add_model = null;
              _ad_model = await AddressService().searchAddressByStr(text);
              setState(() {});
              logger.d(text);
            },
            decoration: const InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.search,
                  size: 40.0,
                ),
              ),
              hintText: "도로명으로 검색",
            ),
            keyboardType: TextInputType.streetAddress,
          ),
          SizedBox(
            height: userDeviceHeight * 0.01,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40), elevation: 0.0
                  // fromHeight use double.infinity as width and 40 is the height
                  ),
              onPressed: () async {
                _ad_model = null;
                setState(() {
                  _isSearch = true;
                });
                Location location = new Location();

                bool _serviceEnabled;
                PermissionStatus _permissionGranted;
                LocationData _locationData;

                _serviceEnabled = await location.serviceEnabled();
                if (!_serviceEnabled) {
                  _serviceEnabled = await location.requestService();
                  if (!_serviceEnabled) {
                    return;
                  }
                }

                _permissionGranted = await location.hasPermission();
                if (_permissionGranted == PermissionStatus.denied) {
                  _permissionGranted = await location.requestPermission();
                  if (_permissionGranted != PermissionStatus.granted) {
                    return;
                  }
                }

                _locationData = await location.getLocation();

                _add_model = await AddressService().searchAddressByCoordinate(
                    log: _locationData.longitude!,
                    lat: _locationData.latitude!);
                if (_add_model != null && _add_model!.status == "OK") {
                  logger.d(_add_model!.result![0].text);
                } else {
                  logger.d("좌표 ($_locationData) 기준으로 주소 값이 조회 되지 않습니다.");
                }
                setState(() {
                  _isSearch = false;
                });
              },
              label: Text(_isSearch ? '위치확인중 ' : "현재 위치 찾기",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              icon: _isSearch
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Icon(CupertinoIcons.compass)),
          if (_ad_model != null)
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (_ad_model == null ||
                          _ad_model!.result == null ||
                          _ad_model!.result!.items == null ||
                          _ad_model!.result!.items![index].address == null) {
                        return const Center(
                            child: Text("입력한 명칭으로 주소가 검색되지 않습니다. 다시 시도 해주세요."));
                      } else {
                        return ListTile(
                          onTap: () {
                            _setAddressinSharedPrefs(_ad_model!
                                    .result!.items![index].address!.road ??
                                "");
                          },
                          title: Text(
                              _ad_model!.result!.items![index].address!.road ??
                                  ""),
                          subtitle: Text(_ad_model!
                                  .result!.items![index].address!.parcel ??
                              ""),
                        );
                      }
                    },
                    itemCount: (_ad_model == null ||
                            _ad_model!.result == null ||
                            _ad_model!.result!.items == null)
                        ? 0
                        : _ad_model!.result!.items!.length)),
          if (_add_model != null)
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (_add_model!.status != "OK") {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Container(
                            child: const Center(
                                child: Text(
                              "GPS 기준으로 주소가 조회 되지 않습니다.\n 검색으로 찾아주세요.",
                              softWrap: true,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        );
                      } else {
                        return ListTile(
                          onTap: () {
                            _setAddressinSharedPrefs(
                                _add_model!.result![0].text ?? "");
                          },
                          title: Text(_add_model!.result![0].text ??
                              "GPS 기준으로 주소가 조회 되지 않습니다."),
                          subtitle: Text(_add_model!.result!.length > 1
                              ? _add_model!.result![1].text ??
                                  "GPS 기준으로 주소가 조회 되지 않습니다."
                              : _add_model!.result![0].text ??
                                  "GPS 기준으로 주소가 조회 되지 않습니다."),
                        );
                      }
                    },
                    itemCount: 1)),
        ],
      ),
    );
  }

  _setAddressinSharedPrefs(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);

    context.read<PageController>().animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
