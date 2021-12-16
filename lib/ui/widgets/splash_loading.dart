import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:poprey_app/utils/app_constants.dart';

class SplashLoadingWidget extends StatelessWidget {
  const SplashLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 110.0),
            child: Text(
              AppConstants.appName,
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppConstants.SFProDisplay,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
          ),
          SizedBox(
            width: 44,
            height: 44,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: [Colors.white],
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
