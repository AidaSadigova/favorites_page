import 'package:favorites_page/model/items.dart';
import 'package:dio/dio.dart';

Future<List<Photo>> fetchPhotos() async {
  try {
    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      var data = response.data as List;

      return data.map((e) => Photo.fromJson(e)).toList();
    }
    return [];
  } on DioException catch (e) {
    return Future.error(e);
  }
}
