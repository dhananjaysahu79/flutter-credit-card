import 'dart:convert';
import 'dart:math';
import 'package:credit_card_project/methods/method.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future registerUser(name, email, password) async {
  var url = Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/auth/register');
  var response = await http.post(url, body: {'name': name, 'email': email, 'password': password});
  var decodeJSon = jsonDecode(response.body);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return [response.statusCode, decodeJSon];

}

Future loginUser(email, password) async {
  var url = Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/auth/login');
  var response = await http.post(url, body: {'email': email, 'password': password});
  var decodeJSon = jsonDecode(response.body);
  print('Response body: ${response.body}');
  return [response.statusCode, decodeJSon];
}
Future postCard(name, cardExpiration, cardHolder, cardNumber, category,token) async {
  var url = Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/cards');
  var response = await http.post(url, 
  headers: {
    'Authorization': 'Bearer $token'
  },
  body: {
    'name': name, 
    'cardExpiration': cardExpiration,
    'cardHolder' : cardHolder,
    'cardNumber' : cardNumber,
    'category' : category,
  });
  var decodeJSon = jsonDecode(response.body);
  print('Response body: ${response.body}');
  return [response.statusCode, decodeJSon];
}

Future<List> getCards(token,context) async{
  List<CardDetail> cardDetails = [];
  var url = Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/cards');
  var response = await http.get(url, 
    headers: {
      'Authorization': 'Bearer $token'
    }
  );
  var decodeJSon = jsonDecode(response.body);
  // print('Response body: ${response.body}');

  if(response.statusCode == 400 || response.statusCode == 401)
  showSnackBar(decodeJSon['message'], context);
  decodeJSon['results'].forEach((card) => {
    cardDetails.add(CardDetail(
      card["name"], 
      card["cardExpiration"], 
      card["cardHolder"], 
      card["cardNumber"], 
      card["category"], 
      colors[Random().nextInt(2)]
    ))
  });
  print(cardDetails);
  return cardDetails;
}


Future logoutUser(refreshToken, token) async {
  var url = Uri.parse('https://flutter-assignment-api.herokuapp.com/v1/auth/login');
  var response = await http.post(url, 
    headers: {
      'Authorization': 'Bearer $token'
    },
    body: {'refreshToken': refreshToken}
  );
  var decodeJSon = jsonDecode(response.body);
  print('Response body: ${response.body}');
  return [response.statusCode, decodeJSon];
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


