class CourseCategory {
  String? id;
  String? title;
  String? description;
  String? key;
  String? createdAt;
  String? updatedAt;

  CourseCategory({
    this.id,
    this.title,
    this.description,
    this.key,
    this.createdAt,
    this.updatedAt,
  });

  CourseCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['key'] = key;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
