class Favorites {
  bool? status;
  String? message;

  Favorites({this.status, this.message});

  Favorites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
