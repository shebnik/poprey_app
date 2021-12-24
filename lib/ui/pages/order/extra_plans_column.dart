import 'package:flutter/material.dart';

import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/ui/widgets/extra_row.dart';

class ExtraPlansColumn extends StatelessWidget {
  final List<Extra>? extras;
  List<Extra> selectedExtras = [];
  final void Function(List<Extra> value) setSelectedExtras;

  ExtraPlansColumn({
    Key? key,
    this.extras,
    required this.setSelectedExtras,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (extras == null) return Container();
    final List<Extra> list =
        extras!.where((element) => element.disabled == false).toList();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => ExtraRow(
        onSelected: (extra) {
          selectedExtras.contains(extra)
              ? selectedExtras.remove(extra)
              : selectedExtras.add(extra);
          setSelectedExtras(selectedExtras);
        },
        extra: list[index],
      ),
    );
  }
}
