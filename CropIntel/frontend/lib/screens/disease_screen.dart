import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';

class DiseaseScreen extends StatefulWidget {
  const DiseaseScreen({super.key});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  Uint8List? selectedImage;
  String? selectedFileName;

  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  String? cropName;
  String? diseaseName;
  double? confidence;

  Future<void> selectImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final bytes = await image.readAsBytes();

    setState(() {
      selectedImage = bytes;
      selectedFileName = image.name;

      cropName = null;
      diseaseName = null;
      confidence = null;
    });
  }

  Future<void> detectDisease() async {
    if (selectedImage == null || selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
      cropName = null;
      diseaseName = null;
      confidence = null;
    });

    try {
      final response = await ApiService.predictDisease(
        selectedImage!,
        selectedFileName!,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final String rawDisease = data['disease'];

        final parts = rawDisease.split('___');

        String crop = parts.isNotEmpty ? parts[0] : 'Unknown';
        String disease =
            parts.length > 1 ? parts[1] : rawDisease;

        crop = crop.replaceAll('_', ' ');

        disease = disease
            .replaceAll('_', ' ')
            .replaceAll('(', '')
            .replaceAll(')', '');

        setState(() {
          cropName = crop;
          diseaseName = disease;
          confidence =
              (data['confidence'] as num).toDouble();
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
          content: Text('Something went wrong: $e'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String get confidenceText {
    if (confidence == null) return '';

    return '${(confidence! * 100).toStringAsFixed(2)}%';
  }

  bool get isHealthy {
    if (diseaseName == null) return false;

    return diseaseName!.toLowerCase().contains('healthy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF123D2A),
        foregroundColor: Colors.white,
        title: const Text(
          'Disease Detection',
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
                  'Crop Disease Detection 🌿',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D2B),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Upload a clear crop leaf image and let AI '
                  'identify possible diseases.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // MAIN CARD
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
                    children: [
                      // IMAGE AREA
                      Container(
                        width: double.infinity,
                        height: 330,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F7F2),
                          borderRadius:
                              BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFB9D8C2),
                            width: 1.5,
                          ),
                        ),
                        child: selectedImage == null
                            ? _buildEmptyImageArea()
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(15),
                                child: Image.memory(
                                  selectedImage!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),

                      const SizedBox(height: 22),

                      // SELECT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed:
                              isLoading ? null : selectImage,
                          icon: const Icon(
                            Icons.upload_file,
                          ),
                          label: Text(
                            selectedImage == null
                                ? 'Select Crop Image'
                                : 'Change Image',
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // DETECT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed:
                              isLoading ? null : detectDisease,
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
                                  Icons.auto_awesome,
                                ),
                          label: Text(
                            isLoading
                                ? 'Analyzing Image...'
                                : 'Detect Disease',
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
                if (diseaseName != null)
                  _buildResultCard(),

                const SizedBox(height: 28),

                // INFO CARDS
                Row(
                  children: [
                    Expanded(
                      child: _infoCard(
                        Icons.image_outlined,
                        'Clear Image',
                        'Use a clear image of the crop leaf.',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _infoCard(
                        Icons.center_focus_strong,
                        'Good Lighting',
                        'Avoid dark or blurry images.',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _infoCard(
                        Icons.psychology_outlined,
                        'AI Analysis',
                        'AI analyzes the uploaded image.',
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
  // EMPTY IMAGE AREA
  // ==================================================

  Widget _buildEmptyImageArea() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload_outlined,
          size: 70,
          color: Color(0xFF4F8A67),
        ),
        SizedBox(height: 15),
        Text(
          'Upload a crop leaf image',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF183D2B),
          ),
        ),
        SizedBox(height: 7),
        Text(
          'PNG, JPG or JPEG',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // ==================================================
  // RESULT CARD
  // ==================================================

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isHealthy
            ? const Color(0xFFE7F5EA)
            : const Color(0xFFFFF3E8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHealthy
              ? const Color(0xFF9CCBA9)
              : const Color(0xFFE5B98D),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: isHealthy
                    ? const Color(0xFF2E7D4F)
                    : const Color(0xFFD97732),
                child: Icon(
                  isHealthy
                      ? Icons.check
                      : Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Text(
                isHealthy
                    ? 'Crop Looks Healthy'
                    : 'Disease Detected',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D2B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

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
                  'Condition',
                  diseaseName ?? 'Unknown',
                  Icons.medical_information_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  color: Color(0xFF28704B),
                ),
                const SizedBox(width: 10),
                const Text(
                  'AI Confidence',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  confidenceText,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF28704B),
                  ),
                ),
              ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
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
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
}