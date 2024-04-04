import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/routes_data.dart';

class RoutesScreen extends StatelessWidget {
  final Color bgColor;
  const RoutesScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Title(
          color: Colors.black,
          child: const Text(
            'Sentieri',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: CustomRoutesView(),
      );
  }
}

class CustomRoutesView extends StatelessWidget{
  const CustomRoutesView({super.key});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: routeDetails.length,
      itemBuilder: (context, index) {
        List<Widget> header = [];
        List<Widget> title = [];
        title.add(const Icon(Icons.directions));
        title.add(const SizedBox(width: 10));
        title.add(Text(routeDetails[index].end, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),));
        header.add(Row(
          children: title,
        ));
        List<Widget> tag = [];
        tag.add(const SizedBox(width: 10));
        tag.add(const Icon(
          Icons.av_timer_rounded,
          color: Colors.black,
          size: 33,
        ));
        tag.add(const SizedBox(width: 5));
        tag.add(Text(routeDetails[index].time));
        tag.add(const SizedBox(width: 10));
        if (routeDetails[index].easy) {
          tag.add(const Icon(
            Icons.directions_walk_sharp,
            color: Colors.yellow,
            size: 33,
            weight: 600,
            grade: 150,
          ));
        }
        if (routeDetails[index].medium) {
          tag.add(const Icon(
            Icons.directions_walk_sharp,
            color: Colors.green,
            size: 33,
            weight: 600,
            grade: 150,
          ));
        }
        if (routeDetails[index].hard) {
          tag.add(const Icon(
            Icons.hiking,
            color: Colors.red,
            size: 33,
            weight: 600,
            grade: 150,
          ));
        }
        header.add(Row(
          children: tag,
        ));


        List<Widget> body = [];
        body.add(SizedBox(
          height: 750,
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(routeDetails[index].linkUrl)),
            ),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              if (!await launchUrl(Uri.parse(routeDetails[index].linkApp))) {
                throw Exception('Could not launch komoot');
              }
              return NavigationActionPolicy.CANCEL;
            },
          ),));

        return ExpansionTile(
          title: Column(
            children: header,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          children: body,
        );
      },
    );
  }
}