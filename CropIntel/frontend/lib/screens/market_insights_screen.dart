import 'package:flutter/material.dart';

class MarketInsightsScreen extends StatelessWidget {
  const MarketInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),

      appBar: AppBar(
        backgroundColor: const Color(0xFF123D2A),
        foregroundColor: Colors.white,
        title: const Text(
          'Market Insights',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =========================
                // HEADER
                // =========================

                const Text(
                  'Market Insights 📊',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Explore crop prices, market trends and '
                  'agricultural price movements.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // MARKET LOCATION
                // =========================

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Row(
                    children: [

                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF28704B),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Selected Market',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        'Jaipur Mandi',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(width: 8),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Color(0xFF28704B),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // MARKET SUMMARY
                // =========================

                const Text(
                  'Market Overview',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [

                    Expanded(
                      child: _summaryCard(
                        Icons.currency_rupee,
                        'Average Price',
                        '₹2,450',
                        '+4.8%',
                        true,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _summaryCard(
                        Icons.trending_up,
                        'Highest Price',
                        '₹3,200',
                        '+7.2%',
                        true,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _summaryCard(
                        Icons.trending_down,
                        'Lowest Price',
                        '₹1,850',
                        '-2.4%',
                        false,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _summaryCard(
                        Icons.storefront_outlined,
                        'Markets',
                        '24',
                        'Active',
                        true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // =========================
                // CROP PRICE TABLE
                // =========================

                const Text(
                  'Crop Prices',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [

                        _tableHeader(),

                        const Divider(),

                        _cropRow(
                          'Potato',
                          '₹2,100',
                          '+5.2%',
                          Icons.trending_up,
                          true,
                        ),

                        _cropRow(
                          'Onion',
                          '₹2,650',
                          '+3.8%',
                          Icons.trending_up,
                          true,
                        ),

                        _cropRow(
                          'Tomato',
                          '₹3,200',
                          '+8.4%',
                          Icons.trending_up,
                          true,
                        ),

                        _cropRow(
                          'Wheat',
                          '₹2,450',
                          '-1.6%',
                          Icons.trending_down,
                          false,
                        ),

                        _cropRow(
                          'Rice',
                          '₹3,050',
                          '+2.1%',
                          Icons.trending_up,
                          true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // PRICE TREND
                // =========================

                const Text(
                  'Price Trend',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  height: 280,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Row(
                        children: [

                          Text(
                            'Potato',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF183D2B),
                            ),
                          ),

                          Spacer(),

                          Text(
                            'Last 7 Days',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Expanded(
                        child: CustomPaint(
                          painter: PriceChartPainter(),
                          child: const SizedBox.expand(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            'Mon',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Tue',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Wed',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Thu',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Fri',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Sat',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),

                          Text(
                            'Sun',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // MARKET RECOMMENDATION
                // =========================

                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F3EA),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFC5DDCC),
                    ),
                  ),

                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xFF28704B),
                        size: 30,
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              'Market Recommendation',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF183D2B),
                              ),
                            ),

                            SizedBox(height: 7),

                            Text(
                              'Tomato and potato prices are showing '
                              'a positive trend. Consider monitoring '
                              'market prices before deciding when '
                              'to sell your produce.',
                              style: TextStyle(
                                color: Color(0xFF4C6657),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // MARKET TIPS
                // =========================

                const Text(
                  'Smart Market Tips',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [

                    Expanded(
                      child: _tipCard(
                        Icons.compare_arrows,
                        'Compare Markets',
                        'Compare prices across nearby '
                            'mandis before selling your crop.',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _tipCard(
                        Icons.calendar_month_outlined,
                        'Track Trends',
                        'Monitor price movements over '
                            'multiple days.',
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: _tipCard(
                        Icons.auto_graph,
                        'Use Predictions',
                        'Use AI price predictions to '
                            'support your decisions.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================
  // SUMMARY CARD
  // ==================================================

  Widget _summaryCard(
    IconData icon,
    String title,
    String value,
    String change,
    bool positive,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: const Color(0xFF28704B),
            size: 28,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF183D2B),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            change,
            style: TextStyle(
              color: positive
                  ? const Color(0xFF28704B)
                  : Colors.redAccent,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // TABLE HEADER
  // ==================================================

  Widget _tableHeader() {
    return const Row(
      children: [

        Expanded(
          flex: 2,
          child: Text(
            'Crop',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),

        Expanded(
          child: Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),

        Expanded(
          child: Text(
            'Change',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // ==================================================
  // CROP ROW
  // ==================================================

  Widget _cropRow(
    String crop,
    String price,
    String change,
    IconData icon,
    bool positive,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),

      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Row(
              children: [

                Container(
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F3EA),
                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  child: const Icon(
                    Icons.eco_outlined,
                    size: 18,
                    color: Color(0xFF28704B),
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  crop,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF183D2B),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: [

                Icon(
                  icon,
                  size: 17,
                  color: positive
                      ? const Color(0xFF28704B)
                      : Colors.redAccent,
                ),

                const SizedBox(width: 4),

                Text(
                  change,
                  style: TextStyle(
                    color: positive
                        ? const Color(0xFF28704B)
                        : Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // TIP CARD
  // ==================================================

  Widget _tipCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            color: const Color(0xFF28704B),
            size: 28,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF183D2B),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// SIMPLE PRICE CHART
// ==================================================

class PriceChartPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF28704B)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    final points = [
      Offset(0, size.height * 0.70),
      Offset(size.width * 0.16, size.height * 0.58),
      Offset(size.width * 0.32, size.height * 0.63),
      Offset(size.width * 0.48, size.height * 0.40),
      Offset(size.width * 0.64, size.height * 0.48),
      Offset(size.width * 0.80, size.height * 0.25),
      Offset(size.width, size.height * 0.15),
    ];

    path.moveTo(
      points[0].dx,
      points[0].dy,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    canvas.drawPath(
      path,
      paint,
    );

    final pointPaint = Paint()
      ..color = const Color(0xFF28704B)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(
        point,
        4,
        pointPaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}