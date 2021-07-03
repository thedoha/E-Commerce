import 'package:ecom/models/product.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/string_constants.dart';
import 'file:///E:/AndroidProjects/e_com/lib/widgets/user_screens_widgets/log_screen_widgets.dart';
import 'package:flutter/material.dart';



class AddProductsScreen extends StatelessWidget {


 static String id = 'add_products_screen';
  final store=Store();
  String name,price,Description,category,location;
  final GlobalKey<FormState> _globalKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

     final height =MediaQuery.of(context,).size.height;

     return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Form(
        key: _globalKey,

        child: ListView(

          children: <Widget>[


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
              child: Text('Information of the Product: ',
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            ),


            Container(
              height: height*0.6,
              child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  LogCustomTextField(hintText: 'Product Name',

                    function: (value){name=value;}, ),

                  LogCustomTextField(hintText: 'Product price', function: (value){price=value;}, ) ,

                  LogCustomTextField(hintText: 'Product describtion', function: (value){Description=value;}, ) ,
                  LogCustomTextField(hintText: 'Product category' , function: (value){category=value;},) ,
                  LogCustomTextField(hintText: 'Product location' , function: (value){location=value;},) ,

                  RaisedButton(
                      child: Text('Add product'),
                      onPressed: (){

                        if(_globalKey.currentState.validate())
                          {
                            _globalKey.currentState.save();
                            _globalKey.currentState.reset();


                            store.addProduct(Product(
                              name: name,
                              category: category,
                              describtion: Description,
                              location: location,
                              price: price
                            ));



                          }


                      }



                      )

                ],
              ),
            ) ,


          ],
        ),
      ) ,

    );
  }
}
