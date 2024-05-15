import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:developer' as developer;

import '../models/map_data.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({super.key, required this.title, required this.bgColor});


  final String title;
  final Color bgColor;

  @override
  State<MapScreen> createState() => _MyMapState();
}

class _MyMapState extends State<MapScreen> {

  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 44.46400, longitude: 8.60070),
  );
  DraggableScrollableController sheetController = DraggableScrollableController();

  MarkerController markerController = MarkerController();

  DraggableScrollableController draggableSheetController = DraggableScrollableController();

  var varaMarkerIcon = [];

// default constructor
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var marker = markerController.getMarkerList();
    for (int i = 0; i < marker.length; i++) {
      varaMarkerIcon.add(MarkerIcon(
        iconWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              marker[i].iconMarker.icon,
              color: marker[i].iconMarker.color,
              size: marker[i].iconMarker.size,
              weight: marker[i].iconMarker.weight,
              grade: marker[i].iconMarker.grade,
              opticalSize: marker[i].iconMarker.opticalSize,
              fill: marker[i].iconMarker.fill,
            ),
            Text(marker[i].text),
          ],
        ),
      ),
      );
    }
    return Stack(
        children:[OSMFlutter(
          controller: controller,
          mapIsLoading: Center(child: CircularProgressIndicator(),
          ),
          osmOption: OSMOption(
            zoomOption: ZoomOption(
              initZoom: 17,
              minZoomLevel: 15,
              maxZoomLevel: 19,
              stepZoom: 0.5,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue,
                    size: 56,
                  ),
                )
            ),
          ),
          onMapIsReady: (isReady) async{
            if(isReady) {
              developer.log("log is ready");
              await controller.limitAreaMap(BoundingBox(north: 44.4760, east: 8.6200, south: 44.4531, west: 8.5800));
              var marker = markerController.getMarkerList();
              for (int i = 0; i < marker.length; i++) {
                await controller.addMarker(marker[i].position,
                  markerIcon: varaMarkerIcon[i],);
              }
              GeoPoint geoPoint = await controller.myLocation();  //get user location
              //check if user location is in the limited area
              if (geoPoint.latitude < 44.4760 && geoPoint.latitude > 44.4531 && geoPoint.longitude < 8.6200 && geoPoint.longitude > 8.5800) {
                //if in the limited area, enable tracking
                await controller.enableTracking(enableStopFollow:true,);
              }
            }
          },
          onGeoPointClicked: (geoPoint) async{
            var selectedMarker = markerController.getMarker(geoPoint);
            var newMarker = MarkerIcon(
              iconWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    selectedMarker.iconMarker.icon,
                    color: selectedMarker.iconMarker.color,
                    size: selectedMarker.iconMarker.size + 20,
                    weight: selectedMarker.iconMarker.weight,
                    grade: selectedMarker.iconMarker.grade,
                    opticalSize: selectedMarker.iconMarker.opticalSize,
                    fill: selectedMarker.iconMarker.fill,
                  ),
                  Text(selectedMarker.text),
                ],
              ),
            );
            await controller.setMarkerIcon(geoPoint, newMarker);
            if (markerController.lastSelected != -1) {
              var lastMarker = markerController.getMarkerList()[markerController
                  .lastSelected];
              if (lastMarker.position != geoPoint) {
                var newMarker =  MarkerIcon(
                  iconWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        lastMarker.iconMarker.icon,
                        color: lastMarker.iconMarker.color,
                        size: lastMarker.iconMarker.size,
                        weight: lastMarker.iconMarker.weight,
                        grade: lastMarker.iconMarker.grade,
                        opticalSize: lastMarker.iconMarker.opticalSize,
                        fill: lastMarker.iconMarker.fill,
                      ),
                      Text(lastMarker.text),
                    ],
                  ),
                );
                await controller.setMarkerIcon(lastMarker.position, newMarker);
              }
            }
            setState(() {
              markerController.selectMarker(geoPoint);
            });


          },
        ),PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            developer.log("PopScope: $didPop");
            if (didPop) {
              return;
            }
            if (markerController.lastSelected != -1) {
              var lastMarker = markerController.getMarkerList()[markerController.lastSelected];
              controller.setMarkerIcon(lastMarker.position, MarkerIcon(
                iconWidget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      lastMarker.iconMarker.icon,
                      color: lastMarker.iconMarker.color,
                      size: lastMarker.iconMarker.size,
                      weight: lastMarker.iconMarker.weight,
                      grade: lastMarker.iconMarker.grade,
                      opticalSize: lastMarker.iconMarker.opticalSize,
                      fill: lastMarker.iconMarker.fill,
                    ),
                    Text(lastMarker.text),
                  ],
                ),
              ));
            }
            draggableSheetController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            setState(() {
              markerController.lastSelected = -1;
            });
          },
          child: DraggableScrollableSheet(
              controller: draggableSheetController,
              builder: (context, scrollController) {
                if (markerController.lastSelected == -1) {
                  return Container();
                }
                var SelectedMarker = markerController.getMarkerList()[markerController.lastSelected];
                return  SingleChildScrollView(
                  controller: scrollController,
                  child: CustomScrollViewContent(selectedMarker: SelectedMarker),

                );
              }),
        ),]
    );
  }
}