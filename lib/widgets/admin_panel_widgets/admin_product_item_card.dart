import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

import '../custom_menu.dart';


class AdminProductItemCard extends StatelessWidget {

  final List<Product> products;
  final int productIndexInList;
  final Function functionForEditButton;
  final Function functionForDeleteButton;
  final bool showMenuOrNot=true;

  AdminProductItemCard({this.products,this.productIndexInList,
    this.functionForDeleteButton,
    this.functionForEditButton});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: GestureDetector(
        onTapUp: (details)

        {

          double dx= details.globalPosition.dx;
          double dy= details.globalPosition.dy;
          double dx2 = MediaQuery.of(context).size.width-dx;
          double dy2=MediaQuery.of(context).size.width-dy;

          showMenu(context: context,
              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),

              items:[
               MyPopUpMenuItem(child: Text('Edit'),function: functionForEditButton,),
               MyPopUpMenuItem(child: Text('Delete'),function: functionForDeleteButton,),


              ] );

        }
        ,
        child: Stack(
          children: <Widget>[

            Positioned.fill(child: Image.network(
              products[productIndexInList].location,
              fit: BoxFit.fill,
            )),

            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(products[productIndexInList].name,style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),),
                      Text('\$'+products[productIndexInList].price,style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ))

                    ],
                  ),

                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}





