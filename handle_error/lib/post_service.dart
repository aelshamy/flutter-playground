import 'dart:convert';
import 'dart:io';

class FakeHttpClient {
  Future<String> getResponseBody() async {
    await Future.delayed(const Duration(seconds: 1));

    //! No Internet Connection
    // throw SocketException('No Internet');

    //! 404
    // throw HttpException('404');

    //! Invalid JSON (throw FormatException)
    // return 'abcd';

    return '{"userId":1, "id":1, "title": "nice title", "body": "cool body"}';
  }
}

class PostService {
  final httpClient = FakeHttpClient();

  Future<Post> getOnePost() async {
    try {
      final responseBody = await httpClient.getResponseBody();
      return Post.fromJson(responseBody);
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}

class Failure {
  // Use something like "int code;" if you want to translate error messages
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
    );
  }

  static Post fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'Post id: $id, userId: $userId, title: $title, body: $body';
}
