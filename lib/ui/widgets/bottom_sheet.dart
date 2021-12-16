import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomSheet extends StatelessWidget {
  final String title;

  const AppBottomSheet({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              color: const Color(0xFFF7F8FB),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 8,
                    child: Container(
                      width: 35,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE1E4E8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          color: const Color(0xFFC9CFD6),
                          icon: const Icon(
                            Icons.close,
                            size: 15,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 25,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const TextField(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
