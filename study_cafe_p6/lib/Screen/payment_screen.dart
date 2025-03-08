import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

// void main() {
//   runApp(const MyApp());
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

//   // @override
//   // Widget build(BuildContext context) {
//   //   return const MaterialApp(home: PaymentScreen());
//   // }
// }

class PaymentScreen extends StatefulWidget {
  final int selectedPrice;
  const PaymentScreen({
    super.key,
    required this.selectedPrice,
    required this.selectedPlan,
  });

  final String selectedPlan;

  @override
  State<PaymentScreen> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  String formatAmount(int amount) {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(amount)}원';
  }

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
      clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
      customerKey: "2hUlPVxqORkOT-u0vKVV5",
      // 결제위젯에 브랜드페이 추가하기
      // paymentWidgetOptions: PaymentWidgetOptions(brandPayOption: BrandPayOption("리다이렉트 URL")) // Access Token 발급에 사용되는 리다이렉트 URL
    );

    _paymentWidget
        .renderPaymentMethods(
          selector: 'methods',
          amount: Amount(
            value: widget.selectedPrice,
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Text('(좌석 정보)', style: TextStyle(fontSize: 20)),
                              Text(
                                widget.selectedPlan,
                                style: TextStyle(fontSize: 20),
                                softWrap: true,
                              ),
                              SizedBox(height: 20),
                              Text(
                                '결제 금액: ${formatAmount(widget.selectedPrice)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'agreement',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () async {
                        final paymentResult = await _paymentWidget
                            .requestPayment(
                              paymentInfo: PaymentInfo(
                                orderId: 'zvRVFvMqSNSzOzBothLZF',
                                orderName: '${widget.selectedPlan} 이용권',
                              ),
                            );
                        if (paymentResult.success != null) {
                          // 결제 성공 처리
                        } else if (paymentResult.fail != null) {
                          // 결제 실패 처리
                        }
                      },
                      child: Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text('결제하기', style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final selectedPaymentMethod =
                  //         await _paymentMethodWidgetControl
                  //             ?.getSelectedPaymentMethod();
                  //     print(
                  //       '${selectedPaymentMethod?.method} ${selectedPaymentMethod?.easyPay?.provider ?? ''}',
                  //     );
                  //   },
                  //   child: const Text('선택한 결제수단 출력'),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
