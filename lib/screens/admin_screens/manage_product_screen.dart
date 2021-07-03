import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/admin_screens/edit_product_screen.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:ecom/widgets/admin_panel_widgets/admin_product_item_card.dart';
import 'package:flutter/material.dart';

import 'add_products.dart';


class ManageProductScreen extends StatefulWidget {

  static String id = 'manage_product_screen';


  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {

  final _store=Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream:_store.loadProduct() ,
        builder: (context,snapshot)
            {
              if(snapshot.hasData)
                {
                  List<Product> products=[];
                  for (var document in snapshot.data.documents) {
                    var data = document.data;
                    products.add(Product(
                        name: data[kProductName],
                        price: data[kProductPrice],
                        location: data[kProductLocation],
                        describtion: data[kProductDescription],
                        category: data[kProductCategory],
                        Id:document.documentID
                    ));
                  }

              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                  ),
                  itemCount: products.length ,
                  itemBuilder: (context,index){
                   return
                       AdminProductItemCard(products: products,
                    productIndexInList: index,
                    functionForEditButton:(){
                         Navigator.of(context).pushNamed(AddProductsScreen.id,arguments: products[index]);} ,


                    functionForDeleteButton: (){
                         _store.deleteProduct(products[index].Id);
                         Navigator.pop(context);
                         },
                  )



                  ; });


                }
            else
              {
                return Center(child: Text('Loading.. ',style: TextStyle(fontSize: 30),));
              }


            }
      ),

    );
  }




}
