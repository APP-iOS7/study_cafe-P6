class ReservationInfo {
  String? reservationId;
  String? serviceName; // 서비스 / 상품명
  int? amount; // 결제 금액
  String? customerName; // 예약자 이름// 예약자 이메일
  DateTime reservationDate; // 예약 날짜// 추가 정보
  String seatInfo;

  ReservationInfo({
    this.reservationId,
    this.serviceName,
    this.amount,
    this.customerName,
    required this.reservationDate,
    required this.seatInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'serviceName': serviceName,
      'amount': amount,
      'customerName': customerName,
      'reservationDate': reservationDate,
      'seatInfo': seatInfo,
    };
  }
}
