import 'class_review.dart';
import 'schedule_detail.dart';

class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;

  // String? cancelReasonId;
  // String? lessonPlanId;
  // String? cancelNote;
  // String? calendarId;
  bool? isDeleted;
  ScheduleDetail? scheduleDetailInfo;
  ClassReview? classReview;

  BookingInfo({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    // this.cancelReasonId,
    // this.lessonPlanId,
    // this.cancelNote,
    // this.calendarId,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
  });

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recordUrl = json['recordUrl'];
    // cancelReasonId = json['cancelReasonId'];
    // lessonPlanId = json['lessonPlanId'];
    // cancelNote = json['cancelNote'];
    // calendarId = json['calendarId'];
    isDeleted = json['isDeleted'];
    scheduleDetailInfo = json['scheduleDetailInfo'] != null
        ? ScheduleDetail.fromJson(json['scheduleDetailInfo'])
        : null;
    classReview = json['classReview'] != null
        ? ClassReview.fromJson(json['classReview'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAtTimeStamp'] = createdAtTimeStamp;
    data['updatedAtTimeStamp'] = updatedAtTimeStamp;
    data['id'] = id;
    data['userId'] = userId;
    data['scheduleDetailId'] = scheduleDetailId;
    data['tutorMeetingLink'] = tutorMeetingLink;
    data['studentMeetingLink'] = studentMeetingLink;
    data['studentRequest'] = studentRequest;
    data['tutorReview'] = tutorReview;
    data['scoreByTutor'] = scoreByTutor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['recordUrl'] = recordUrl;
    // data['cancelReasonId'] = cancelReasonId;
    // data['lessonPlanId'] = lessonPlanId;
    // data['cancelNote'] = cancelNote;
    // data['calendarId'] = calendarId;
    data['isDeleted'] = isDeleted;
    if (scheduleDetailInfo != null) {
      data['scheduleDetailInfo'] = scheduleDetailInfo!.toJson();
    }
    if (classReview != null) {
      data['classReview'] = classReview!.toJson();
    }
    return data;
  }
}
