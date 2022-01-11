import 'dart:io';
import 'dart:math';
import 'package:credit_card_project/methods/apirequests.dart';
import 'package:credit_card_project/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:credit_card_project/methods/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  final userData;
  const HomePage(this.userData, { Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
      ),

    child:Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:  35,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back!",style: TextStyle(color: Colors.black54,fontSize: 15, fontWeight: FontWeight.w700),),
                    Text(widget.userData['user']['name'],
                      style: TextStyle(color: Colors.black87,fontSize: 17, fontWeight: FontWeight.w900),
                    ),

                  ],
                ),

                IconButton(
                  onPressed: (){
                    logoutUser(
                      widget.userData['tokens']['refresh']['token'],
                      widget.userData['tokens']['access']['token']
                    );
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }, 
                  icon: Icon(Icons.logout_outlined, color: Colors.black,)
                )
              ],
            ),
          ),


        // cards.length == 0 ? 
        // Container(
        //   height: 150,
        //   alignment: Alignment.center,
        //   child: Text("No Cards to show"),
        // ): 
        Container(
          height: 250,
          width: double.infinity,
          child: FutureBuilder(
            future: getCards(widget.userData['tokens']['access']['token'], context),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
              else if(snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());
                  else if(snapshot.hasData)
                  return PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i){
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: buildCreditCard(
                        color: snapshot.data![i].color, 
                        cardNumber: snapshot.data![i].cardNumber, 
                        cardHolder: snapshot.data![i].cardHolder.toUpperCase(), 
                        cardExpiration: snapshot.data![i].cardexpiration
                      ),
                    );
                  });
                  else return Text('Something went wrong!');
              }
             else return Text('Something went wrong!');
            }
          ),
        ),
          _buildAddCardButton(
            icon: Icon(Icons.add),
            color: Color(0xFF081603),
          )
        ],
      )
     ) 
    );
  }


  // Build the FloatingActionButton
  Container _buildAddCardButton({
    required Icon icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          pickImage();
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }


   var _imgFile;
   Future pickImage() async{
    final selected = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    setState((){
      if(selected != null){
        _imgFile = File(selected.path);
        createCardData();
      }
      else if(_imgFile == null){
        showSnackBar("Please Click an image.", context);
      }
    });
  }

  List<CardDetail> cards = [];
  

  Future createCardData() async{
    String name = 'HDFC-Card' + Random().nextInt(30).toString();
    String cardExpiration = Random().nextInt(12).toString()+ '/'+ (2022 + Random().nextInt(50)).toString();
    String cardHolder = widget.userData['user']['name'];
    String cardNumber = "3546 7532 9742 "+ (3546 + Random().nextInt(6453)).toString();
    String category = 'MC';
    String token = widget.userData['tokens']['access']['token'];
    List res = await postCard(name, cardExpiration, cardHolder, cardNumber, category, token);
    // if(res[0] == 400 || res[0] == 401)
    // showSnackBar(res[1]['message'], context);
    // else
    setState(() {
      cards.add(CardDetail(name,cardExpiration,cardHolder,cardNumber, category,colors[Random().nextInt(2)]));
    });
  }
}

class CardDetail{
  String name;
  String cardexpiration;
  String cardHolder;
  String cardNumber;
  String category;
  Color color;
  
  CardDetail(this.name, this.cardexpiration, this.cardHolder, this.cardNumber, this.category,this.color);
}