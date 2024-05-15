import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';


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

class IconMarker {
  IconData icon;
  Color color;
  double? weight;
  double? grade;
  double? opticalSize;
  double size;
  double? fill;
  IconMarker(this.icon, this.color, this.size, this.fill, this.weight, this.grade, this.opticalSize);
}
IconMarker home = IconMarker(Symbols.home_pin, Colors.red, 36.0, 1.0, 1.0, 1.0, 36.0);
IconMarker camping = IconMarker(Symbols.camping_rounded, Colors.orange, 30.0, 1.0, 1.0, 1.0, 30.0);

class VaraMarker {
  String name;
  GeoPoint position;
  IconMarker iconMarker;
  String text;
  bool selected = false;
  VaraMarker(this.name, this.position, this.iconMarker, this.text);
}
class MarkerController {
  int lastSelected = -1;
  List<VaraMarker> marker = [
    VaraMarker("Pino", GeoPoint(latitude: 44.46547, longitude: 8.60171), home, "Pino"),
    VaraMarker("Quercia", GeoPoint(latitude: 44.46518, longitude: 8.60165), home, "Quercia"),
    VaraMarker("Palazzo", GeoPoint(latitude: 44.46463, longitude: 8.60125), home, "Palazzo"),
    VaraMarker("Pino", GeoPoint(latitude: 44.46447, longitude: 8.60125), home, "Pino"),
    VaraMarker("Romana", GeoPoint(latitude: 44.46796, longitude: 8.60065), home, "Romana"),
    VaraMarker("Mulino", GeoPoint(latitude: 44.46316, longitude: 8.60664), home, "Mulino"),
    VaraMarker("Tendone", GeoPoint(latitude: 44.46512, longitude: 8.60123), home, "Tendone"),
    VaraMarker("Campo1", GeoPoint(latitude: 44.46545, longitude: 8.60241), camping, "Campo1"),
    VaraMarker("Campo2", GeoPoint(latitude: 44.4669, longitude: 8.60042), camping, "Campo2"),
    VaraMarker("Campo3", GeoPoint(latitude: 44.46615, longitude: 8.60114), camping, "Campo3"),
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

