import 'package:flutter/material.dart';

import 'package:poprey_app/utils/app_theme.dart';

class SelectionRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final bool isSelected;
  final bool hasBorder;
  final void Function()? onTap;

  const SelectionRow({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    this.onTap,
    this.subtitleColor,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: hasBorder
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: getColor(),
                ),
              ),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isSelected
                      ? const Color(0xFF00ABDF).withOpacity(0.04)
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 17),
                  child: row(context),
                ),
              ),
            )
          : row(context),
    );
  }

  Color getColor() =>
      isSelected ? const Color(0xFF00ABDF) : const Color(0xFFEBEDF1);

  Widget row(BuildContext context) {
    return Row(
      children: [
        isSelected
            ? const Icon(
                Icons.check_circle,
                color: AppTheme.primaryBlue,
                size: 20,
              )
            : Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFEBEDF1),
                  ),
                ),
              ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.apply(fontWeightDelta: -1),
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.apply(color: subtitleColor ?? AppTheme.primaryBlue),
            ),
          ],
        ),
      ],
    );
  }
}
