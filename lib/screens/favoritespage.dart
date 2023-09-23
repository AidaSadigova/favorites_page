import 'package:favorites_page/model/items.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<Photo> favorites;

  FavoritesPage({required this.favorites});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final photo = widget.favorites[index];
          return ListTile(
            leading: Text(photo.id.toString()),
            title: Text(photo.title),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  widget.favorites.remove(photo);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
