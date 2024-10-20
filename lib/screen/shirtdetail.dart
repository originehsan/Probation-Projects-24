import 'package:flutter/material.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String categoryName;
  final Function(List<Map<String, dynamic>>) updateLikedItems;

  CategoryItemsScreen({
    required this.categoryName,
    required this.updateLikedItems,
  });

  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  final Map<String, List<Map<String, dynamic>>> items = {
    'Shirts': [
      {
        'name': 'formal shirt',
        'price': 800.0,
        'image': 'assets/images/shirt1.png',
      },
      {
        'name': 'casual shirt',
        'price': 400.0,
        'image': 'assets/images/shirt2.png',
      },
       {
        'name': 'casual shirt',
        'price': 600.0,
        'image': 'assets/images/shirt3.png',
      },
       {
        'name': 'casual shirt',
        'price': 700.0,
        'image': 'assets/images/shirt4.png',
      },
       {
        'name': 'casual shirt',
        'price': 900.0,
        'image': 'assets/images/shirtsp.png',
      },
    ],
    'Tshirts': [
      {
        'name': 'V-Neck Tees',
        'price': 300.0,
        'image': 'assets/images/tshirt1.png',
      },
      {
        'name': 'Ringer Tees',
        'price': 400.0,
        'image': 'assets/images/tshirt2.png',
      },
       {
        'name': 'Crew Neck Tees',
        'price': 500.0,
        'image': 'assets/images/tshirt3.png',
      },
       {
        'name': 'Pocket Tees',
        'price': 200.0,
        'image': 'assets/images/tshirt4.png',
      },
       {
        'name': 'Crop Tees',
        'price': 600.0,
        'image': 'assets/images/tshirtsp.png',
      },
    ],
    'Hoodies': [
      {
        'name': 'Pullover Hoodie',
        'price': 300.0,
        'image': 'assets/images/hoodie1.png',
      },
      {
        'name': 'Zip-Up Hoodie',
        'price': 300.0,
        'image': 'assets/images/hoodie2.png',
      },
      {
        'name': 'PCrop Hoodie',
        'price': 300.0,
        'image': 'assets/images/hoodie3.png',
      },
      {
        'name': 'Oversized Hoodie',
        'price': 300.0,
        'image': 'assets/images/hoodie4.png',
      },
      {
        'name': 'Graphic Hoodie',
        'price': 300.0,
        'image': 'assets/images/hoodiesp.png',
      },
          ] ,
      ' Jackets': 
      [
      {
        'name': 'Denim Jacket',
        'price': 800.0,
        'image': 'assets/images/jacket1.png',
      },
      {
        'name': 'Denim Jacket',
        'price': 800.0,
        'image': 'assets/images/jacket2.png',
      },
      {
        'name': 'Denim Jacket',
        'price': 800.0,
        'image': 'assets/images/jacket3.png',
      },
      {
        'name': 'Denim Jacket',
        'price': 800.0,
        'image': 'assets/images/jacket4.png',
      },
      {
        'name': 'Denim Jacket',
        'price': 800.0,
        'image': 'assets/images/jacketsp.png',
      },

        
    ]
  };

  List<Map<String, dynamic>> likedItems = [];
  List<Map<String, dynamic>> cartItems = [];

  void toggleLike(Map<String, dynamic> item) {
    setState(() {
      if (likedItems.any((likedItem) => likedItem['name'] == item['name'])) {
        likedItems
            .removeWhere((likedItem) => likedItem['name'] == item['name']);
      } else {
        likedItems.add(item);
      }
    });

    widget.updateLikedItems(likedItems);
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cartItems.add(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to cart!')),
    );
  }

  void buyItem(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buying ${item['name']}!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: ListView.builder(
        itemCount: items[widget.categoryName]?.length ?? 0,
        itemBuilder: (context, index) {
          final item = items[widget.categoryName]![index];
          final isLiked =
              likedItems.any((likedItem) => likedItem['name'] == item['name']);
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    item['image'],
                    height: 100,
                    width: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Price: ₹${item['price']}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.green)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border),
                        color: isLiked ? Colors.red : Colors.grey,
                        onPressed: () => toggleLike(item),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          backgroundColor: Colors.grey[300],
                        ),
                        onPressed: () => addToCart(item),
                        child: Text('Add to Cart'),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orange,
                          backgroundColor: Colors.grey[300],
                        ),
                        onPressed: () => buyItem(item),
                        child: Text('Buy'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
