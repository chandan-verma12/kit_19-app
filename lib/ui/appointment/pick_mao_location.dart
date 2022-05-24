import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/app_theme.dart';
import 'package:location/location.dart';
import '../../base_class.dart';
import '../../network/api_call.dart';
import '../../network/api_constants.dart';
import '../../network/api_response.dart';
import '../../network/method.dart';
import '../../utils/arguments.dart';

class PickMapLocation extends StatefulWidget {
  static String tag = 'pic_map_location';

  @override
  State<StatefulWidget> createState() {
    return _PickMapLocation();
  }
}

class _PickMapLocation extends BaseClass<PickMapLocation>
    implements ApiResponse {
  Set<Factory<PanGestureRecognizer>> gesture = Set();
  late GoogleMapController mapController;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  var currentAddress = "", searchedData = "Search Places....";
  Set<Marker> markers = {};
  late LatLng latLng;
  bool isFetchingAddress = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getAppBar('Select Location',
            bgColor: AppTheme.colorPrimary, iconColor: AppTheme.white),
        body: Column(children: [
          Material(
              elevation: 20,
              child: Expanded(
                  child: InkWell(
                      onTap: () {
                        openPlaceSearch();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(children: [
                            const Icon(Icons.location_searching_rounded),
                            getHorizontalGap(width: 10),
                            Text(searchedData)
                          ]))))),
          Expanded(
              child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0.0, 0.0),
              zoom: 0,
            ),
            markers: markers,
            onTap: (pos) {
              setState(() {
                markers.clear();
                isFetchingAddress = true;
              });
              latLng = pos;
              markers.add(getMarker(latLng, 'Unknown'));
              getAddress(latLng);
            },
          )),
          Container(
              color: AppTheme.white,
              child: Column(children: [
                isFetchingAddress
                    ? const LinearProgressIndicator(
                        color: AppTheme.colorPrimary,
                        backgroundColor: AppTheme.colorNutral)
                    : Container(),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            currentAddress,
                            style: styleMedium(),
                          )),
                          OutlinedButton(
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Text(
                                  'Save Location',
                                  style: TextStyle(color: AppTheme.white),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  side: const BorderSide(
                                      width: 1.0, color: AppTheme.colorPrimary),
                                  primary: AppTheme.white,
                                  backgroundColor: AppTheme.colorPrimary),
                              onPressed: () {
                                if (currentAddress.isNotEmpty) {
                                  Navigator.pop(context, {
                                    Arguments.LAT_LNG: latLng,
                                    Arguments.ADDRESS: currentAddress
                                  });
                                }
                              })
                        ]))
              ]))
        ]));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocaion();
  }

  void getCurrentLocaion() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    LocationData _locationData = await location.getLocation();
    if (_locationData.latitude != null && _locationData.longitude != null) {
      latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
      getAddress(latLng);
    }
  }

  void getAddress(LatLng latLng) async {
    final Map<String, dynamic> params = {
      'latlng': "${latLng.latitude},${latLng.longitude}",
      'key': ApiConstants.MAP_KEY
    };
    const apiUrl = "https://maps.googleapis.com/maps/api/geocode/json";
    ApiCall.makeApiCall(
        ApiRequest.GET_ADDRESSS_FROM_LAT_LNG, params, Method.GET, apiUrl, this);
  }

  void getPlaceDetails(String placeId) async {
    final Map<String, dynamic> params = {
      'place_id': placeId,
      'key': ApiConstants.MAP_KEY
    };
    const apiUrl = "https://maps.googleapis.com/maps/api/place/details/json";
    ApiCall.makeApiCall(
        ApiRequest.GET_PLACE_DETAILS, params, Method.GET, apiUrl, this);
  }

  Marker getMarker(LatLng latLng, dynamic address) {
    return Marker(
        markerId: const MarkerId('123'),
        position: latLng,
        draggable: true,
        infoWindow: InfoWindow(title: address),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  }

  @override
  void onError(String errorResponse, int responseCode, int requestCode) {
    debugPrint(
        "Msg: ${errorResponse} Response Code ${responseCode} Request Code ${requestCode}");
  }

  @override
  void onTokenExpired(String errorMsg, int responseCode, int requestCode) {}

  @override
  void onResponse(String response, int responseCode, int requestCode) {
    debugPrint(
        "Data: ${response} Response Code ${responseCode} Request Code ${requestCode}");
    if (isProgress) hideProgress();
    var jsonData = json.decode(response);
    switch (requestCode) {
      case ApiRequest.GET_ADDRESSS_FROM_LAT_LNG:
        setState(() {
          markers.clear();
        });
        final formattedAddress = jsonData['results'][0]['formatted_address'];
        debugPrint(formattedAddress);
        final m = getMarker(latLng, formattedAddress);
        setState(() {
          markers.add(m);
          currentAddress = formattedAddress;
          isFetchingAddress = false;
        });
        mapController.animateCamera(CameraUpdate.newLatLngZoom(m.position, 13));
        Future.delayed(const Duration(seconds: 1), () {
          mapController.showMarkerInfoWindow(const MarkerId('123'));
        });
        break;
      case ApiRequest.GET_PLACE_DETAILS:
        setState(() {
          markers.clear();
        });
        final result = jsonData['result'];
        final formattedAddress = result['formatted_address'];
        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];
        final placeLatlng =
            LatLng(double.parse(lat.toString()), double.parse(lng.toString()));
        latLng = placeLatlng;
        final m = getMarker(latLng, formattedAddress);
        setState(() {
          markers.add(m);
          currentAddress = formattedAddress;
          isFetchingAddress = false;
        });
        mapController.animateCamera(CameraUpdate.newLatLngZoom(m.position, 13));
        Future.delayed(const Duration(seconds: 1), () {
          mapController.showMarkerInfoWindow(const MarkerId('123'));
        });
        break;
    }
  }

  openPlaceSearch() async {
    changeSystemUiColor(statusBarColor: Colors.transparent);
    final p = await PlacesAutocomplete.show(
        offset: 0,
        radius: 0,
        types: [],
        strictbounds: false,
        hint: 'Search Places...',
        region: "",
        context: context,
        apiKey: ApiConstants.MAP_KEY,
        mode: Mode.overlay,
        language: "en",
        components: []);
    if (p != null) {
      setState(() {
        isFetchingAddress = true;
      });
      getPlaceDetails(p.placeId!);
    }
  }
}
