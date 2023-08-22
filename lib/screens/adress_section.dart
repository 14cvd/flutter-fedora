import 'package:flutter/material.dart';
import 'package:flutter_fedora/screens/payment_sectiooon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Adress {
  final String adress;

  Adress(this.adress);
}

class AdressSee extends StatefulWidget {
  const AdressSee({super.key});

  @override
  _AdressSeeState createState() => _AdressSeeState();
}

class _AdressSeeState extends State<AdressSee> {
  bool changeValue = false;
  List<Adress> adress = [
    Adress('Azərbaycan, Bakı, Codelandia'),
    Adress('Azərbaycan, Bakı, Rabitəbank'),
    Adress('Azərbaycan, Bakı, Nəriman Nərimanov M.S.'),
    Adress('Azərbaycan, Sumqayıt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            )),
        title: const Text(
          'Checkout',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: adress.map((adres) {
            return ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.locationArrow,
                color: Colors.green,
              ),
              title: Text(adres.adress),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdressSection(adress: adres),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AdressSection extends StatelessWidget {
  final Adress adress;

  const AdressSection({Key? key, required this.adress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            )),
        title: const Text(
          'Confirm Location',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selected Location:'),
            Text(
              adress.adress,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentMethodSelectionPage(adress: adress),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Center(
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
