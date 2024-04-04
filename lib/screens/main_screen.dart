import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: calculateSelectedIndex(context),
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo, color: Colors.black,),
            label: 'Photo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions, color: Colors.black,),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black,),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black,),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.38),
      ),
    );
  }

  int calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location =
        route.routeInformationProvider.value.uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/photo')) {
      return 1;
    }
    if (location.startsWith('/routes')) {
      return 2;
    }
    if (location.startsWith('/map')) {
      return 3;
    }
    if (location.startsWith('/settings')) {
      return 4;
    }
    return 0;
  }

  void onTap(int value) async {
    switch (value) {
      case 0:
        context.goNamed('home');
        break;
      case 1:
        context.goNamed('photo');
        break;
      case 2:
        context.goNamed('routes');
        break;
      case 3:
        context.goNamed('map');
        break;
      case 4:
        context.goNamed('settings');
        break;
      default:
        context.goNamed('home');
        break;
    }
  }
}
