import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class SaveLead extends StatefulWidget {
  const SaveLead({Key? key}) : super(key: key);

  @override
  State<SaveLead> createState() => _SaveLeadState();
}

class _SaveLeadState extends State<SaveLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Send Email'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageAddWidget(),
            SizedBox(
              height: 20,
            ),
            FieldsData(),
          ],
        ),
      ),
    );
  }
}

class ImageAddWidget extends StatelessWidget {
  const ImageAddWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Stack(
            children: [
              Container(
                width: 160,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  height: 140,
                  width: 150,
                  child: Image.asset(
                    'assets/icons/user.png',
                  ),
                ),
              ),
              Positioned(
                top: 1,
                right: 1,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            color: Colors.black.withOpacity(
                              0.3,
                            ),
                            blurRadius: 3,
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 35,
              width: 220,
              child: Center(
                child: Text('Maximum Uploaded File Size 1MB'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FieldsData extends StatefulWidget {
  const FieldsData({Key? key}) : super(key: key);

  @override
  State<FieldsData> createState() => _FieldsDataState();
}

class _FieldsDataState extends State<FieldsData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController email1Controller = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController raddrController = TextEditingController();
  TextEditingController oaddrController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Person Name',
              labelText: 'Name *',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Email',
              labelText: 'Email Id *',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: email1Controller,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Email',
              labelText: 'Email Id 1',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: email2Controller,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Email',
              labelText: 'Email Id 2',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: mobileController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Mobile',
              labelText: 'Mobile *',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: mobile1Controller,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Mobile',
              labelText: 'Mobile 1',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: mobile2Controller,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter your Mobile',
              labelText: 'Mobile 2',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: remarksController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter Remarks',
              labelText: 'Remarks',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: raddrController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Residential Address',
              labelText: 'Residential address',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: oaddrController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Office Address',
              labelText: 'Office Address',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter City',
              labelText: 'City',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: stateController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter State',
              labelText: 'State',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: pincodeController,
            decoration: const InputDecoration(
              filled: true,
              hintText: 'Enter pincode',
              labelText: 'Pincode',
              hintStyle: TextStyle(fontSize: 12),
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}
