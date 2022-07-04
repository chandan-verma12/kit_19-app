import 'package:flutter/material.dart';
import 'package:kit_19/model/enquiry_details.dart';

import '../../../model/user_data.dart';
import '../../../utils/app_theme.dart';

class SendWhatsapp extends StatefulWidget {
  const SendWhatsapp({Key? key}) : super(key: key);

  @override
  State<SendWhatsapp> createState() => _SendWhatsappState();
}

class _SendWhatsappState extends State<SendWhatsapp> {
  @override
  Widget build(BuildContext context) {
    int showWidget = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Whatsapp'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          shape: BoxShape.rectangle),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(20), // Image radius
                          child:
                              Image.asset("assets/icons/user_place_holder.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(EnquiryDetails.name),
                          Text(EnquiryDetails.mobile1),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            iconSize: 5,
                            onPressed: () {},
                            icon: Image.asset('assets/icons/snooze.png')),
                        IconButton(
                            iconSize: 5,
                            onPressed: () {},
                            icon: Image.asset('assets/icons/ban.png')),
                        IconButton(
                            iconSize: 5,
                            onPressed: () {},
                            icon: Image.asset('assets/icons/star-black.png')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 2,
        child: Container(
          height: 120,
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showWidget = 1;
                      },
                      child: const Text(
                        'Respond',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Template',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showWidget = 2;
                        });
                      },
                      child: const Text(
                        'Docs',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const CustomiseButton(),
                  ],
                ),
              ),
              Container(
                  height: 80,
                  child: showWidget == 2
                      ? const RespondWidget()
                      : const DocsWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({Key? key}) : super(key: key);

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ToggleButtons(
          borderColor: Colors.black,
          fillColor: Colors.black54,
          borderWidth: 1,
          selectedBorderColor: Colors.black,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(5),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Promotional',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transactional',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          isSelected: isSelected,
        ),
      ],
    );
  }
}

class CustomiseButton extends StatelessWidget {
  const CustomiseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Text('B')),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Text('M')),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Text('I')),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Text('S')),
        ),
      ],
    );
  }
}

class RespondWidget extends StatefulWidget {
  const RespondWidget({Key? key}) : super(key: key);

  @override
  State<RespondWidget> createState() => _RespondWidgetState();
}

class _RespondWidgetState extends State<RespondWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/smiley.png'),
        ),
      ],
    );
  }
}

class DocsWidget extends StatefulWidget {
  const DocsWidget({Key? key}) : super(key: key);

  @override
  State<DocsWidget> createState() => _DocsWidgetState();
}

class _DocsWidgetState extends State<DocsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(child: Text('M')),
        ),
      ],
    );
  }
}

class Whatsappsend extends StatelessWidget {
  const Whatsappsend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Whatsapp'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<TemplateDataSMS> getSmsTemplatedata() async {
  var url = "https://services.kit19.com/UserCRM/GetSmsDltTemplate";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"SenderName": ApiSendData.sendname}
  };

  final bodyjson = json.encode(body);
  // pass headers parameters if any
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: bodyjson);
  print(" url call from " + url);
  if (response.statusCode == 200) {
    print('url hit successful' + response.body);

    return TemplateDataSMS.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<WhatsappListModel> getSmssenderid() async {
  var url =
      "https://services.kit19.com/UserCRM/GetConversationAsRequiredConvId";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"EntityName": "enquiry", "EntityId": Widget.id}
  };

  final bodyjson = json.encode(body);
  // pass headers parameters if any
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: bodyjson);
  print(" url call from " + url);
  if (response.statusCode == 200) {
    print('url hit successful' + response.body);

    return WhatsappListModel.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}

Future<WhatsappTemplateList> getSmssenderid() async {
  var url = "https://services.kit19.com/UserCRM/GetTempalteParameters";

  final body = {
    "Status": "",
    "Message": "",
    "Token": UserDetails.token,
    "Details": {"TemplateId": 998}
  };

  final bodyjson = json.encode(body);
  // pass headers parameters if any
  final response = await http.post(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: bodyjson);
  print(" url call from " + url);
  if (response.statusCode == 200) {
    print('url hit successful' + response.body);

    return WhatsappTemplateList.fromJson(json.decode(response.body));
  } else {
    print('failed to get data');
    throw Exception('Failed to get data');
  }
}
