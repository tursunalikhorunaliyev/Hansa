import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetImage extends StatefulWidget {
  const CachedNetImage({Key? key}) : super(key: key);

  @override
  State<CachedNetImage> createState() => _CachedNetImageState();
}

class _CachedNetImageState extends State<CachedNetImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              leading: buildImage(index),
              title: Text(
                'image${index + 1}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1533662635785-9050eeb7a9be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cGhvdG98ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }
}
