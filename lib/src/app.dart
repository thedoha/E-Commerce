import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/provider/model_hud.dart';
import 'package:ecom/screens/admin_screens/add_products.dart';
import 'package:ecom/screens/admin_screens/admin_home.dart';
import 'package:ecom/screens/admin_screens/edit_product_screen.dart';
import 'package:ecom/screens/admin_screens/manage_product_screen.dart';
import 'package:ecom/screens/admin_screens/order_details_screen.dart';
import 'package:ecom/screens/admin_screens/orders_screen.dart';
import 'package:ecom/screens/user_screens/cart_screen.dart';
import 'package:ecom/screens/user_screens/login_screen.dart';
import 'package:ecom/screens/user_screens/product_info_screen.dart';
import 'package:ecom/screens/user_screens/sign_up_screen.dart';
import 'package:ecom/screens/user_screens/user_home.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class App extends StatelessWidget {

  bool isUserLogedIn=false;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context,snapShot){
          if(!snapShot.hasData)
            {
              return MaterialApp(home: Scaffold(body: Center(child: Text('Loading..'),),),);
            }

          else{
            isUserLogedIn=snapShot.data.getBool(kKeepMeLog)??false ;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(create: (context)=>ModelHud()),
                ChangeNotifierProvider<CartItem>(create: (context)=>CartItem()),
              ],
              child: MaterialApp(

                home: isUserLogedIn
                    ?UserHome()
                    :LoginScreen(),//LoginScreen() ,

                routes: {

                  LoginScreen.id:(context)=>LoginScreen(),
                  SignUpScreen.id:(context)=>SignUpScreen(),
                  AdminHome.id:(context)=>AdminHome(),
                  UserHome.id:(context)=>UserHome(),
                  AddProductsScreen.id:(context)=>AddProductsScreen(),
                  ManageProductScreen.id:(context)=>ManageProductScreen(),
                  EditProductScreen.id:(context)=>EditProductScreen(),
                  ProductInfoScreen.id:(context)=>ProductInfoScreen(),
                  CartScreen.id:(context)=>CartScreen(),
                  OrdersScreen.id:(context)=>OrdersScreen(),
                  OrderDetailsScreen.id:(context)=>OrderDetailsScreen()

                },

              ),

            );}

        });
  }
}
