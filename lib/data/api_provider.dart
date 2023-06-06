import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:koshpendiler/model/animal.dart';
import 'package:koshpendiler/model/card_model.dart';
import 'package:koshpendiler/model/profile_model.dart';

import '../model/Place.dart';

var tokenBox = Hive.box('tokens');

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._internal();

  factory ApiProvider() {
    return _singleton;
  }

  ApiProvider._internal();
  final String _baseUrl = 'http://195.210.47.211/api/';
  String token =
      tokenBox.isNotEmpty ? tokenBox.get('accessToken') as String : 'qwerty';

  Future<bool> orderPlace(int id) async {
    print('STARTED LOGIN USER api method');
    token = tokenBox.get('accessToken');
    final response = await http.post(
      Uri.parse(_baseUrl + 'places/$id/order'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print('RESPONSE STATUS CODE IS ${response.statusCode}');
    print(
        'RESPONSE STATUS BODY IS ${jsonDecode(utf8.decode(response.bodyBytes))}');
    return response.statusCode == 200;
  }

  Future<bool> login(String email, String password) async {
    print('STARTED LOGIN USER api method');
    final response = await http.post(
      Uri.parse(_baseUrl + 'login'),
      body: {
        "email": email,
        'password': password,
      },
    );
    print('RESPONSE STATUS CODE IS ${response.statusCode}');
    print(
        'RESPONSE STATUS BODY IS ${jsonDecode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      token = jsonDecode(utf8.decode(response.bodyBytes))['access_token'];
      print('ACCESS TOKEN IS ${token}\n');
      print('STARTING PUTTING TO BOX');
      tokenBox.put('accessToken', token);
    }
    return response.statusCode == 200;
  }

  Future<bool> register(
      String email, String password, String name, String phone) async {
    print('STARTED REGISTER USER api method');
    final response = await http.post(
      Uri.parse(_baseUrl + 'register'),
      body: {
        "email": email,
        'password': password,
        'full_name': name,
        'phone': phone,
      },
    );
    print('RESPONSE STATUS CODE IS ${response.statusCode}');
    print(
        'RESPONSE STATUS BODY IS ${jsonDecode(utf8.decode(response.bodyBytes))}');
    return response.statusCode == 200;
  }

  Future<List<Place>?> getAllPLaces() async {
    print('GET ALL PLACES API');
    List<Place> allPlaces = [];
    token = tokenBox.get('accessToken');
    final response = await http.get(
      Uri.parse(_baseUrl + 'places'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print('GET ALL PLACES API STATUS CODE ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> allPLACESData = jsonDecode(utf8.decode(response.bodyBytes));
      // print(allPLACESData);
      for (var e in allPLACESData) {
        int id = e['id'];
        String name = e['name'] ?? 'NULL ERROR';
        String image = e['image'] ?? 'NULL ERROR';
        String location_short = e['location_short'] ?? 'NULL ERROR';
        String body = e['body'] ?? 'NULL ERROR';
        String duration = e['duration'] ?? 'NULL ERROR';
        String distance = e['distance'] ?? 'NULL ERROR';
        String level = e['level'] ?? 'NULL ERROR';
        String cost = (e['cost'] ?? -1).toString();
        String to_destination = e['to_destination'] ?? 'NULL ERROR';
        String with_you = e['with_you'] ?? 'NULL ERROR';
        String location = e['location'] ?? 'NULL ERROR';
        String created_at = e['created_at'] ?? 'NULL ERROR';
        allPlaces.add(
          Place(
            id: id,
            image: image,
            name: name,
            location_short: location_short,
            body: body,
            duration: duration,
            distance: distance,
            level: level,
            cost: cost,
            to_destination: to_destination,
            with_you: with_you,
            location: location,
            created_at: created_at,
          ),
        );
      }
      return allPlaces;
    } else {
      print(tokenBox.isEmpty);
      tokenBox.clear();
      print(tokenBox.isEmpty);
    }
    return null;
  }

  Future<List<Animal>?> getAllAnimals() async {
    List<Animal> animals_list = [];
    print('GET ALL ANIMALS API');
    token = tokenBox.get('accessToken');
    final response = await http.get(
      Uri.parse(_baseUrl + 'animals'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print('GET ALL ANIMALS API STATUS CODE ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> allAnimalsData =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var e in allAnimalsData) {
        int id = e['id'];
        String name = e['name'];
        // var imaegs = e['images'].toString().replaceAll('\\', '');
        // print(imaegs);
        List<String> ims = [];
        List<dynamic> images =
            jsonDecode(e['images'].toString().replaceAll('\\', ''))['images'];
        for (var i in images) {
          ims.add(i.toString());
        }
        print('done');
        String created_at = e['created_at'];
        animals_list.add(
          Animal(
            id: id,
            name: name,
            images: ims,
            created_at: created_at,
          ),
        );
      }
      return animals_list;
    }
    return null;
  }

  Future<ProfileModel?> getProfileMe() async {
    print('GET PROFILE ME API');
    token = tokenBox.get('accessToken');
    print('PROFILE TOKEN $token');
    final response = await http.post(
      Uri.parse(_baseUrl + 'me'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print('GET PROFILE ME API STATUS CODE ${response.statusCode}');
    if (response.statusCode == 200) {
      Map<String, dynamic> e = jsonDecode(utf8.decode(response.bodyBytes));
      int id = e['id'];
      String? full_name = e['full_name'];
      String? email = e['email'];
      String? phone = e['phone'];
      String? gender = e['gender'];
      String? birthString = e['birth'];
      DateTime? birth = birthString != null
          ? DateTime.parse(birthString.substring(0, 10))
          : null;

      String? image = e['image'];
      print('done profile');

      ProfileModel me = ProfileModel(
        id: id,
        full_name: full_name,
        email: email,
        phone: phone,
        gender: gender,
        image: image,
        birth: birth,
      );
      print(me);
      return me;
    }
    return null;
  }

  Future<bool> updateProfile(ProfileModel me, String password) async {
    print('STARTED UPDATE PROFILE api method');
    print(me.toString());
    print(password);
    print(me.birth.toString().substring(0, me.birth.toString().length - 4));
    token = tokenBox.get('accessToken');
    print('PROFILE TOKEN $token');

    final response = await http.post(
      Uri.parse(_baseUrl + 'register'),
      headers: {
        "Authorization": "Bearer $token",
      },
      body: {
        "email": me.email,
        'password': password,
        'full_name': me.full_name,
        'phone': me.phone,
        'gender': me.gender,
        'birthday':
            me.birth.toString().substring(0, me.birth.toString().length - 4),
      },
    );
    print('RESPONSE UPDATE PROFILE STATUS CODE IS ${response.statusCode}');
    print(
        'RESPONSE UPDATE PROFILE STATUS BODY IS ${jsonDecode(utf8.decode(response.bodyBytes))}');
    return response.statusCode == 200;
  }

  Future<bool> cardSave(CardModel cm) async {
    print('STARTED SAVE CARD api method');
    print(cm.toString());
    // print(me.birth.toString().substring(0, me.birth.toString().length - 4));
    token = tokenBox.get('accessToken');
    print('PROFILE TOKEN $token');

    final response = await http.post(
      Uri.parse(_baseUrl + 'card/save'),
      headers: {
        "Authorization": "Bearer $token",
      },
      body: {
        "user_id": cm.user_id,
        'full_name': cm.full_name,
        'number': cm.number,
        'date': cm.date,
        'cvc': cm.cvc,
      },
    );
    print('RESPONSE SAVE CARD STATUS CODE IS ${response.statusCode}');
    print(
        'RESPONSE SAVE CARD STATUS BODY IS ${jsonDecode(utf8.decode(response.bodyBytes))}');
    return response.statusCode == 200;
  }
}
