import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_flutter_assignment/apis.dart';
import 'package:restaurant_flutter_assignment/components/restaurantsContainer.dart';

import 'components/categoryRow.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  double? lat;
  double? lng;
  String? locationName;
  List<Map<String,dynamic>> restaurantData=[];


  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // user denied permission
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // user permanently denied permission
      return;
    }
  }

  Future<void> fetchUserLocation() async {

    // getting lat and log
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double latitude = double.parse(position.latitude.toStringAsFixed(2));
      double longitude = double.parse(position.longitude.toStringAsFixed(2));
      print('Latitude: $latitude, Longitude: $longitude');


      // geting location name
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude ?? latitude,
          longitude ?? longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          setState(() {
            lat = latitude;
            lng=longitude;
            locationName = '${placemark.subThoroughfare} ${placemark.thoroughfare}';
          });
          print('Location Name: $locationName');
        } else {
          print('No location name available');
        }
      } catch (e) {
        print('Error getting location : $e');
      }

    } catch (e) {
      print('Error getting location: $e');
    }


  }

  void getApiResponse()async{
    var response = await http.post(Uri.parse(Api_Url),
        body: jsonEncode(
            {
              "lat": lat,
              "lng": lng
            }
        )
    );
    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse['status']=='SUCCESS'){
        List<Map<String, dynamic>> RestaurantData = List.from(jsonResponse['data']);
        setState(() {
          restaurantData = RestaurantData;
        });
      }
    }else{
      print("StatusCode :  ${response.statusCode}");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationPermission();
    fetchUserLocation();
    getApiResponse();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE1E1), Color(0x00FFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          )
          ),
          SingleChildScrollView(
            child: SafeArea(
                child:  Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(locationName.toString(),
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: "Poppins-Regular"),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    CategoryRow(),
                    SizedBox(height: 20,),
                    Container(
                      height: 51,
                      width: 344,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          )
                        ]
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Search food item',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(25.5),
                          ),
                        ),
                      )
                      ),
                    SizedBox(height: 20,),
                    Align(alignment: Alignment.centerLeft,child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("Nearby Restaurants",style: TextStyle(fontFamily: 'Poppins-Medium',fontWeight: FontWeight.w600),),
                    )),
                    SizedBox(height: 20,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: restaurantData.length,
                      itemBuilder: (context, index) {
                        return RestaurantsContainer(name: restaurantData[index]['name'],discount: restaurantData[index]['discount'],rating: restaurantData[index]['rating'],img: restaurantData[index]['primary_image'],);
                      },
                    ),

                    RestaurantsContainer(name: 'Chaayos',discount: 28,rating: 3.4,img: "https://theoptimiz.com/restro/public/Resturants/chaayos.png"),
                    RestaurantsContainer(name: 'Domino s',discount: 25,rating: 4.8,img: "https://theoptimiz.com/restro/public/Resturants/dominos.png"),
                    RestaurantsContainer(name: 'Chaayos',discount: 28,rating: 3.4,img: "https://theoptimiz.com/restro/public/Resturants/chaayos.png"),
                    RestaurantsContainer(name: 'Chaayos',discount: 28,rating: 3.4,img: "https://theoptimiz.com/restro/public/Resturants/chaayos.png"),
                    RestaurantsContainer(name: 'Chaayos',discount: 28,rating: 3.4,img: "https://theoptimiz.com/restro/public/Resturants/chaayos.png"),

                  ],
                )
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color(0xFFC90000),
          unselectedItemColor: Color(0xFFD37272),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/menu.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("images/play.png"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: 62,
                  width: 62,
                  decoration: BoxDecoration(
                    color: Color(0xFFC90000),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(-2, -4),
                      ),
                    ],
                  ),
                  child: Image.asset('images/free_icon_1 1.png')),
              label: '', // No label for the center item
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/profile.png'),
              label: '',
            ),
          ],
        ),
      ),


    );
  }
}













