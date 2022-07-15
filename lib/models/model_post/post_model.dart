class UserCreatePost {
  String name;
  String uId;
  String postImage;
  String text;
  String dateTime;
  String image;

  UserCreatePost(
      {this.name,
      this.uId,
      this.text,
      this.postImage,
      this.dateTime,
      this.image});

  UserCreatePost.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];

    uId = json['uId'];

    postImage = json['postImage'];

    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
