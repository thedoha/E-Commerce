import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/src/string_constants.dart';


class Store {

  final _firestore = Firestore();

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add(
        {

          kProductName: product.name,
          kProductPrice: product.price,
          kProductCategory: product.category,
          kProductDescription: product.describtion,
          kProductLocation: product.location,

        });
  }


  Stream <QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductsCollection).snapshots();
  }


  deleteProduct(documentId)
  {
    _firestore.collection(kProductsCollection).document(documentId).delete();
  }


  editProduct(data,documentId)
  {
    _firestore.collection(kProductsCollection).document(documentId).updateData(data);
  }

    storeOrders(data,List<Product>products)
  {

    //adding user information
 var documentReference =_firestore.collection(kOrders).document();
 documentReference.setData(data);


 //adding product information
 for(var product in products) {
   documentReference.collection(kOrdersDetails).document().setData({
     kProductName:product.name,
     kProductQuantity:product.quantity,
     kProductPrice:product.price,
     kProductLocation:product.location,


   });
 }

  }

  Stream<QuerySnapshot>loadOrders()
  {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot>loadOrdersDetails(documentId)
  {
    return _firestore.collection(kOrders).document(documentId).collection(kOrdersDetails).snapshots();
  }



}