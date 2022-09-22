class Post {
  late String userId;
  late String name;
  late String surname;

  Post({required this.userId, required this.name, required this.surname});

  Post.fromJson(Map<String, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        surname = map['surname'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'surname': surname,
      };
}
