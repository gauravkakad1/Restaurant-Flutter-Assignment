import 'package:flutter/material.dart';

class RestaurantsContainer extends StatefulWidget {

  final String name ;
  final double rating ;
  final int discount ;
  final String img ;
  const RestaurantsContainer({
    super.key, required this.name, required this.rating, required this.discount, required this.img
  });

  @override
  State<RestaurantsContainer> createState() => _RestaurantsContainerState();
}

class _RestaurantsContainerState extends State<RestaurantsContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children:[
            Container(
            height: 130,
            width: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(11),topLeft: Radius.circular(11)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                  blurRadius: 10.0, // Set the blur radius
                  offset: Offset(4, 6), // Offset (dx, dy) for shadow direction
                ),
              ],
            ),
            // child: Image.asset('images/pizza.png',fit: BoxFit.fill,),
              child: Image.network(widget.img,fit: BoxFit.fill,),
          ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                height: 20,width: 34,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFF1BC400),),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.rating.toString(),style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w700,fontSize: 11),),
                    Icon(Icons.star_rate , color: Colors.white,size: 9,)
                  ],
                ),
              ),
            )
        ]
        ),
        Container(
          height: 53,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(11),bottomLeft: Radius.circular(11)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                blurRadius: 10.0, // Set the blur radius
                offset: Offset(4, 6), // Offset (dx, dy) for shadow direction
              ),
            ],
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24,left:8 ),
                child: Text(widget.name.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: "Poppins-Medium"),),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Image.asset('images/Discount.png',height: 27,width: 27,),
                    Text("${widget.discount.toString()} FLAT OFF",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,fontFamily: "Poppins-Medium",color: Color(0xFFFF0000))),
                  ],
                ),
              )
            ],
          )
        ),
        SizedBox(height: 23,)
      ],
    );
  }
}
