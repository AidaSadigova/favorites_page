import 'package:favorites_page/model/items.dart';
import 'package:favorites_page/screens/favoritespage.dart';
import 'package:favorites_page/services/product_api.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Photo>> photos;

  @override
  void initState() {
    super.initState();
    photos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: photos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No photos available.'),
            );
          } else {
            final photoList = snapshot.data!;
            return ListView.builder(
              itemCount: photoList.length,
              itemBuilder: (context, index) {
                final photo = photoList[index];
                return ListTile(
                  leading: Text(photo.id.toString()),
                  title: Text(photo.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: photo.isFavorite ? Colors.red : null,
                    onPressed: () {
                      setState(() {
                        photo.isFavorite = !photo.isFavorite;
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final favoritePhotos = await photos.then((photoList) =>
              photoList.where((photo) => photo.isFavorite).toList());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavoritesPage(favorites: favoritePhotos),
            ),
          );
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
