import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mentra/core/constants/package_exports.dart';
// import 'package:mentra/gen/assets.gen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarouselDemo(),
    );
  }
}

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel with Animations'),
      ),
      body: CarouselSlider.builder(
        itemCount: 5, //
        // Adjust as needed
        options: CarouselOptions(
          viewportFraction: 0.3,
          autoPlayCurve: Curves.easeIn,
          onPageChanged: (index, reason) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        itemBuilder: (context, index, realIndex) {
          double value = _currentPage - index.toDouble();
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);

          double rotation = value * 360.0;
          double translateY = value * 100.0;

          return Transform.translate(
            offset: Offset(0.0, translateY),
            child: Transform.rotate(
              angle: rotation * (3.1415926535 / 90),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                     " Assets.images.pngs.onboarding2.path", // Replace with your image URL
                      height: 100.0,
                      fit: BoxFit.cover,
                      width: 1.sw,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Item $index',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
