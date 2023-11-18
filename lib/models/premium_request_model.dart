import 'package:queueingtool/models/user.dart';

class PremiumRequest {
  final String requestOwnerId;
  final String requestId;
  final DateTime createdAt;
  final UserModel requestowner;

  PremiumRequest({
    required this.requestOwnerId,
    required this.requestId,
    required this.createdAt,
    required this.requestowner,
  });

  PremiumRequest copyWith({
    String? requestOwnerId,
    String? requestId,
    DateTime? createdAt,
    UserModel? requestowner,
  }) {
    return PremiumRequest(
      requestOwnerId: requestOwnerId ?? this.requestOwnerId,
      requestId: requestId ?? this.requestId,
      createdAt: createdAt ?? this.createdAt,
      requestowner: requestowner ?? this.requestowner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestOwnerId': requestOwnerId,
      'requestId': requestId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'requestowner': requestowner.toJson(),
    };
  }

  factory PremiumRequest.fromMap(Map<String, dynamic> map) {
    return PremiumRequest(
      requestOwnerId: map['requestOwnerId'] as String,
      requestId: map['requestId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      requestowner:
          UserModel.fromMap(map['requestowner'] as Map<String, dynamic>),
    );
  }
}
