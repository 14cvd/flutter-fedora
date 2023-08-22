import 'package:flutter/material.dart';
import 'package:flutter_fedora/screens/adress_section.dart';
import 'package:flutter_fedora/screens/cong.dart';
import 'package:flutter_fedora/screens/payment_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMethodSelectionPage extends StatelessWidget {
  const PaymentMethodSelectionPage({Key? key, required Adress adress})
      : super(key: key);

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
          'Select Payment Type',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Select Payment Type',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BrolvePayment(),
                        ),
                      );
                    },
                    child: const PaymentMethodTile(
                      methodTitle: 'Brolve',
                      imagePath: 'https://brolve.com/assets/img/logo-bro.png',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PaymentPage(method: 'Credit Card'),
                        ),
                      );
                    },
                    child: const PaymentMethodTile(
                      methodTitle: 'Credit Card',
                      imagePath:
                          'https://t4.ftcdn.net/jpg/02/13/97/75/360_F_213977586_B23DBDMd1BMTjb405USK26GKBnXTOULQ.jpg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CongratulationsPage(
                            message:
                                'Təbriklər! Siz sifarişi uğurla tamamladınız. Ödəniş çatdırılma zamanı nağd olaraq sizdən alınacaqdır. Bizi seçdiyiniz üçün təşəkkürlər :)',
                          ),
                        ),
                      );
                    },
                    child: const PaymentMethodTile(
                      methodTitle: 'By Cash',
                      imagePath:
                          'https://cdn-icons-png.flaticon.com/512/2371/2371970.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String methodTitle;
  final String imagePath;

  const PaymentMethodTile({
    Key? key,
    required this.methodTitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(imagePath, width: 50, height: 50),
            const SizedBox(height: 10),
            Text(methodTitle),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final String method;

  const PaymentPage({
    Key? key,
    required this.method,
  }) : super(key: key);

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
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CongratulationsPage(
                            message:
                                'Təbriklər! Siz Ödənişi kart vasitəsilə tamamladınız. Məhsul sizə qısa zamanda çatdırılacaqdır.',
                          )));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              textStyle: const TextStyle(fontSize: 18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Payment Method: $method',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
