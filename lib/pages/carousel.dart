import 'package:el_dolarazo/pages/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselItem {
  final String title;
  final String imageUrl;

  CarouselItem({required this.title, required this.imageUrl});
}

List<CarouselItem> carouselItems = [
  CarouselItem(
    title: 'Imagen 1',
    imageUrl:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ),
  CarouselItem(
    title: 'Imagen 2',
    imageUrl:
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ),
  // Agrega más elementos del carrusel según tus necesidades
];

class CarouselWithButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrusel con botones'),
      ),
      body: GestureDetector(
        onTap: () {
          // Navegar a la nueva página cuando se presiona el carrusel
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  IntroPage(), // Reemplaza "NewPage()" por la página que deseas mostrar
            ),
          );
        },
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            autoPlay: true,
            height:
                screenHeight, // El carrusel ocupará toda la pantalla verticalmente
          ),
          items: carouselItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}