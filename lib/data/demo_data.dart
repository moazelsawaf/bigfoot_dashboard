import 'package:bigfoot_dashboard/data/models/order.dart';

import 'enums/order_status.dart';
import 'models/order_item.dart';

class DemoData {
  DemoData._();

  static List<Order> get orders {
    return [
      Order(
        id: 1,
        date: DateTime.now(),
        status: OrderStatus.pending,
        name: 'John Doe',
        address: '123 Main St.',
        phone: '01123548965',
        items: [
          OrderItem(
            id: 1,
            name: 'Rice',
            image:
                'https://static01.nyt.com/images/2018/02/21/dining/00RICEGUIDE8/00RICEGUIDE8-superJumbo.jpg',
            price: 35,
            quantity: 3,
          ),
        ],
      ),
      Order(
        id: 2,
        date: DateTime.now(),
        status: OrderStatus.pending,
        name: 'John Doe',
        address: '123 Main St.',
        phone: '01123548965',
        items: [
          OrderItem(
            id: 1,
            name: 'Rice',
            image:
                'https://static01.nyt.com/images/2018/02/21/dining/00RICEGUIDE8/00RICEGUIDE8-superJumbo.jpg',
            price: 100,
            quantity: 1,
          ),
          OrderItem(
            id: 2,
            name: 'Meat',
            image:
                'https://www.redefinemeat.com/wp-content/uploads/2022/04/BLOG1.jpg',
            price: 255.99,
            quantity: 2,
          )
        ],
      ),
      Order(
        id: 3,
        date: DateTime.now(),
        status: OrderStatus.pending,
        name: 'John Doe',
        address: '123 Main St.',
        phone: '01123548965',
        items: [
          OrderItem(
            id: 1,
            name: 'Rice',
            image:
                'https://static01.nyt.com/images/2018/02/21/dining/00RICEGUIDE8/00RICEGUIDE8-superJumbo.jpg',
            price: 100,
            quantity: 1,
          ),
          OrderItem(
            id: 2,
            name: 'Meat',
            image:
                'https://www.redefinemeat.com/wp-content/uploads/2022/04/BLOG1.jpg',
            price: 200,
            quantity: 1,
          ),
          OrderItem(
            id: 3,
            name: 'Fish',
            image:
                'https://static.independent.co.uk/2022/06/08/17/newFile-1.jpg',
            price: 52.5,
            quantity: 1,
          ),
          OrderItem(
            id: 4,
            name: 'Pasta',
            image:
                'https://assets.epicurious.com/photos/606b6eb818ac0b1841b3bbbf/16:9/w_4679,h_2632,c_limit/WackyPastaShapes_HERO_040121_12258.jpg',
            price: 50,
            quantity: 1,
          ),
          OrderItem(
            id: 5,
            name: 'Chicken',
            image:
                'https://www.saveur.com/uploads/2022/08/11/00-LEAD-Smokerless-Smoked-Chicken-with-Homemade-BBQ-Sauce-EITAN-BERNATH-saveur-scaled.jpg?auto=webp',
            price: 150,
            quantity: 2,
          ),
        ],
      ),
    ];
  }
}
