import 'dart:async';
import 'dart:math';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:sliding_up_panel/sliding_up_panel.dart';
class SelectFromMapPage extends StatefulWidget {
  @override
  _LocationChooserState createState() => _LocationChooserState();
}

class _LocationChooserState extends State<SelectFromMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static  LatLng _center = const LatLng(41.297441965444406, 69.24021454703133);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  String _title = "";
  String _detail = "";

  final panelController = PanelController();

  late TextEditingController _lane1;

  @override
  void initState() {
    super.initState();
    _lane1 = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
              CameraPosition(target: _center, zoom: 11.0),
              markers: _markers,
              mapType: _currentMapType,
              onCameraMove: _onCameraMove,
              onTap: _handleTap,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    _customButton(
                        Icons.map, _onMapTypeButtonPressed),
                    SizedBox(
                      height: 15,
                    ),
                    _customButton(
                        Icons.map_outlined, _onAddMarkerButtonPressed),
                    SizedBox(
                      height: 5,
                    ),
                    _customButton(Icons.maps_home_work_rounded, _getUserLocation),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
                minHeight: _height * 0.05,
                maxHeight: _height * 0.4,
                controller: panelController,
                panel: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 4,
                        width: _width * 0.2,
                        color: mainColor,
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextField(
                              maxLines: 2,
                              controller: _lane1,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                    BorderSide(width: 1,  color: mainColor,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                    BorderSide(width: 1,  color: mainColor,),
                                  ),
                                  errorBorder:  OutlineInputBorder(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                    BorderSide(width: 1, color: mainColor,),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.orange.withOpacity(0.5)),
                                  labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(1)),
                                  labelText: "${l10n?.address}"),
                              cursorColor: Colors.black12
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        height: _height * 0.1,
                        child: CustomButtonTwo( "${l10n?.save}",onTap: (){
                          debugPrint("Save Address");
                          Navigator.pop(context,{
                            'coordinates': _center,
                            'lane': _lane1.text,
                          },);
                        },),
                      ),

                    ],
                  ),
                ),
                body: null)
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _customButton(IconData icon, VoidCallback function) {
    return FloatingActionButton(
      heroTag: icon.codePoint,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: mainColor,
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    _markers.clear();
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(title: _title, snippet: _detail),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  _handleTap(LatLng point) {
    print(' ***** Tapped ***** ');
    panelController.open();
    _markers.clear();
    _getLocation(point);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(title: _title, snippet: _detail),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    });
  }

  _getLocation(LatLng point) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);

    _center = LatLng(point.latitude, point.longitude);
    setState(() {
      _title = placemarks.first.locality??'';
      _detail ='${placemarks.first.street}';
      _lane1.text = "$_title   $_detail";
    });
  }

  _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    panelController.open();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    late Position position;

    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true);
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    _center = LatLng(position.latitude, position.longitude);

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_center.toString()),
        position: _center,
        infoWindow: InfoWindow(title: _title, snippet: _detail),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    });
    var first = placemarks.first;
    print("${first.name} : ${first.subAdministrativeArea}");

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16),
      ),
    );

    setState(() {
      _title = first.locality??'';
      _detail = first.street??'';
      _lane1.text = "$_title   $_detail";
    });
  }
}