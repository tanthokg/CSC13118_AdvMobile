import '../user/user.dart';

class TutorInfo {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  User? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;

  TutorInfo({
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.isNative,
    this.user,
    this.isFavorite,
    this.avgRating,
    this.totalFeedback,
  });

  TutorInfo.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    isFavorite = json['isFavorite'];
    avgRating = json['avgRating'];
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['video'] = video;
    data['bio'] = bio;
    data['education'] = education;
    data['experience'] = experience;
    data['profession'] = profession;
    data['accent'] = accent;
    data['targetStudent'] = targetStudent;
    data['interests'] = interests;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['rating'] = rating;
    data['isNative'] = isNative;
    if (user != null) {
      data['User'] = user!.toJson();
    }
    data['isFavorite'] = isFavorite;
    data['avgRating'] = avgRating;
    data['totalFeedback'] = totalFeedback;
    return data;
  }
}
