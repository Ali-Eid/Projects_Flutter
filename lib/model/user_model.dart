class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uid;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerification;

  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.uid,
      this.isEmailVerification,
      this.image,
      this.cover,
      this.bio});

  UserModel.fromJson(Map<String, dynamic>? Json) {
    name = Json!['name'];
    email = Json['email'];
    phone = Json['phone'];
    uid = Json['uid'];
    image = Json['image'];
    bio = Json['bio'];
    cover = Json['cover'];
    isEmailVerification = Json['isEmailVerification'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isEmailVerification': isEmailVerification,
    };
  }
}
