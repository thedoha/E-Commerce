import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/screens/admin_screens/add_products.dart';
import 'package:ecom/screens/user_screens/cart_screen.dart';
import 'package:ecom/screens/user_screens/login_screen.dart';
import 'package:ecom/screens/user_screens/product_info_screen.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/services/store.dart';
import 'package:ecom/src/constants.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:ecom/src/used_functions.dart';
import 'package:ecom/widgets/admin_panel_widgets/admin_product_item_card.dart';
import 'package:ecom/widgets/user_screens_widgets/product_view.dart';
import 'package:ecom/widgets/user_screens_widgets/user_product_item_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserHome extends StatefulWidget {
  static String id ='user_home';


  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {



int tabBarIndex=0;
int bottmomBarIndex=0;
final _store=Store();
Auth _auth=Auth();
List<Product>_products=[];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
  double height=  MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        DefaultTabController(length: 4,
            child: Scaffold(
              bottomNavigationBar:BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                  onTap: (value)async{

                  if(value==2)
                    {
                       SharedPreferences sp=  await SharedPreferences.getInstance();
                       sp.clear();
                        await _auth.signOut();
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                    }
                   setState(() {
                     bottmomBarIndex=value;
                   });
                  },
                currentIndex: bottmomBarIndex,

                  fixedColor: kMainColor,
                  items: [
                BottomNavigationBarItem(title: Text('test'),icon: Icon(Icons.person)),
                BottomNavigationBarItem(title: Text('test'),icon: Icon(Icons.person)),
                BottomNavigationBarItem(title: Text('Sign Out'),icon: Icon(Icons.close)),

              ]) ,

              appBar: AppBar(
                backgroundColor: Colors.white,
                bottom: TabBar(
                  indicatorColor: kMainColor,
                    onTap:(value){
                      setState(() {
                        tabBarIndex=value;
                      });
                    } ,

                    tabs:[
                 Text(kCategoryJacket, style: TextStyle(color: tabBarIndex==0? Colors.black:kUnActiveColor,
                    fontSize: tabBarIndex==0?16:null  ),),
                 Text(kCategoryTrousers, style: TextStyle(color: tabBarIndex==1? Colors.black:kUnActiveColor,
                    fontSize: tabBarIndex==1?15:null  ),),
                 Text(kCategoryTshirts, style: TextStyle(color: tabBarIndex==2? Colors.black:kUnActiveColor,
                    fontSize: tabBarIndex==2?16:null  ),),
                 Text(kCategoryShoes, style: TextStyle(color: tabBarIndex==3? Colors.black:kUnActiveColor,
                    fontSize: tabBarIndex==3?16:null  ),),

              ] ),),
              body: TabBarView(children: [

                JacketView(),
                productView(kCategoryTrousers,_products),
                productView(kCategoryShoes,_products),
                productView(kCategoryTshirts,_products),

              ]),
            )
        ),

        Material(
          child: Padding(

            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Container(
              height: height*0.09,
            //  color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text('Discover'.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  GestureDetector(child: Icon(Icons.shopping_cart),
                  onTap: (){
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                  ),




                ],
              ),

            ),
          ),
        )


      ],


    );
  }

   Widget JacketView() {
    return StreamBuilder<QuerySnapshot>(
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
                    Id: document.documentID
                ));

            }

            _products=[...products];
            products.clear();
            products=getProductsByCategory(kCategoryJacket,_products);


            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: products.length ,
                itemBuilder: (context,index){
                  return
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfoScreen.id,arguments: products[index]);},
                      child: UserProductItemCard(products: products,
                        productIndexInList: index,),
                    )



                  ; });


          }
          else
          {
            return Center(child: Text('Loading.. ',style: TextStyle(fontSize: 30),));
          }


        }
    );
  }


}
