import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

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
                    marker[i].icon,
                    color: marker[i].color,
                    size: 36.0,
                    fill: 1,
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
                          selectedMarker.icon,
                          color: selectedMarker.color,
                          size: 56.0,
                          fill: 1,
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
                              lastMarker.icon,
                              color: lastMarker.color,
                              size: 36.0,
                              fill: 1,
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
          ),WillPopScope(
              onWillPop: () async{
                if (markerController.lastSelected != -1) {
                  var lastMarker = markerController.getMarkerList()[markerController
                      .lastSelected];
                  await controller.setMarkerIcon(lastMarker.position, MarkerIcon(
                    iconWidget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MarkerIcon(
                            icon: Icon(
                              lastMarker.icon,
                              color: lastMarker.color,
                              size: 36.0,
                              fill: 1,
                            )
                        ),
                        Text(lastMarker.text),
                      ],
                    ),
                  ));
                }
                draggableSheetController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                setState(() {
                  markerController.lastSelected=-1;
                });
                return false;
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


class CustomScrollViewContent extends StatelessWidget {

      VaraMarker selectedMarker;
      CustomScrollViewContent({
          Key? key,
          required this.selectedMarker
        }) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      color: Colors.lightGreenAccent,
    ),
    child: Column(
      children: <Widget>[
      const SizedBox(height: 12), Container(
          height: 5,
          width: 30,
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
      const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(selectedMarker.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text("See All", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
      const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
      const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
                CustomRestaurantCategory(),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
                CustomRestaurantCategory(),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          //only to left align the text
          child: Row(
            children: <Widget>[Text("Featured Lists", style: TextStyle(fontSize: 14))],
          ),
        ),
        SizedBox(height: 34)
      ],
    ),
    );
    }
    }

class CustomRestaurantCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}



class VaraMarker {
  String name;
  GeoPoint position;
  IconData icon;
  Color color;
  String text;
  bool selected = false;
  VaraMarker(this.name, this.position, this.icon, this.color, this.text);
}
class MarkerController {
  int lastSelected = -1;
  List<VaraMarker> marker = [
    VaraMarker("Pino", GeoPoint(latitude: 44.46547, longitude: 8.60171),
        Icons.pin_drop, Colors.red, "Pino"),
    VaraMarker("Caro", GeoPoint(latitude: 44.46300, longitude: 8.60577),
        Icons.pin_drop, Colors.red, "Caro"),
    VaraMarker("Caro", GeoPoint(latitude: 44.46400, longitude: 8.60330),
        Icons.pin_drop, Colors.red, "Caro"),
    VaraMarker("Signora", GeoPoint(latitude: 44.46400, longitude: 8.60070),
        Icons.pin_drop, Colors.red, "Vara"),
    VaraMarker("Fiume", GeoPoint(latitude: 44.46390, longitude: 8.60070),
        Icons.pin_drop, Colors.red, "Fiume"),
    VaraMarker("Pazzo", GeoPoint(latitude: 44.46400, longitude: 8.60190),
        Icons.pin_drop, Colors.red, "Pazzo"),
    VaraMarker("Vara", GeoPoint(latitude: 44.46400, longitude: 8.60222),
        Icons.pin_drop, Colors.red, "Vara"),
    VaraMarker("Vara", GeoPoint(latitude: 44.46777, longitude: 8.60070),
        Icons.pin_drop, Colors.red, "Vara"),
  ];

  selectMarker(GeoPoint point) {
    if (lastSelected != -1) {
      marker[lastSelected].selected = false;
    }
    for (int i = 0; i < marker.length; i++) {
      if (marker[i].position == point) {
        marker[i].selected = true;
        lastSelected = i;
      }
    }
  }

  VaraMarker getMarker(GeoPoint point) {
    for (int i = 0; i < marker.length; i++) {
      if (marker[i].position == point) {
        return marker[i];
      }
    }
    return marker[0];
  }

  List<VaraMarker> getMarkerList() {
    return marker;
  }
}