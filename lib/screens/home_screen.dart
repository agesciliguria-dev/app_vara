import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widget/carousel_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: 'vzK-W6IqxQ8',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Carouselmages(
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 8, right: 8, left: 0, top: 5),
                          child: Image.asset(
                            'assets/images/home_vara/logo_cba_def_1_colore.png',
                            height: 135,
                          )),
                      const Flexible(
                        child: Text(
                          "La Base Scout propone più di 40 ettari di terreno e 5 strutture abitative pronte ad accogliere Scout e non da tutto il mondo! La capienza è di circa 200 persone nelle sue 5 case e diverse centinaia in tenda nei molti campi presenti.",
                        ),
                      ),
                    ],
                  ),
                  const Text(
                      "La Base Scout accoglie eventi per ragazzi, campi di formazione per Capi, campi di unità e di gruppo, associazioni scout estere e altre associazioni e, da diversi anni, ospita l’evento “Ora et Labora” durante la Settimana Santa. Dal 2013 fa parte della Comunità Basi Agesci (CBA)."),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('Prenota la base'),
        //TODO: pensare se mettere webview
        onPressed: () async {
          await launchUrl(
              Uri.parse('https://liguria.agesci.it/basi/prenotazioni/'));
        },
      ),
    );
  }
}
