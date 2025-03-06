class ReservationInfo {
  final String reservationId;
  final String serviceName; // 서비스 / 상품명
  final int amount; // 결제 금액
  final String customerName; // 예약자 이름
  final String customerEmail; // 예약자 이메일
  final DateTime reservationDate; // 예약 날짜
  final String additionalInfo; // 추가 정보

  ReservationInfo({
    required this.reservationId,
    required this.serviceName,
    required this.amount,
    required this.customerName,
    this.customerEmail = '',
    required this.reservationDate,
    this.additionalInfo = '',
  });
}
