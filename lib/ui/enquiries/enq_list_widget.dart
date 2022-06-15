import 'package:flutter/material.dart';
import 'package:kit_19/model/lead_data.dart';
import 'package:kit_19/ui/leads/widgets/custom_drop_down.dart';

import '../../../model/user_data.dart';

class EnquiryList extends StatelessWidget {
  const EnquiryList({
    Key? key,
    required this.name,
    required this.phno,
    required this.email,
    required this.datetime,
    required this.propic,
    required this.remarks,
  }) : super(key: key);
  final String name, phno, email, datetime, propic;
  final String remarks;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileLeadNo(
          propic: propic,
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(child: Text(datetime)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/mobileNo.png',
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      ),
                      Text(phno),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/mail.png',
                            color: Colors.black,
                            width: 20,
                            height: 20,
                          ),
                          Flexible(
                            child: Container(
                                child: Text(
                              email,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ),
                        ],
                      )),
                      PopupMenuButton(
                        icon: Icon(Icons.more_horiz),
                        iconSize: 18,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            height: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/mail.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/sms.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/phone.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/whatsapp.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        remarks,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileLeadNo extends StatelessWidget {
  const ProfileLeadNo({
    Key? key,
    required this.propic,
  }) : super(key: key);
  final String propic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // Container(
          //   width: 70,
          //   height: 70,
          //   decoration: BoxDecoration(shape: BoxShape.circle),
          //   child: Stack(children: [
          //     CircleAvatar(radius: 50, child: Image.network(propic)),
          //   ]),
          // ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24), // Image radius
                child: LeadDetails.image.isEmpty
                    ? Image.asset("assets/icons/user_place_holder.png")
                    : Image.network(propic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
