import 'package:flutter/material.dart';

import '../widget/carousel_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Title(
          color: Colors.black,
          child: const Text(
            'Base Vara "Il Rostiolo"',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 5,
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Carouselmages(
              imagesList: [
                "assets/images/home_vara/PortaleVara.webp",
                "assets/images/home_vara/campo_2.webp",
                "assets/images/home_vara/campo_casa_romana.webp",
                "assets/images/home_vara/casa-mulino.jpg",
                "assets/images/home_vara/mugnoli.webp",
                "assets/images/home_vara/pino.webp",
                "assets/images/home_vara/ponte.webp",
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Greetings to the user;
                  Text(
                    'Ciao, Scout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Meteo: Soleggiato',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
