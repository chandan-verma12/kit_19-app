import 'package:flutter/material.dart';
import 'package:kit_19/ui/profiles/change_password.dart';
import 'package:kit_19/ui/profiles/edit_profile.dart';

class ProEdit extends StatelessWidget {
  const ProEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Profile"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
            },
          ),
        
        actions: [
         
          IconButton(onPressed: (){}, icon: Image.asset("assets/icons/logout.png")),
        ],
        backgroundColor: Color.fromARGB(255, 26, 213, 101),
        leadingWidth: 26,
            bottom: TabBar(
              indicatorColor: Colors.black,

              tabs: [
                Tab(text: 'Personal Details',),
                Tab(text: 'Change Password',),
              ],
            ),
          ),
          body: TabBarView(
            children: [
             FirstScreen(),
             SecondScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
 
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: 
            EditProfile(),
            
          );
  }
}
 
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ChangePassword()
            )
          );
  }
}
 