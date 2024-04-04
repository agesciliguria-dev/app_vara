import 'package:app_vara/widget/carousel_images.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Title(
          color: Colors.black,
          child: const Text(
            'Foto',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //backgroundColor: Colors.transparent,
        elevation: 5,
      ),
      body: const Center(
        child: Carouselmages(
          height: 500,
          networkImages: true,
          imagesList: [
            'https://i.pinimg.com/564x/f0/fa/fd/f0fafd5382138cfdb699a56c3f625f54.jpg',
            'https://i.pinimg.com/564x/6e/e0/b0/6ee0b00a32cafde57cb004d40c1c6acc.jpg',
            'https://i.pinimg.com/564x/4f/69/d4/4f69d4002511bd35777907a971d37d56.jpg',
            'https://i.pinimg.com/564x/81/00/4a/81004a90ec1de6b30952037d3822a8bc.jpg',
            'https://i.pinimg.com/564x/b8/07/41/b80741370c737d0ee3ce74631ee7b530.jpg',
            'https://i.pinimg.com/564x/1a/53/26/1a5326447eb227173e28934ecea507da.jpg',
            'https://i.pinimg.com/564x/95/66/90/956690f5951f4b80170817ca45681e00.jpg',
          ],
        ),
      ),
    );
  }
}
