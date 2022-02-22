class PostModel {
  String? name;
  String? date;
  String? image;
  String? text;
  String? postimage;

  PostModel({this.name, this.date, this.image, this.postimage, this.text});

  PostModel.fromJson(Map<String, dynamic>? Json) {
    name = Json!['name'];
    date = Json['date'];
    image = Json['image'];
    postimage = Json['postimage'];
    text = Json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'image': image,
      'text': text,
      'postimage': postimage,
    };
  }
}
