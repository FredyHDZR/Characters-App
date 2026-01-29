import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/functions.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.gender,
    required this.species,
    required this.createdAt,
  });

  final String gender;
  final String species;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información',
              style: AppFonts.boldTitle.copyWith(
                fontFamily: AppFonts.fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(
                  context,
                  'Género',
                  gender,
                  gender.toLowerCase() == 'male'
                      ? Icons.male
                      : Icons.female,
                ),
                _buildInfoItem(
                  context,
                  'Especie',
                  species,
                  Icons.person,
                ),
                _buildInfoItem(
                  context,
                  'Fecha de creación',
                  formatDate(createdAt),
                  Icons.star,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 8),
        Text(value, style: AppFonts.normalTextBold),
        Text(label, style: AppFonts.normalText),
      ],
    );
  }
}
