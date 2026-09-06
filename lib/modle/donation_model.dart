import 'package:cloud_firestore/cloud_firestore.dart';

class DonationModel {
  String id;
  String campaignId;
  String campaignTitle;
  String userId;
  double amount;
  DateTime timestamp;
  String paymentMethod;

  DonationModel({
    required this.id,
    required this.campaignId,
    required this.campaignTitle,
    required this.userId,
    required this.amount,
    required this.timestamp,
    required this.paymentMethod,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] ?? '',
      campaignId: json['campaignId'] ?? '',
      campaignTitle: json['campaignTitle'] ?? '',
      userId: json['userId'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      timestamp: (json['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'campaignId': campaignId,
      'campaignTitle': campaignTitle,
      'userId': userId,
      'amount': amount,
      'timestamp': timestamp,
      'paymentMethod': paymentMethod,
    };
  }
}
