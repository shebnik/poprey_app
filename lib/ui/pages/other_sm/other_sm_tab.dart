import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'other_sm_selection_list.dart';

class OtherSmTab extends StatefulWidget {
  const OtherSmTab({Key? key}) : super(key: key);

  @override
  _OtherSmTabState createState() => _OtherSmTabState();
}

class _OtherSmTabState extends State<OtherSmTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OtherSMSelectionList(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(),
          ),
        ),
      ],
    );
  }
}
