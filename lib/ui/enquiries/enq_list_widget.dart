import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_19/model/lead_data.dart';
import 'package:kit_19/ui/enquiries/widgets/send_mail.dart';
import 'package:kit_19/ui/enquiries/widgets/send_sms.dart';
import 'package:kit_19/ui/enquiries/widgets/send_voice.dart';
import 'package:kit_19/ui/enquiries/widgets/send_whatsapp.dart';

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
                        child: name == 'null'
                            ? Text('')
                            : Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                      Container(
                        child: datetime == 'null' ? Text('') : Text(datetime),
                      ),
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
                      phno == 'null' ? Text('') : Text(phno),
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
                                child: email == 'null'
                                    ? Text('')
                                    : Text(
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
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => SendMail()));
                                  },
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/sms.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                SendSmsPage()));
                                  },
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/phone.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => SendVoice()));
                                  },
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/whatsapp.png',
                                    color: Colors.black,
                                  ),
                                  iconSize: 10.0,
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (context) =>
                                    //             SendWhatsappenq()));
                                  },
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
                          child: remarks == 'null'
                              ? Text('')
                              : Text(
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
