import 'package:ecom/models/product.dart';
import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/screens/user_screens/product_info_screen.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/constants.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:ecom/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {

  static String id='cart_screen';
  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double widht=MediaQuery.of(context).size.width;

    List<Product> products=Provider.of<CartItem>(context).products;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        backgroundColor: Colors.white,
        title: Text('Cart',style: TextStyle(color: Colors.black),),

      ),
      body: products.isNotEmpty
      ?Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTapUp: (details){

                    showCustomMenu(details,context,products[index]);

                    },
                  child: Container(
                    height: height*0.15,
                    color: kMainColor,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: (height*0.15)/2,
                          backgroundImage:NetworkImage(products[index].location) ,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(products[index].name,
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                    Text('\$'+ products[index].price),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(products[index].quantity.toString(),
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );




            }),
          ),
          Builder(
            builder: (context)=>
                ButtonTheme(
              minWidth: widht,
              height: height*0.08,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: RaisedButton(
                  child: Text('Confirm Order'),
                  color: kMainColor.withOpacity(0.8),
                  onPressed: (){
                    showCustomDialogue(products,context);
                  }),
            ),
          )


        ],
      )
          :Center(child: Text('Your Cart is Empty'),)



    );
  }

  void showCustomMenu(details,context,product) async{



    double dx= details.globalPosition.dx;
    double dy= details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width-dx;
    double dy2=MediaQuery.of(context).size.width-dy;

     await showMenu(context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),

        items:[
          MyPopUpMenuItem(child: Text('Edit'),

            function:(){



            Navigator.pop(context);
            Provider.of<CartItem>(context,listen: false).deleteProduct(product);
            Navigator.pushNamed(context, ProductInfoScreen.id,arguments: product);

          } ,),
          MyPopUpMenuItem(child: Text('Delete'),

            function:(){
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);



            } ,),


        ] );






  }

   showCustomDialogue(products,context) async{

    String address;

    AlertDialog alertDialog=AlertDialog(
      actions: <Widget>[
        MaterialButton(onPressed: (){


          try {
            Store _store = Store();
            _store.storeOrders(({
              kTotalPrice: getTotalPrice(products),
              kAddress: address
            }), products);

            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Orderd (Y)')));
            Navigator.pop(context);
          }
          catch(ex)
          {
            print(ex);
          }
        },

          child: Text('Confirm'),)
      ],
      content: TextField(
        onChanged: (text){
          address=text;
        },
        decoration: InputDecoration(hintText:'Enter Your Address' ),),
      title: Text('Total price for you is\$ ${getTotalPrice(products)}'),
    );
     await showDialog(context: context,builder:(context){
      return alertDialog;
    } );
  }
   getTotalPrice( List<Product> products)
  {

    var total=0;
    for( var product in products)
      {
        total+=product.quantity*int.parse(product.price);
      }
    return total;
  }
}
