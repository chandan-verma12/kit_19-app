// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:kit_19/model/lead_data.dart';
import 'package:kit_19/ui/leads/widgets/custom_drop_down.dart';

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
    required this.propic,
    required this.remarks,
  }) : super(key: key);
  final String name, dueDate, username, phno, email, datetime, leadno, propic;
  final String remarks;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileLeadNo(
          leadno: leadno,
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
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(child: _status(dueDate)),
                      // dueDate == "null"
                      //     ? Text(" ")
                      //     : Text(
                      //         dueDate,
                      //         style: TextStyle(
                      //             fontSize: 14, fontWeight: FontWeight.bold),
                      //       ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (username == "null")
                        const Text(" ")
                      else
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/assigned.png',
                              color: Colors.black,
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              username,
                            ),
                          ],
                        ),
                      Text(datetime),
                    ],
                  ),
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
                        icon: const Icon(Icons.more_horiz),
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
    required this.leadno,
    required this.propic,
  }) : super(key: key);
  final String leadno, propic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const SizedBox(
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
          Stack(children: [
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
            Positioned(
              bottom: 1,
              right: 1,
              child: _score(LeadDetails.thresholdColor),
            ),
          ]),
          const Text('Lead no.'),
          Text(leadno),
        ],
      ),
    );
  }
}

Widget _status(duedate) {
  if (duedate == "Due Today") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.brown, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Over Due") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "No Followup") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Scheduled") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.orange, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "Converted") {
    return Text(
      duedate,
      style: const TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
    );
  } else if (duedate == "null") {
    return const Text(" ");
  } else {
    return Text(duedate);
  }
}

Widget _score(score) {
  if (LeadDetails.thresholdColor == "Cold") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Text(
        LeadDetails.currentScore.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  } else if (LeadDetails.thresholdColor == "Warm") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else if (LeadDetails.thresholdColor == "Hot") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else if (LeadDetails.thresholdColor == "Default") {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: Text(LeadDetails.currentScore.toString()),
    );
  } else {
    return Container(
      height: 20,
      width: 20,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: Center(child: Text(LeadDetails.currentScore.toString())),
    );
  }
}
