import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalapp/productdetailscreen.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder(
        future: _fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var products = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var productData = products[index];
                Product product = Product(
                  id: productData['id']?? 0,
                  name: productData['name']?? 'Unknown',
                  rate: (productData['rate']?? 0).toDouble(),
                  description: productData['description']?? 'No description available',
                );
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.rate}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product.toMap()),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No products found'));
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchProducts() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('products').get();
      return querySnapshot.docs.map((doc) {
        var data = doc.data();
        return {
          'id': data['id'] is int? data['id'] : (data['id'] as num?)?.toInt()?? 0,
          'name': data['name']?? 'Unknown',
          'rate': (data['rate'] as num?)?.toDouble()?? 0.0,
          'description': data['description']?? 'No description available',
        };
      }).toList().cast<Map<String, dynamic>>();
    } on FirebaseException catch (e) {
      print('FirebaseException: $e');
      rethrow;
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }
}

class Product {
  final int id;
  final String name;
  final double rate;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.rate,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rate': rate,
      'description': description,
    };
  }
}