import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kit_19/ui/leads/widgets/custom_drop_down.dart';
import 'package:kit_19/ui/leads/widgets/lead_info.dart';

import '../../model/user_data.dart';

class LeadBody extends StatefulWidget {
  const LeadBody({Key? key}) : super(key: key);

  @override
  State<LeadBody> createState() => _LeadBodyState();
}

class _LeadBodyState extends State<LeadBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropDown(),
                Icon(Icons.map),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Column(
              children: [
                LeadInfo(
                  dueDate: 'No Followup',
                  email: '9191001100@gm.com',
                  name: 'New enquiry 007',
                  phno: '9191001100',
                  username: '',
                  datetime: '23-Feb-2022 21:41:53',
                  leadno: '2587',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                LeadInfo(
                  dueDate: 'Over Due',
                  email: '9911999900@gmail.com',
                  name: 'sfsdfdf',
                  phno: '9911999900',
                  username: '',
                  datetime: '22-Apr-2022 15:25:00',
                  leadno: '2586',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                LeadInfo(
                  dueDate: 'Over Due',
                  email: '9191000000@gy.com',
                  name: 'New One enquiry',
                  phno: '9191000000',
                  username: '',
                  datetime: '23-Feb-2022 14:26:00',
                  leadno: '2585',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                LeadInfo(
                  dueDate: 'Over Due',
                  email: '',
                  name: 'N',
                  phno: '9212360460',
                  username: '',
                  datetime: '21-Feb-2022 23:17:32',
                  leadno: '2584',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const LeadInfo(
                  dueDate: 'No Followup',
                  email: '7840049991@gmail.com',
                  name: 'test 3',
                  phno: '7840049991',
                  username: '',
                  datetime: '21-Feb-2022 18:37:45',
                  leadno: '2583',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
