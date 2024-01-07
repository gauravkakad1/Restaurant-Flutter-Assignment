import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 39,
          width: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                blurRadius: 8.0, // Set the blur radius
                offset: Offset(0, 4), // Offset (dx, dy) for shadow direction
              ),
            ],
          ),
          child: Center(
              child: Text("All",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w500
                  )
              )
          ),
        ),

        Container(
            height: 39,
            width: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19.5),
              color: Color(0xFFFF5858),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                  blurRadius: 8.0, // Set the blur radius
                  offset: Offset(0, 4), // Offset (dx, dy) for shadow direction
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("images/pizza.png",height: 24,width:24,fit: BoxFit.cover,),
                Center(
                    child: Text("Pizza",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Medium",
                          fontWeight: FontWeight.w600,
                        )
                    )
                ),
              ],
            )
        ),

        Container(
          height: 39,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5),
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                blurRadius: 8.0, // Set the blur radius
                offset: Offset(0, 4), // Offset (dx, dy) for shadow direction
              ),
            ],
          ),
          child: Image.asset("images/roasted-chicken 1.png",height: 27,width:27,),

        ),
        Container(
          height: 39,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5),
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                blurRadius: 8.0, // Set the blur radius
                offset: Offset(0, 4), // Offset (dx, dy) for shadow direction
              ),
            ],
          ),
          child: Image.asset("images/salad 1.png",height: 27,width:27,),

        ),Container(
          height: 39,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5),
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Shadow color with opacity
                blurRadius: 8.0, // Set the blur radius
                offset: Offset(0, 4), // Offset (dx, dy) for shadow direction
              ),
            ],
          ),
          child: Image.asset("images/burger 1.png",height: 27,width:27,),

        ),

      ],
    );
  }
}
