import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  String id;
  String campaignId;
  String campaignTitle;
  String userId;
  String userName;
  String userEmail;
  String role;
  String status; // 'pending', 'approved', 'rejected'
  DateTime appliedAt;

  VolunteerModel({
    required this.id,
    required this.campaignId,
    required this.campaignTitle,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.role,
    required this.status,
    required this.appliedAt,
  });

  factory VolunteerModel.fromJson(Map<String, dynamic> json) {
    return VolunteerModel(
      id: json['id'] ?? '',
      campaignId: json['campaignId'] ?? '',
      campaignTitle: json['campaignTitle'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userEmail: json['userEmail'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? 'pending',
      appliedAt: (json['appliedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignId': campaignId,
      'campaignTitle': campaignTitle,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'role': role,
      'status': status,
      'appliedAt': appliedAt,
    };
  }
}
