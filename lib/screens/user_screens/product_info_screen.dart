import 'package:ecom/models/product.dart';
import 'package:ecom/provider/cart_item.dart';
import 'package:ecom/screens/user_screens/cart_screen.dart';
import 'package:ecom/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfoScreen extends StatefulWidget {

  static String id='product_info_screen';

  @override
  _ProductInfoScreenState createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {


  int _quantity=1;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.height;

    Product sentProduct=ModalRoute.of(context).settings.arguments;

    return Scaffold(


      body: Stack(
        children: <Widget>[

          Container(
              height: height,
              width: width,
              child: Image.network(sentProduct.location,fit: BoxFit.fill,)),

          Padding(
            padding: const EdgeInsets.fromLTRB(20,60,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(child: Icon(Icons.arrow_back_ios),
                onTap: (){
                  Navigator.pop(context);
                },
                ),


                GestureDetector(
                    onTap: (){Navigator.pushNamed(context, CartScreen.id);},
                    child: Icon(Icons.shopping_cart)),

              ],
            ),
          ),


          
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height*0.5),
                
                width: width,
                height: height*0.5,
                color:Colors.white.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Text(sentProduct.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    Text(sentProduct.describtion,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                    Text('${sentProduct.price}\$',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(

                          child: Material(
                            color: kMainColor,
                            child: GestureDetector(

                              onTap:(){

                                setState(() {
                                  _quantity++;
                                });

                              },
                              child: SizedBox(height: 40,width: 40,
                                child: Icon(Icons.add),

                              ),
                            ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(_quantity.toString(),style: TextStyle(fontSize: 40),)),
                        ClipOval(

                          child: Material(
                            color: kMainColor,
                            child: GestureDetector(

                              onTap:(){
                                if(_quantity>0)
                                  {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                              },
                              child: SizedBox(height: 40,width: 40,
                                child: Icon(Icons.remove),

                              ),
                            ),
                          ),
                        ),
                      ],
                    )



                  ],
                ),
              ),
            ],
          ),




          Positioned(
            bottom: 50,
            right: 40,
            child: Builder(
              builder: (context)=> IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,color: kMainColor,size: 60,),
                  onPressed:(){
                    addToCart(sentProduct,context);
                  }
              ),
            ),
          ),
        ],
      ),
    );




  }

  addToCart(Product sentProduct,context) {


    bool exist=false;
    CartItem cartItem=Provider.of<CartItem>(context,listen: false);
    var productsInCart=cartItem.products;
    for(var product in productsInCart)
      {
        if(product.name==sentProduct.name)
          exist=true;
      }

    if(exist)
      {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('This Item is Already exist in your cart')));
      }

    else
      {
        sentProduct.quantity=_quantity;
        cartItem.addProduct(sentProduct);
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('Added to Cart')));
      }

  }

}

