class LearnTopic {
  int? id;
  String? key;
  String? name;

  LearnTopic({this.id, this.key, this.name});

  LearnTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'name': name,
      };
}