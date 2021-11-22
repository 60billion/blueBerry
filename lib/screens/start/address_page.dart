import 'package:blueberry/data/ad_model.dart';
import 'package:blueberry/screens/start/address_service.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _address = TextEditingController();
  Ad_model? _ad_model;

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

                logger.d(_locationData);
              },
              label: const Text(' 현재위치로 찾기',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              icon: const Icon(CupertinoIcons.compass)),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (_ad_model == null ||
                        _ad_model!.result == null ||
                        _ad_model!.result!.items == null ||
                        _ad_model!.result!.items![index].address == null) {
                      return Container();
                    } else {
                      return ListTile(
                        title: Text(
                            _ad_model!.result!.items![index].address!.road ??
                                ""),
                        subtitle: Text(
                            _ad_model!.result!.items![index].address!.parcel ??
                                ""),
                      );
                    }
                  },
                  itemCount: (_ad_model == null ||
                          _ad_model!.result == null ||
                          _ad_model!.result!.items == null)
                      ? 0
                      : _ad_model!.result!.items!.length))
        ],
      ),
    );
  }
}
