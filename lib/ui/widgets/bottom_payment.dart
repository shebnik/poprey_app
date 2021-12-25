import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';
import 'dart:io' show Platform;

class BottomPayment extends StatelessWidget {
  final double amount;
  final void Function(Map<String, dynamic>) onPaymentResult;
  const BottomPayment({
    Key? key,
    required this.amount,
    required this.onPaymentResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: amount.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocale(context).yourTotal + ' ',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: const Color(0xFFC9CFD6),
                      ),
                ),
                TextSpan(
                  text: Utils.formatAmount(amount),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary(context),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (Platform.isIOS)
            RawApplePayButton(
              style: ApplePayButtonStyle.automatic,
            ),
          // ApplePayButton(
          //   paymentConfigurationAsset:
          //       'default_payment_profile_apple_pay.json',
          //   paymentItems: paymentItems,
          //   style: ApplePayButtonStyle.automatic,
          //   type: ApplePayButtonType.buy,
          //   onPaymentResult: onPaymentResult,
          //   loadingIndicator: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          if (Platform.isAndroid)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppTheme.primaryColor,
              ),
              width: double.infinity,
              height: 40,
              child: RawGooglePayButton(
                type: GooglePayButtonType.buy,
                onPressed: () => {},
                style: AppTheme.isLightTheme(context)
                    ? GooglePayButtonStyle.black
                    : GooglePayButtonStyle.white,
              ),
            ),
          // GooglePayButton(
          //   paymentConfigurationAsset:
          //       'default_payment_profile_google_pay.json',
          //   paymentItems: paymentItems,
          //   style: AppTheme.isLightTheme(context)
          //       ? GooglePayButtonStyle.white
          //       : GooglePayButtonStyle.black,
          //   type: GooglePayButtonType.pay,
          //   onPaymentResult: onPaymentResult,
          //   loadingIndicator: const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
