import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/constants.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {

  static String id = 'order_details_screen';


  Store _store=Store();
  @override
  Widget build(BuildContext context) {

    String documentId=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream:_store.loadOrdersDetails(documentId),
          builder: (context,snapShot){

            if(!snapShot.hasData)
              {
                return Center(child: Text('A problem Happened '),);
              }
            else{
              List<Product>products=[];
              for(var doc in snapShot.data.documents)
                {
                  products.add(
                    Product(
                    name: doc.data[kProductName],
                      quantity: doc.data[kProductQuantity],
                      price: doc.data[kProductPrice]
                    )
                  );
                }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount:products.length ,
                        itemBuilder: (context,index){

                         return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              color: kMainColor,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Product Name ${products[index].name}',
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10,),
                                    Text('Product Price: ${products[index].price}',
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                    ),

                                    Text('Product Quantity : ${products[index].quantity}',
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                    )


                                  ],
                                ),
                              ),
                            ),
                          );

                        }),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        RaisedButton(onPressed: null,
                        color: Colors.red,
                        child: Text('Delete Order'),
                        ),
                        RaisedButton(onPressed: null,
                          color: Colors.green,
                          child: Text('Confirm Order'),
                        ),

                      ],
                    ),
                  )
                ],
              );
            }

          }),
    );
  }
}
