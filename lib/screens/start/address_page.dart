import 'package:blueberry/screens/start/address_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double userDeviceHeight = MediaQuery.of(context).size.height;
    TextEditingController _address = TextEditingController();

    return SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _address,
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
              onPressed: () {
                final typedAddress = _address.text;
                AddressService().searchAddressByStr(typedAddress);
              },
              label: const Text(' 현재위치로 찾기',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              icon: const Icon(CupertinoIcons.compass)),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Address $index"),
                subtitle: const Text("subTitle"),
              );
            },
            itemCount: 30,
          ))
        ],
      ),
    );
  }
}
