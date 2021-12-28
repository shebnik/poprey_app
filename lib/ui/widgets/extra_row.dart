import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/app_widgets.dart';
import 'package:poprey_app/ui/widgets/selection_row.dart';
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
    extra = widget.extra;
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
                SelectionRow(
                  title: extra.name,
                  subtitle: '+${Utils.formatAmount(extra.price.toDouble())}',
                  isSelected: isSelected,
                ),
                IconButton(
                  onPressed: () {
                    AppWidgets.openDialog(
                      context: context,
                      title: '+${extra.count} $dialogTitle',
                      description: dialogDescription,
                      actionText: AppLocale(context).gotIt,
                    );
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

  String get dialogTitle {
    switch (extra.name.toLowerCase()) {
      case 'impressions':
        return AppLocale(context).impressions;
      case 'reach':
        return AppLocale(context).reach;
      case 'saves':
        return AppLocale(context).saves;
      default:
        return extra.name;
    }
  }

  String get dialogDescription {
    switch (extra.name.toLowerCase()) {
      case 'impressions':
        return AppLocale(context).impressionsDescr;
      case 'reach':
        return AppLocale(context).reachDescr;
      case 'saves':
        return AppLocale(context).savesDescr;
      default:
        return extra.name;
    }
  }
}
