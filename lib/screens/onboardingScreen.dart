
import 'package:credit_card_project/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({ Key? key }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
      ),

      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 30,),
              _buildTopRow(label: 'Skip'),
              Expanded(
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (i){
                    setState(() {
                      _currPage = i;
                    });
                  },
                  children: [
                    _onboardingPages(
                      img: "assets/images/ob1.png",
                      heading: "Manage Cards",
                      description: "Get these cool illustration from Undraw. Do Support open source community for these awesome free assets."
                    ),
                    _onboardingPages(
                      img: "assets/images/ob2.png",
                      heading: "Bill Payment",
                      description: "Get these cool illustration from Undraw. Do Support open source community for these awesome free assets."
                    ),
                    _onboardingPages(
                      img: "assets/images/ob3.png",
                      heading: "Secure Wallet",
                      description: "Get these cool illustration from Undraw. Do Support open source community for these awesome free assets."
                    )
                  ],
                )
              ),
              _buildBottomRow(label: 'Next')
            ],
          ),
        ),
      ),
    );
  }
  
  int _currPage = 0;
  PageController _controller = PageController();

  Column _circleLine(int i){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:  i == _currPage ? Color(0xFF6C63FF): Colors.white
          ),
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:  i == _currPage ? Colors.white: Colors.grey,
            ),       
          ),
        ),
        Container(
          height: 2,
          width: 18,
          color: i == _currPage ? Color(0xFF6C63FF): Colors.white,
        )
    ],);
  }

  Container _pageMarker() {
    return Container(
      width: 70,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           _circleLine(0),
           _circleLine(1),
           _circleLine(2)
        ],
      ),
    );
  }

  Column _onboardingPages(
    {required String img,
    required String heading,
    required String description}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Container(
             height: 300,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage(img)
                )
             ),
           ),

            Text(
                heading,
                style: TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Flexible(
             child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
              ),
           ),
        ],
      );
    }


  // var buttonWidth = 1;
  Row _buildTopRow(
    {required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
          onPressed: (){
            setState(() {
              _controller.animateToPage(
                2, 
                duration: Duration(milliseconds: 100), 
                curve: Curves.decelerate,
              );
            });
          }, 
          child: Text(
              '$label',
              style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
        )
        ),
      ],
    );
  }

  Padding _buildBottomRow(
    {required String label}){
      var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
      _currPage == 2? ElevatedButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        ),
       style: ButtonStyle(
          elevation: MaterialStateProperty.all(4.0),
          backgroundColor: MaterialStateProperty.all(Color(0xFF6C63FF)),
        ),
      child: Container(
        alignment: Alignment.center,
        width: width/1.3,
        child: Text(
              'GET STARTED',
              style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
      ),
      )
      :Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pageMarker(),

          ElevatedButton.icon(
            onPressed: (){
              _controller.nextPage(
                duration: Duration(milliseconds: 100), 
                curve: Curves.decelerate,
              );
            }, 
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(4.0),
              backgroundColor: MaterialStateProperty.all(Color(0xFF6C63FF)),
            ),
            
            label: Text(
                '$label',
                style: TextStyle(
                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            icon: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 15,), 
          )
        ],
      ),
    );
  }
}