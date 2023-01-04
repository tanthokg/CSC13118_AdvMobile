class WalletInfo {
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  WalletInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'amount': amount,
        'isBlocked': isBlocked,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'bonus': bonus,
      };

// final String id;
// final String userId;
// final String amount;
// final bool isBlocked;
// final String createdAt;
// final String updatedAt;
// final int bonus;
//
// WalletInfo(
//     {required this.id,
//     required this.userId,
//     required this.amount,
//     required this.isBlocked,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.bonus});
//
// static WalletInfo fromJson(Map<String, dynamic> json) => WalletInfo(
//     id: json['id'] as String,
//     userId: json['userId'] as String,
//     amount: json['amount'] as String,
//     isBlocked: json['isBlocked'] as bool,
//     createdAt: json['createdAt'] as String,
//     updatedAt: json['updatedAt'] as String,
//     bonus: json['bonus'] as int);
}
