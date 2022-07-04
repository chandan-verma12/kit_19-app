import 'package:flutter/material.dart';

class LeadFullDetailsFieldsShowWidget extends StatelessWidget {
  const LeadFullDetailsFieldsShowWidget({
    Key? key,
    required this.fieldname,
    required this.fielddata,
  }) : super(key: key);

  final String fieldname, fielddata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 130,
            child: Text(
              fieldname == 'null' ? '' : fieldname,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              fielddata == 'null' ? '' : fielddata,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
