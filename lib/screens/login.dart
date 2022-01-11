import 'package:credit_card_project/methods/apirequests.dart';
import 'package:credit_card_project/methods/method.dart';
import 'package:credit_card_project/screens/homepage.dart';
import 'package:credit_card_project/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {


    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // this below line is used to make notification bar transparent
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
     
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/images/Logo.png",fit: BoxFit.cover,)),
          SingleChildScrollView(
            child: Column(
                
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: height/5,),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 27.0,
                    color: Color(0xFF081603),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Join Mr BookWorm!',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF081603),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.email,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black87
                              )
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Color(0xFF081603),),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 22,
                              width: 22,
                              child: Icon(
                                Icons.vpn_key,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: TextField(
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Color(0xFF081603),
                            ),
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Color(0xFF081603),),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ElevatedButton(
                    onPressed: () async{ 
                      
                      List res = await loginUser(emailController.text, passwordController.text);
                      if(res[0] == 400 || res[0] == 401)
                      showSnackBar(res[1]['message'], context);
                      else
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(res[1]))
                       );
                     },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(4.0),
                      backgroundColor:  MaterialStateProperty.all(Color(0xFF081603)),
                      shape:  MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                      )
                    ),
                    child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Center(
                      child: Text(
                        "Don't have an account",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF081603),),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          "Create account",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF081603),
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}