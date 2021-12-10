import 'package:blueberry/data/user_model.dart';
import 'package:blueberry/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class MapPage extends StatefulWidget {
  final UserModel _userModel;
  const MapPage(this._userModel, {Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final controller;

  Offset? _dragStart;
  double _scaleData = 1.0;

  _scaleStart(ScaleStartDetails details) {
    //print("scaleStart");
    _dragStart = details.focalPoint;
    _scaleData = 1.0;
  }

  _scaleUpdate(ScaleUpdateDetails details) {
    //print("_scaleUpdate");
    var scaleDiff = details.scale - _scaleData;
    _scaleData = details.scale;
    controller.zoom = controller.zoom + scaleDiff;

    final now = details.focalPoint;
    final diff = now - _dragStart!;
    _dragStart = now;
    controller.drag(diff.dx, diff.dy);
    setState(() {});
  }

  Widget _buildMarkerWidget(Offset offset, {Color color = Colors.red}) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Icon(
        Icons.location_on,
        color: color,
        size: 36.0,
      ),
    );
  }

  @override
  void initState() {
    controller = MapController(
      location: LatLng(widget._userModel.geoFirePoint.latitude,
          widget._userModel.geoFirePoint.longitude),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MapLayoutBuilder(
      builder: (BuildContext context, MapTransformer transformer) {
        final myLocationOnMap = transformer.fromLatLngToXYCoords(LatLng(
            widget._userModel.geoFirePoint.latitude,
            widget._userModel.geoFirePoint.longitude));
        final myLocationWidget = _buildMarkerWidget(myLocationOnMap);
        return Stack(children: [
          GestureDetector(
            onScaleStart: _scaleStart,
            onScaleUpdate: _scaleUpdate,
            child: Map(
              controller: controller,
              builder: (context, x, y, z) {
                final url =
                    'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
                return ExtendedImage.network(
                  url,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          myLocationWidget
        ]);
      },
      controller: controller,
    );
  }
}
