import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}


class _MainPageState extends State<MainPage> {
  double _imageHeight = 256.0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildImage()
        ],
      ),
    );
  }

   Widget _buildImage() {
    return new ClipPath(
      clipper: new DialongonalClipper(),
      child: Image.asset(
        'images/birds.jpg',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        color: new Color.fromARGB(120, 12, 10, 40),
        colorBlendMode: BlendMode.srcOver,
      )
    );
  }
}
class DialongonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
