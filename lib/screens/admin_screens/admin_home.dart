import 'package:ecom/screens/admin_screens/add_products.dart';
import 'package:ecom/screens/admin_screens/manage_product_screen.dart';
import 'package:ecom/screens/admin_screens/orders_screen.dart';
import 'package:ecom/src/constants.dart';
import 'package:flutter/material.dart';



class AdminHome extends StatelessWidget {

  static String id= 'admin_home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(width: double.infinity,),

          RaisedButton(
            child: Text('Add product '),
            onPressed: (){Navigator.pushNamed(context, AddProductsScreen.id);},
          ),

          RaisedButton(
            child: Text('Edit Products'),
            onPressed: (){Navigator.of(context).pushNamed(ManageProductScreen.id);},
          ),

          RaisedButton(
            child: Text('view orders'),
            onPressed: (){
              Navigator.pushNamed(context, OrdersScreen.id);
            },
          ),



        ],

      ),

    );
  }
}
