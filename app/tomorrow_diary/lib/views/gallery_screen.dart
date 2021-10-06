import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({ Key? key }) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount : 3,
      children: List.generate(30, (index) => Image.network('http://picsum.photos/id/${index}/150/150.jpg')),
    );
  }
}