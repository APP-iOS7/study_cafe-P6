import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_cafe_p6/Screen/Payment/paysuccess_screen.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

class PaymentScreen extends StatefulWidget {
  final ReservationInfo reservationInfo;

  const PaymentScreen({super.key, required this.reservationInfo});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  String formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(amount)}원';
  }

  Future<void> _saveReservationToFirestore(
    Map<String, dynamic> paymentResult,
  ) async {
    try {
      if (paymentResult['success'] != null) {
        final updatedReservationInfo = widget.reservationInfo;

        // Firestore 저장
        await _firestore
            .collection('reservation')
            .add(updatedReservationInfo.toJson());

        print('예약 정보가 Firestore에 저장되었습니다.');

        // 저장 성공 후 페이지 이동
        Get.to(() => PaySuccess(reservationInfo: widget.reservationInfo));
      } else if (paymentResult['fail'] != null) {
        // 결제 실패 처리
      }
    } catch (e) {
      print('Firestore 저장 오류: $e');
      Get.snackbar(
        '오류',
        '예약 저장에 실패했습니다: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
      clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
      customerKey: widget.reservationInfo.reservationId!,
      // 결제위젯에 브랜드페이 추가하기!
      // paymentWidgetOptions: PaymentWidgetOptions(brandPayOption: BrandPayOption("리다이렉트 URL")) // Access Token 발급에 사용되는 리다이렉트 URL
    );

    _paymentWidget
        .renderPaymentMethods(
          selector: 'methods',
          amount: Amount(
            value: widget.reservationInfo.amount!,
            currency: Currency.KRW,
            country: "KR",
          ),
          options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"),
        )
        .then((control) {
          _paymentMethodWidgetControl = control;
        });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('결제하기'),
        backgroundColor: Color(0xfff8f2de),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close_rounded, size: 30),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '최종 예약정보',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      '고객명',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 121, 120, 120),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '${widget.reservationInfo.customerName}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20.0),
                    child: Text(
                      '예약일',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 121, 120, 120),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      widget.reservationInfo.reservationDate.toString().split(
                        ' ',
                      )[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20.0),
                    child: Text(
                      '좌석',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 121, 120, 120),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      widget.reservationInfo.seatInfo,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20.0),
                    child: Text(
                      '상품명',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 121, 120, 120),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '${widget.reservationInfo.serviceName} 이용권',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20.0),
                    child: Text(
                      '결제금액',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 121, 120, 120),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      formatAmount(widget.reservationInfo.amount!),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    PaymentMethodWidget(
                      paymentWidget: _paymentWidget,
                      selector: 'methods',
                    ),
                    AgreementWidget(
                      paymentWidget: _paymentWidget,
                      selector: 'agreement',
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // 결제요청
                        final paymentResult = await _paymentWidget
                            .requestPayment(
                              paymentInfo: PaymentInfo(
                                orderId: widget.reservationInfo.reservationId!,
                                orderName: widget.reservationInfo.serviceName!,
                                //추가정보 설정
                                customerName:
                                    widget.reservationInfo.customerName,
                                metadata: {
                                  'reservation_date':
                                      widget.reservationInfo.reservationDate
                                          .toString(),
                                },
                              ),
                            );
                        try {
                          _saveReservationToFirestore;
                          Get.to(
                            () => PaySuccess(
                              reservationInfo: widget.reservationInfo,
                            ),
                            arguments: {'success': true},
                          );
                        } catch (e) {}
                        // 결제 결과 처리
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Color(0xffa31d1d),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              '결제하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
