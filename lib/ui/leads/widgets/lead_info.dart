import 'package:flutter/material.dart';

import '../../../model/user_data.dart';

class LeadInfo extends StatelessWidget {
  const LeadInfo({
    Key? key,
    required this.name,
    required this.dueDate,
    required this.username,
    required this.phno,
    required this.email,
    required this.datetime,
    required this.leadno,
  }) : super(key: key);
  final String name, dueDate, username, phno, email, datetime, leadno;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileLeadNo(
          leadno: leadno,
        ),
        Column(
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 80,
                ),
                Text(
                  dueDate,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.verified_user,
                  size: 15,
                ),
                Text(username),
                SizedBox(width: 10),
                Icon(
                  Icons.mobile_friendly,
                  size: 15,
                ),
                Text(phno),
                SizedBox(width: 10),
                Text(datetime),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.mail,
                  size: 15,
                ),
                Text(email),
                SizedBox(
                  width: 90,
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Kit19 enterprise crm software solution offers all',
            ),
            Text('size companies small medium & big enterpri...'),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileLeadNo extends StatelessWidget {
  const ProfileLeadNo({
    Key? key,
    required this.leadno,
  }) : super(key: key);
  final String leadno;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24), // Image radius
                child: UserDetails.profilePicturePath.isEmpty
                    ? Image.asset("assets/icons/user_place_holder.png")
                    : Image.network(UserDetails.profilePicturePath),
              ),
            ),
          ),
          Text('Lead no.'),
          Text(leadno),
        ],
      ),
    );
  }
}
