class Feedback {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  FirstInfo? firstInfo;

  Feedback({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    rating = json['rating'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo =
        json['firstInfo'] != null ? FirstInfo.fromJson(json['firstInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['firstId'] = firstId;
    data['secondId'] = secondId;
    data['rating'] = rating;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (firstInfo != null) {
      data['firstInfo'] = firstInfo!.toJson();
    }
    return data;
  }
}

class FirstInfo {
  String? level;
  String? email;
  String? google;
  String? facebook;
  String? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? studentGroupId;

  FirstInfo({
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.studySchedule,
    this.canSendMessage,
    this.isPublicRecord,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
  });

  FirstInfo.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    studentGroupId = json['studentGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['level'] = level;
    data['email'] = email;
    data['google'] = google;
    data['facebook'] = facebook;
    data['apple'] = apple;
    data['avatar'] = avatar;
    data['name'] = name;
    data['country'] = country;
    data['phone'] = phone;
    data['language'] = language;
    data['birthday'] = birthday;
    data['requestPassword'] = requestPassword;
    data['isActivated'] = isActivated;
    data['isPhoneActivated'] = isPhoneActivated;
    data['requireNote'] = requireNote;
    data['timezone'] = timezone;
    data['phoneAuth'] = phoneAuth;
    data['isPhoneAuthActivated'] = isPhoneAuthActivated;
    data['studySchedule'] = studySchedule;
    data['canSendMessage'] = canSendMessage;
    data['isPublicRecord'] = isPublicRecord;
    data['caredByStaffId'] = caredByStaffId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['studentGroupId'] = studentGroupId;
    return data;
  }
}
