import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/models/address.dart'; // Import the Address model

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Address> addresses = List.generate(
      5,
      (index) => Address(
        id: index,
        street: 'Street $index',
        number: '$index',
        city: 'City $index',
        state: 'State $index',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Endereços",
          style: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(addresses[i].street),
            subtitle: Text('\$${addresses[i].number}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Add edit functionality here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Add delete functionality here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
