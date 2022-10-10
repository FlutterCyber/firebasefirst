class Post {
  late String userId;
  late String name;
  late String surname;
  late String img_url;

  Post(
      {required this.userId,
      required this.name,
      required this.surname,
      required this.img_url});

  Post.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        surname = map['surname'],
        img_url = map['img_url'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'surname': surname,
        'img_url': img_url,
      };
}
