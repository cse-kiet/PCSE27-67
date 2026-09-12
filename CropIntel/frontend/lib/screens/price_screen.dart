import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/api_service.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  final marketController = TextEditingController();
  final commodityController = TextEditingController();
  final varietyController = TextEditingController();
  final gradeController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  String? cropName;
  double? predictedPrice;

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> predictPrice() async {
    if (stateController.text.trim().isEmpty ||
        districtController.text.trim().isEmpty ||
        marketController.text.trim().isEmpty ||
        commodityController.text.trim().isEmpty ||
        varietyController.text.trim().isEmpty ||
        gradeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
      cropName = null;
      predictedPrice = null;
    });

    try {
      final date =
          '${selectedDate.year.toString().padLeft(4, '0')}-'
          '${selectedDate.month.toString().padLeft(2, '0')}-'
          '${selectedDate.day.toString().padLeft(2, '0')}';

      final response = await ApiService.predictPrice(
        state: stateController.text.trim(),
        district: districtController.text.trim(),
        market: marketController.text.trim(),
        commodity: commodityController.text.trim(),
        variety: varietyController.text.trim(),
        grade: gradeController.text.trim(),
        date: date,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['success'] == true) {
        setState(() {
          cropName = data['crop'];
          predictedPrice =
              (data['price'] as num).toDouble();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Prediction failed: ${data.toString()}',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong: $e',
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildTextField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF28704B),
          ),
          filled: true,
          fillColor: const Color(0xFFF8FAF8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFDCE8DF),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF28704B),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF123D2A),
        foregroundColor: Colors.white,
        title: const Text(
          'Price Prediction',
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
              maxWidth: 950,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                const Text(
                  'Crop Price Prediction 💰',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Enter crop and market information to get '
                  'an AI-powered price prediction.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // MAIN FORM CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Market Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF183D2B),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ROW 1
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              'State',
                              'e.g. Uttar Pradesh',
                              Icons.location_on_outlined,
                              stateController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: buildTextField(
                              'District',
                              'e.g. Agra',
                              Icons.location_city_outlined,
                              districtController,
                            ),
                          ),
                        ],
                      ),

                      // ROW 2
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              'Market',
                              'e.g. Agra',
                              Icons.storefront_outlined,
                              marketController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: buildTextField(
                              'Commodity / Crop',
                              'e.g. Potato',
                              Icons.eco_outlined,
                              commodityController,
                            ),
                          ),
                        ],
                      ),

                      // ROW 3
                      Row(
                        children: [
                          Expanded(
                            child: buildTextField(
                              'Variety',
                              'e.g. Potato',
                              Icons.grass_outlined,
                              varietyController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: buildTextField(
                              'Grade',
                              'e.g. FAQ',
                              Icons.grade_outlined,
                              gradeController,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // DATE
                      const Text(
                        'Price Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF183D2B),
                        ),
                      ),

                      const SizedBox(height: 8),

                      InkWell(
                        onTap: selectDate,
                        borderRadius:
                            BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAF8),
                            borderRadius:
                                BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFDCE8DF),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Color(0xFF28704B),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${selectedDate.day.toString().padLeft(2, '0')}/'
                                '${selectedDate.month.toString().padLeft(2, '0')}/'
                                '${selectedDate.year}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_drop_down,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed:
                              isLoading ? null : predictPrice,
                          icon: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.auto_graph,
                                ),
                          label: Text(
                            isLoading
                                ? 'Predicting Price...'
                                : 'Predict Crop Price',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // RESULT
                if (predictedPrice != null)
                  _buildResultCard(),

                const SizedBox(height: 28),

                // INFO CARDS
                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        Icons.analytics_outlined,
                        'AI Prediction',
                        'Price is predicted using the trained '
                        'CatBoost model.',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _infoCard(
                        Icons.store_outlined,
                        'Market Based',
                        'Prediction uses market and crop details.',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _infoCard(
                        Icons.calendar_today_outlined,
                        'Date Based',
                        'The selected date is included in prediction.',
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
  // RESULT CARD
  // ==================================================

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F5EA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFB8D9C0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF28704B),
                child: Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              SizedBox(width: 14),
              Text(
                'Price Prediction',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D2B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: _resultItem(
                  'Crop',
                  cropName ?? 'Unknown',
                  Icons.eco,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _resultItem(
                  'Predicted Price',
                  '₹${predictedPrice!.toStringAsFixed(2)}',
                  Icons.currency_rupee,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            'Note: This is an AI-based prediction and actual '
            'market prices may vary.',
            style: TextStyle(
              color: Color(0xFF587062),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultItem(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF28704B),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
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
  // INFO CARD
  // ==================================================

  Widget _infoCard(
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
              color: Color(0xFF183D2B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    stateController.dispose();
    districtController.dispose();
    marketController.dispose();
    commodityController.dispose();
    varietyController.dispose();
    gradeController.dispose();

    super.dispose();
  }
}