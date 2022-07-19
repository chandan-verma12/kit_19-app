import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../model/user_data.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

 PickedFile? _image;
final ImagePicker _picker = ImagePicker();

   Future<File?>  getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
          _image = image as PickedFile;
    });
   final File? file = File(image!.path);
    return file;

  }
    Future<File?>  getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    // _image = image as PickedFile;
    final File? file = File(image!.path);
    return file;
  }

    String? call_setting;
    bool isSubmitOnPressed = false;
    bool isPhoneOnPressed = false;

    // File image;
var _email = TextEditingController();
var _companyName = TextEditingController();
var _phone = TextEditingController();
var _address = TextEditingController();
var _site = TextEditingController();
var _countryCode = TextEditingController();
var _time = TextEditingController();

         void editInformation(
          String _email, 
           String _companyName,
           String _phone,
           String _address,
           String _site,
           String call_setting,
           String _time,
           String _countryCode

         ) async{
var body =  
{
  "Status": "",
  "Message": "",
  "Token": 637937724907177678,
  "Details": {
    "User_ID": 32222,
    "FName": "Abhishek",
    "LName":"Kumar",
    "email":"abhi@kit19.com",
    "CountryCode":"+91",
    "Mobile":"7011677850",
    "companyname":"abhishek.kumar@pelsoftlabs.in",
    "Image":"Users/32222/profile.png"
  }
};
   
Response response = await post(
        Uri.parse('https://services.kit19.com/Admin/SaveProfileData'), body: jsonEncode(body),
        headers: {
          "Content-type":"application/json"
        }
      );
        log(response.toString());


      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data.toString());
        print('added successfully');
        
      }else {
        log("Failed");
      }
      

         }

         

 Future<GetProfileDetails> editProfileData() async {
    var url = 'https://services.kit19.com/Admin/GetProfileDetail';
    // pass headers parameters if any
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
  {
   "Status": "",
   "Message": "",
   "Token":  637937724907177678,
     "Details": {
    "UserId": 32222
}

}


      ),
    );
    var data = jsonDecode(response.body.toString());
    // print("notes id ${data!.details![index].NoteId}");
    if (response.statusCode == 200) {
      print('url hit successful' + response.body);
      String data = response.body;

      var dataList = GetProfileDetails.fromJson(jsonDecode(response.body));
      return dataList;
    } else {
      print('failed to get data');
      throw Exception('Failed to get data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: FutureBuilder<GetProfileDetails>(
                    future:
                        editProfileData(),// here get_datacall()  can be call directly
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                            print(" show data on screen " +
                                snapshot.data.toString());
                        
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                         }
                        return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {

                    return Column(
                      children: [
                        
                        Center(
                          child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                            
              _image == null
                  ? log("No Image is picked")
                  : Image.network(_image.toString(), color: Colors.red,);
              
                               
                            },
                            child: Container(
                                decoration: BoxDecoration(
                               border: Border.all(width: 2, color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  )
                                ],
                                shape: BoxShape.circle,
                               
                              ),
                               child: CircleAvatar(
                                radius: 45,
                               backgroundImage: Image.network("https://docs.kit19.com/Users/32222/profile.png").image,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: 95,
                          //   height: 95,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(width: 2, color: Colors.black),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         spreadRadius: 2,
                          //         blurRadius: 10,
                          //         color: Colors.black.withOpacity(0.1),
                          //       )
                          //     ],
                          //     shape: BoxShape.circle,
                          //     image: DecorationImage(
                          //       // fit: BoxFit.cover,
                          //       image: Image.network(snapshot.data!.details!.image.toString()).image
                          //       ),
                              
                          //   ),
                          
                          // ),

                          Positioned(
                            bottom: 57,
                            left: 55,
                            child: Container(
                           height: 40,
                           width: 40,
                           decoration: BoxDecoration(
                            color: Colors.white,
                            shape : BoxShape.circle,
                            border: Border.all(width: 1.5, color: Colors.black),
                           ),
                           child: IconButton(onPressed:  getImageFromCamera,
                            icon: Icon(Icons.camera_alt_outlined, color: Colors.black,))
                           //Icon(Icons.camera_alt_outlined, color: Colors.black,),
                            )
                          
                          )
                        ],
                          ),
                        ),

                      Text(snapshot.data!.details!.firstName.toString()
                      + "  "+ snapshot.data!.details!.lastName.toString(),
                      style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
                      ),

                      Text('Last Login -  '+snapshot.data!.timsStamp.toString()),

                        SizedBox(height: 10,),
                   //    buildTextField(Icon(Icons.mark_as_unread, color: Colors.grey,) ,snapshot.data!.details!.emailId.toString()),
                  
                  SingleChildScrollView(
                    child: Container(
                      height: 600,
                      child: Column(
                        children: [
                          Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                     prefixIcon: Icon(Icons.mark_as_unread, color: Colors.grey,),                     
                                    suffixIcon: 
                                    IconButton(onPressed: (){},
                                     icon: Icon(Icons.edit_outlined, color: Colors.grey,),
                                     ),
                                     floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintText: snapshot.data!.details!.emailId,
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
                                  ),
                                   onChanged: (value) {
                                          setState(() {
                                            snapshot.data!.details!.emailId = value.toString();
                                          });
                                        },
                                ),
                                ),
                      

                        Padding(
                           padding: const EdgeInsets.only(bottom: 10),
                           child: TextField(
                            controller: _companyName,
                            onChanged: (value) {
                setState(() {
                  snapshot.data!.details!.companyName = value.toString();
                });
              },
                           decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city_outlined, color: Colors.grey,),
                             suffixIcon: 
            IconButton(onPressed: (){
             
            },
             icon: Icon(Icons.edit_outlined, color: Colors.grey,),
             ),
                hintText: snapshot.data!.details!.companyName,
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
                           ),
                           ),
                         ),
                       
                         Padding(
                           padding: const EdgeInsets.only(bottom: 10),
                           child: TextField(
                            controller: _countryCode,
                            keyboardType: TextInputType.number,
                             onChanged: (value) {
                setState(() {
                  snapshot.data!.details!.countryCode;snapshot.data!.details!.mobileNo = value.toString();
                });
              },
                           decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_rounded, color: Colors.grey,),
                             suffixIcon: 
            IconButton(onPressed: (){
              setState(() {
              // isPhoneOnPressed = true 
              // ? Icon(Icons.edit_outlined)
              // : Text('data')
              });
            },
             icon: Icon(Icons.edit_outlined, color: Colors.grey,),
             ),
                hintText: snapshot.data!.details!.countryCode!+snapshot.data!.details!.mobileNo.toString(),
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
                           ),
                           ),
                         ),

                      //  buildTextField(Icon(Icons.location_on, color: Colors.grey,) ,snapshot.data!.details!.city.toString(),),
                       Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: _address,
           onChanged: (value) {
                setState(() {
                  snapshot.data!.details!.address = value.toString();
                });
              },
        //  obscureText: passwordTextField ? isObsecurePassword : false,
          decoration: InputDecoration(
             prefixIcon: Icon(Icons.location_on, color: Colors.grey,), 
           
            suffixIcon: 
            IconButton(onPressed: (){},
             icon: Icon(Icons.edit_outlined, color: Colors.grey,),
             ),
                hintText: snapshot.data!.details!.country,
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
          )
        ),
        ),
                        //  buildTextField(Icon(Icons.network_check, color: Colors.grey,) ,snapshot.data!.details!.companyName.toString(), ),
                         Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: _site,
           onChanged: (value) {
                setState(() {
                  snapshot.data!.details!.companyName = value.toString();
                });
              },
        //  obscureText: passwordTextField ? isObsecurePassword : false,
          decoration: InputDecoration(
             prefixIcon: Icon(Icons.network_check, color: Colors.grey,), 
           
            suffixIcon: 
            IconButton(onPressed: (){},
             icon: Icon(Icons.edit_outlined, color: Colors.grey,),
             ),
               hintText: snapshot.data!.details!.companyName,
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
          )
        ),
        ),
                       
                           Padding(
                             padding: const EdgeInsets.only(bottom: 10, left: 18),
                             child: TextField(
                          controller: _time,
                           onChanged: (value) {
                setState(() {
                  snapshot.data!.details!.timezone = value.toString();
                });
              },
                             decoration: InputDecoration(
             contentPadding: EdgeInsets.only(bottom: 5),
             floatingLabelBehavior: FloatingLabelBehavior.always,
            
             labelText: 'TimeZone',
             labelStyle: TextStyle(
              fontSize: 20,
              letterSpacing: 3,

              color: Colors.black,
              fontWeight: FontWeight.bold
             ),
             hintText: snapshot.data!.details!.timezone,
                                     hintStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                     )
          ),
                             ),
                           ),

                        

             SizedBox(height: 4,) ,             

Padding(
  padding: const EdgeInsets.only(left: 20,),
  child:   Row(
  
          mainAxisAlignment: MainAxisAlignment.start,
  
          children: <Widget>[
  
             Text("Call Setting \n", style: TextStyle( 
                  
                   fontSize: 16, 
                   fontWeight: FontWeight.bold,
                   letterSpacing: 1
  
                  ),),
  
  
  
            new Radio(
              value: 'sim',
              groupValue: call_setting,
              onChanged: (value){
                          setState(() {
                             call_setting = value.toString();
                          });
              }
            ),
            new Text('SIM'),
             Radio(
              value: 'voip',
              groupValue: call_setting,
              onChanged: (value){
                          setState(() {
                             call_setting = value.toString();
                          });
              }
            ),
            new Text('VOIP'),
          ],
        ),
),
                         ElevatedButton(onPressed: (){
                          setState(() {
                            isSubmitOnPressed == true
                            ?       showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                   title: 
                   Column(
                        children: [
                          Icon(Icons.cancel_outlined,
                          size: 65,
                           color: Colors.red,),
                          Center(child: Text("OOPS !!", 
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),)),
                        ],
                      ),
                      
                      content: Text("SomeThing Went wrong your mobile number is not updated successfully!! please try again. ",style: TextStyle(fontSize: 17), ),
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
                            ) 
                   
                  
                            :  
                            showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                      title:  Column(
                        children: [
                          Icon(Icons.check_circle_outline_outlined,
                          size: 65,
                           color: Colors.green,),
                          Center(child: Text("Congratulations", 
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),)),
                        ],
                      ),
                      content: Text("Your mobile number has been updated successfully",style: TextStyle(fontSize: 17), ),
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
                            ) ;
                          });
                        
                           setState(() {
                            isSubmitOnPressed == true;

                            editInformation(
                          _email.text.toString(),
                             _companyName.text.toString(), 
                             _phone.text.toString(),
                          _address.text.toString(), 
                          _site.text.toString(),
                           call_setting.toString(), 
                           _time.text.toString(),
                             
                            _countryCode.text.toString()
                           );

                          
                           });
                           log(_address.text+" "+_companyName.text+" "+_countryCode.text
                           +" "+_email.text+" "+_picker.toString()+" "+_phone.text+" "+_time.text
                          +" "+_site.text+" "+call_setting.toString()
                           );

                           
                        
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
                            padding: EdgeInsets.symmetric(horizontal: 150, ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ), 
                                                     ), ],
                      ),
                    )
                                                     
                    ),
                      ]
                    );
                   }
                            );
                    
              
                      // By default, show a loading spinner
                      return  Center(child: CircularProgressIndicator());
                    
                    },
              ),
              )
              
              ),
    );
  }

  Widget buildTextField( Icon prefixIcon, String placeholder){
      return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: TextField(
        //  obscureText: passwordTextField ? isObsecurePassword : false,
          decoration: InputDecoration(
             prefixIcon: prefixIcon, 
            suffixIcon: 
            IconButton(onPressed: (){},
             icon: Icon(Icons.edit_outlined, color: Colors.grey,),
             ),
             contentPadding: EdgeInsets.only(bottom: 5),
             floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: placeholder,
             hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
             )
          )
        ),
        );
  }
}