import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationInfo {
  String? reservationId;
  String? serviceName; // 서비스 / 상품명
  int? amount; // 결제 금액
  String? customerName; // 예약자 이름// 예약자 이메일
  DateTime reservationDate; // 예약 날짜// 추가 정보
  String seatInfo;
  String? uid;
  String paymentStatus;
  DateTime createdAt;
  DateTime? paidAt;
  String? paymentMethodType;

  ReservationInfo({
    this.reservationId,
    this.serviceName,
    this.amount,
    this.customerName,
    required this.reservationDate,
    required this.seatInfo,
    this.uid,
    this.paymentStatus = '결제대기',
    DateTime? createdAt,
    this.paidAt,
    this.paymentMethodType,
  }) : createdAt = createdAt ?? DateTime.now();

  //S
  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'serviceName': serviceName,
      'amount': amount,
      'customerName': customerName,
      'reservationDate': reservationDate,
      'seatInfo': seatInfo,
      'uid': uid,
      'paymentStatus': paymentStatus,
      'createdAt': createdAt,
      'paidAt': paidAt,
      'paymentMethodType': paymentMethodType,
    };
  }

  //R
  factory ReservationInfo.fromJson(Map<String, dynamic> json) {
    return ReservationInfo(
      reservationId: json['reservationId'],
      serviceName: json['serviceName'],
      amount: json['amount'],
      customerName: json['customerName'],
      reservationDate: (json['reservationDate'] as Timestamp).toDate(),
      seatInfo: json['seatInfo'],
      uid: json['uid'],
      paymentStatus: json['paymentStatus'] ?? '결제대기',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      paidAt:
          json['paidAt'] != null
              ? (json['paidAt'] as Timestamp).toDate()
              : null,
      paymentMethodType: json['paymentMethodType'],
    );
  }
}
