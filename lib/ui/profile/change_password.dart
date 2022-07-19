import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kit_19/model/user_data.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var _oldPassword = TextEditingController();
var _newPassword = TextEditingController();


void savePassword(String _oldPassword, String _newPassword) async{
var body =
{
  "Status": "",
  "Message": "",
  "Token": 637937724907177678,
  "Details": {
    "strUserLogin":"Abhi01",
    "strOldPassword": 16848,
    "strNewPassword": 16847
  }
};
Response response = await post(
        Uri.parse('https://services.kit19.com/Admin/ChangePasswordProfile'),
         body: jsonEncode(body),
        headers: {
          "Content-type":"application/json"
        }
      );
        log(response.toString());


      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        // print(data.toString());
        print('change successfully');
        
      }else {
        log("Failed");
      }
      
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //   title: const Text("Profile"),
      //   leading: IconButton(
      //       icon: Icon(Icons.arrow_back_ios),
      //       onPressed: () {
      //       },
      //     ),
        
      //   actions: [
         
      //     IconButton(onPressed: (){}, icon: Image.asset("assets/icons/logout.png")),
      //   ],
      //   backgroundColor: Color.fromARGB(255, 26, 213, 101),
        
      //         ),

                 body: SafeArea(
                   child: SingleChildScrollView(child: Padding(
                     padding:  EdgeInsets.only(left: 18, top: 10, bottom: 10, right: 10),
                     child: Column(
                       children: [
                         Container(
                           height: 507,
                           child: ListView(
                            //  mainAxisAlignment: MainAxisAlignment.start,
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                           //      Divider(height: 3, thickness: 1, color: Colors.white,),
                              
                           // Container(
                           //   color: Color.fromARGB(255, 16, 223, 99),
                           //   child: Padding(
                           //     padding: const EdgeInsets.all(10.0),
                           //     child: Row(
                           //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                           //       children: [
                           //         Text('Personal Details', 
                           //         style: TextStyle(color: Colors.white, fontSize: 18),),
                           //         Text('Change Password',
                           //          style: TextStyle(color: Colors.white, fontSize: 18),)
                           //       ],
                           //     ),
                           //   ),
                           // ),
                                                      SizedBox(height: 30,),
                 
                         
                             Text("Change Password", 
                             style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                             ),
                                                        SizedBox(height: 30,),
                 
                             TextField(
                               controller: _oldPassword,
                               decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(bottom: 15),
                                 labelText: 'Old Password',
                                 labelStyle: TextStyle(fontSize: 16)
                               )
                             ),
                                                        SizedBox(height: 30,),
                 
                               TextField(
                                 controller: _newPassword,
                               decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(bottom: 15),
                                 labelText: 'New Password',
                                 labelStyle: TextStyle(fontSize: 16)
                               )
                             ),
                             SizedBox(height: 30,),
                               TextField(
                                 controller: _newPassword,
                               decoration: InputDecoration(
                                   contentPadding: EdgeInsets.only(bottom: 15),
                                 labelText: 'Confirm Password',
                                 labelStyle: TextStyle(fontSize: 16)
                               )
                             ),
                           ]
                           ),
                         ),
                             SizedBox(height: 30,),
                 
                   ElevatedButton(onPressed: (){
                             savePassword(_oldPassword.text,
                               _newPassword.text,
                                
                                ) ;
                 
                 
                 
                 
                 
                          log('not equal');
                          
                          log('equal');
                 
                             showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          
                      title:  Column(
                            children: [
                              Icon(Icons.check_box,
                              size: 65,
                               color: Colors.green,),
                              Center(child: Text("Success !!", 
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),)),
                            ],
                          ),
                          content: Text("Your Password has been change successfully",style: TextStyle(fontSize: 17), ),
                          actions: <Widget>[
                            
                            FlatButton(
                              color: Colors.green,
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child:  Container(
                                height: 20,
                                width: 20,
                                child: Center(child: Text("Ok"))),
                            ),
                          ],
                        ),
                      );
                      log( _newPassword.text+" "+_oldPassword.text);
                   },
                              child: Text('Save',
                              style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: EdgeInsets.symmetric(horizontal: 160, ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                              ),                            ), 
                 
                       ],
                     ),
                   ),
                   ),
                 ),

    );
  }
}