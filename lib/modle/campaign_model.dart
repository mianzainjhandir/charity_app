import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel {
  String id;
  String title;
  String category;
  double targetAmount;
  double raisedAmount;
  String expirationDate;
  String description;
  String coverImage;
  String creatorId;
  DateTime createdAt;

  CampaignModel({
    required this.id,
    required this.title,
    required this.category,
    required this.targetAmount,
    required this.raisedAmount,
    required this.expirationDate,
    required this.description,
    required this.coverImage,
    required this.creatorId,
    required this.createdAt,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      targetAmount: (json['targetAmount'] ?? 0).toDouble(),
      raisedAmount: (json['raisedAmount'] ?? 0).toDouble(),
      expirationDate: json['expirationDate'] ?? '',
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      creatorId: json['creatorId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'targetAmount': targetAmount,
      'raisedAmount': raisedAmount,
      'expirationDate': expirationDate,
      'description': description,
      'coverImage': coverImage,
      'creatorId': creatorId,
      'createdAt': createdAt,
    };
  }
}
