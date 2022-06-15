import 'package:flutter/material.dart';
import 'package:kit_19/ui/add_new_lead/forms/custom_fields.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String person_name = '';
  String mobile_no1 = '';
  String mobile_no2 = '';
  String mobile_no3 = '';
  String email_id1 = '';
  String email_id2 = '';
  String email_id3 = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Full Name',
                labelText: 'Name *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  person_name = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile No.',
                labelText: 'Mobile No. *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no1 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile No.',
                labelText: 'Mobile No. *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no2 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Mobile no.',
                labelText: 'Mobile No. *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  mobile_no3 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id1 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id2 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Enter Email ID',
                labelText: 'Email ID *',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                setState(() {
                  email_id3 = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomFormFields(),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               decoration: const InputDecoration(
//                 filled: true,
//                 hintText: 'Enter Full Name',
//                 labelText: 'Name *',
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   person_name = value;
//                 });
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.green.shade100,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: Text(
//                 'Custom Fields',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Diagnosis(Minimum value 0 and maximum value 0)',
//                 labelText: 'Diagnosis *',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _fees,
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Fees(Minimum value 0 and maximum value 0)',
//                 labelText: 'Fees',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _area,
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Area(Minimum value 0 and maximum value 0)',
//                 labelText: 'Area',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _budget,
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Budget(Minimum value 0 and maximum value 0)',
//                 labelText: 'Budget',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _completiondate,
//               keyboardType: TextInputType.datetime,
//               decoration: new InputDecoration(
//                 hintText: '21 Mar 2022',
//                 labelText: 'Completion Date',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _expiry,
//               keyboardType: TextInputType.datetime,
//               decoration: new InputDecoration(
//                 labelText: 'Expiry',
//                 hintText: '08 Feb 2023',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _fathername,
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'father name(Minimum value 0 and maximum value 0)',
//                 labelText: 'Father Name',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _paymentmode,
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Payment Mode(Minimum value 0 and maximum value 0)',
//                 labelText: 'Payment Mode *',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _followupsts,
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Call Back',
//                 labelText: 'Followup Status',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'parallel67 (Pelsoft Shukla)',
//                 labelText: "",
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               // controller: _nextstatusdate,
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: '23 Mar 2022 13:36',
//                 labelText: 'Next Status Date',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.calendar_today),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Remarks',
//                 labelText: 'Remarks',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Type Product name to search',
//                 labelText: 'Select Products',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Followup Type',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.green.shade100,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: Text(
//                 'Add Deal',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Please Enter Value',
//                 labelText: 'Deal Value *',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Pipeline',
//                 labelText: 'Deal Pipeline',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Pipeline Stage',
//                 labelText: 'Deal Stage',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: '12',
//                 labelText: 'Probability(%)*',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Sales Owner',
//                 labelText: 'Sales Owner',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.datetime,
//               decoration: new InputDecoration(
//                 hintText: 'Select Estimated Closure Date',
//                 labelText: 'Estimated Closure Date',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.calendar_today),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.green.shade100,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: Text(
//                 'Lead Details',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Medium',
//                 labelText: 'Medium',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Campaign',
//                 labelText: 'Campaign',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.text,
//               decoration: new InputDecoration(
//                 hintText: 'Enter your Remarks',
//                 labelText: 'Initial Remarks',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Search Tags',
//                 labelText: 'Tags',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width,
//             color: Colors.green.shade100,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: Text(
//                 'Company Details',
//                 style: TextStyle(color: Colors.black, fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.text,
//               decoration: new InputDecoration(
//                 hintText: 'Enter Company Name',
//                 labelText: 'Company',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select Country',
//                 labelText: 'Country',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select State',
//                 labelText: 'State',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Select City',
//                 labelText: 'City',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: new InputDecoration(
//                 hintText: 'Enter Pincode',
//                 labelText: 'Pincode',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.text,
//               decoration: new InputDecoration(
//                 hintText: 'Enter Residential Address',
//                 labelText: 'Residential Address',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.text,
//               decoration: new InputDecoration(
//                 hintText: 'Enter Official Address',
//                 labelText: 'Official Address',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Self',
//                 labelText: 'MultiSelect',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Call Back',
//                 labelText: 'Followup Status',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'parallel67 (Pelsoft Shukla)',
//                 labelText: "",
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.keyboard_arrow_down),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: '23 Mar 2022 13:36',
//                 labelText: 'Next Status Date',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 suffixIcon: Icon(Icons.calendar_today),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Remarks',
//                 labelText: 'Remarks',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               decoration: new InputDecoration(
//                 hintText: 'Type Product name to search',
//                 labelText: 'Select Products',
//                 hintStyle: TextStyle(fontSize: 12),
//                 labelStyle: TextStyle(fontSize: 18),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.always,
//               ),
//               // The validator receives the text that the user has entered.
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               'Followup Type',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
        ],
      ),
    );
  }
}
