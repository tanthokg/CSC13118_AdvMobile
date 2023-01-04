import 'course_category.dart';
import 'course_topic.dart';

class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  bool? visible;
  String? createdAt;
  String? updatedAt;
  List<CourseTopic>? topics;
  List<CourseCategory>? categories;

  Course({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    otherDetails = json['other_details'];
    defaultPrice = json['default_price'];
    coursePrice = json['course_price'];
    visible = json['visible'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['topics'] != null) {
      topics = <CourseTopic>[];
      json['topics'].forEach((v) {
        topics!.add(CourseTopic.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CourseCategory>[];
      json['categories'].forEach((v) {
        categories!.add(CourseCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['level'] = level;
    data['reason'] = reason;
    data['purpose'] = purpose;
    data['other_details'] = otherDetails;
    data['default_price'] = defaultPrice;
    data['course_price'] = coursePrice;
    data['visible'] = visible;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
