import 'package:flutter/material.dart';

import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/ui/widgets/extra_row.dart';

class ExtraPlansColumn extends StatefulWidget {
  final List<Extra> extras;
  final void Function(List<Extra> value) setSelectedExtras;

  const ExtraPlansColumn({
    Key? key,
    required this.extras,
    required this.setSelectedExtras,
  }) : super(key: key);

  @override
  State<ExtraPlansColumn> createState() => _ExtraPlansColumnState();
}

class _ExtraPlansColumnState extends State<ExtraPlansColumn> {
  late final List<Extra> list;
  List<Extra> selectedExtras = [];

  @override
  void initState() {
    super.initState();
    list = widget.extras.where((element) => element.disabled == false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => ExtraRow(
        onSelected: (extra) {
          selectedExtras.contains(extra)
              ? selectedExtras.remove(extra)
              : selectedExtras.add(extra);
          widget.setSelectedExtras(selectedExtras);
        },
        extra: list[index],
      ),
    );
  }
}
