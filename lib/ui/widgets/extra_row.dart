import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';

class ExtraRow extends StatefulWidget {
  final Extra extra;
  final void Function(Extra extra) onSelected;

  const ExtraRow({
    Key? key,
    required this.extra,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ExtraRow> createState() => _ExtraRowState();
}

class _ExtraRowState extends State<ExtraRow> {
  late Extra extra;
  bool isSelected = false;

  String get extraTitle => '+${extra.count} ${extra.name.toLowerCase()}';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: getColor(),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onSelected(widget.extra);
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                isSelected ? const Color(0xFF00ABDF).withOpacity(0.04) : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                          extraTitle,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.apply(fontWeightDelta: -1),
                        ),
                        Text(
                          '+${Utils.formatAmount(extra.price)}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.apply(color: AppTheme.primaryBlue),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text(extraTitle),
                        content: Text(
                            'The number of times your content, whether a post or a story, was shown to users. Impressions help you to promote your post and improve stat.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('Got it!'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    )
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.info_outlined,
                    size: 18,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor() =>
      isSelected ? const Color(0xFF00ABDF) : const Color(0xFFEBEDF1);
}
