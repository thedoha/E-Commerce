import 'package:ecom/models/product.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/string_constants.dart';
import 'file:///E:/AndroidProjects/e_com/lib/widgets/user_screens_widgets/log_screen_widgets.dart';
import 'package:flutter/material.dart';



class EditProductScreen extends StatelessWidget {

  static String id = 'edit_products_screen';

  final store=Store();
  // ignore: non_constant_identifier_names
  String name,price,Description,category,location;

  final GlobalKey<FormState> _globalKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Product receivedProduct =ModalRoute.of(context).settings.arguments;

    final height =MediaQuery.of(context,).size.height;

    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
              child: Text(' Edit the Information of the Product: ',
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
                      child: Text('Edit product'),
                      onPressed: (){

                        if(_globalKey.currentState.validate())
                        {
                          _globalKey.currentState.save();
                          _globalKey.currentState.reset();

                          store.editProduct(({
                            kProductName: name,
                            kProductPrice : price,
                            kProductCategory : category,
                            kProductLocation: location,
                            kProductDescription:Description
                          }), receivedProduct.Id);




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
