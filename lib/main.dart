import 'package:flutter/material.dart';

void main() {
  runApp(const CardWidgetDemoApp());
}

class CardWidgetDemoApp extends StatelessWidget {
  const CardWidgetDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Card Widget Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const CardDemoPage(),
    );
  }
}

class CardDemoPage extends StatefulWidget {
  const CardDemoPage({super.key});

  @override
  State<CardDemoPage> createState() => _CardDemoPageState();
}

class _CardDemoPageState extends State<CardDemoPage> {
  double _elevation = 4;
  double _cornerRadius = 12;
  Color _cardColor = Colors.white;

  static const List<_OfferItem> _offers = [
    _OfferItem(
      title: 'Lunch Combo Deal',
      subtitle: 'Burger, fries, and drink at student price',
      icon: Icons.lunch_dining,
      eta: '20 min',
    ),
    _OfferItem(
      title: 'Library Coffee Discount',
      subtitle: 'Get 20% off coffee between 2 PM and 5 PM',
      icon: Icons.local_cafe,
      eta: '5 min',
    ),
    _OfferItem(
      title: 'Late Night Pizza',
      subtitle: 'Buy 1 get 1 for hostels after 9 PM',
      icon: Icons.local_pizza,
      eta: '30 min',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final BorderRadius cardRadius = BorderRadius.circular(_cornerRadius);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Offers - Card Widget Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Live Property Controls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('elevation: ${_elevation.toStringAsFixed(1)}'),
                  Slider(
                    value: _elevation,
                    min: 0,
                    max: 16,
                    divisions: 16,
                    label: _elevation.toStringAsFixed(1),
                    onChanged: (value) => setState(() => _elevation = value),
                  ),
                  Text('shape (corner radius): ${_cornerRadius.toStringAsFixed(0)}'),
                  Slider(
                    value: _cornerRadius,
                    min: 0,
                    max: 28,
                    divisions: 28,
                    label: _cornerRadius.toStringAsFixed(0),
                    onChanged: (value) => setState(() => _cornerRadius = value),
                  ),
                  const SizedBox(height: 6),
                  const Text('color:'),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      _ColorDot(
                        color: Colors.white,
                        selected: _cardColor == Colors.white,
                        onTap: () => setState(() => _cardColor = Colors.white),
                      ),
                      _ColorDot(
                        color: Colors.orange.shade50,
                        selected: _cardColor == Colors.orange.shade50,
                        onTap: () => setState(() => _cardColor = Colors.orange.shade50),
                      ),
                      _ColorDot(
                        color: Colors.blue.shade50,
                        selected: _cardColor == Colors.blue.shade50,
                        onTap: () => setState(() => _cardColor = Colors.blue.shade50),
                      ),
                      _ColorDot(
                        color: Colors.green.shade50,
                        selected: _cardColor == Colors.green.shade50,
                        onTap: () => setState(() => _cardColor = Colors.green.shade50),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Today\'s Offers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ..._offers.map(
            (offer) => _OfferCard(
              offer: offer,
              elevation: _elevation,
              cardColor: _cardColor,
              radius: cardRadius,
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.offer,
    required this.elevation,
    required this.cardColor,
    required this.radius,
  });

  final _OfferItem offer;
  final double elevation;
  final Color cardColor;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: elevation,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange.shade100,
          child: Icon(offer.icon, color: Colors.deepOrange.shade800),
        ),
        title: Text(
          offer.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(offer.subtitle),
        trailing: Text(
          offer.eta,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opened: ${offer.title}')),
          );
        },
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.deepOrange : Colors.grey.shade400,
            width: selected ? 3 : 1,
          ),
        ),
      ),
    );
  }
}

class _OfferItem {
  const _OfferItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.eta,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String eta;
}