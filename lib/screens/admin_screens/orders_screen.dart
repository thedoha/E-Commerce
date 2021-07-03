import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/order.dart';
import 'package:ecom/screens/admin_screens/order_details_screen.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/constants.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:flutter/material.dart';


class OrdersScreen extends StatelessWidget {


  Store _store=Store();




  static String id='orders_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
      builder: (context,snapShot)
        {
          if(!snapShot.hasData)
            {
              return Center(
                child: Text('there is no orders Yet'),
              );
            }
          else {

            List<Order> orders=[];
            for(var doc in snapShot.data.documents)
              {

                orders.add(Order(
                  docID: doc.documentID,
                  address: doc.data[kAddress] ,
                  totalPrice: doc.data[kTotalPrice],

                ));
              }
            return ListView.builder(itemCount: orders.length,
            itemBuilder: (context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: (){Navigator.pushNamed(context, OrderDetailsScreen.id,arguments: orders[index].docID);},
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      color: kMainColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Total Price = ${orders[index].totalPrice}\$',
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10,),
                            Text('User Address is : ${orders[index].address}',
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ) ;
              },);
          }
        },
      ),

    );
  }
}
