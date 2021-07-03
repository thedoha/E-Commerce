import 'package:ecom/models/product.dart';



List<Product> getProductsByCategory(String kCategoryJacket,List<Product> allproducts) {

  List<Product> products=[] ;

  for(var product in allproducts)
  {

    if(product.category==kCategoryJacket)
      products.add(product);
  }

  return products;
}