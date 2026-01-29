import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_character_app/src/utils/constants.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      onChanged: widget.onSearch,
      onSubmitted: widget.onSearch,
      hintText: searchHintText,
      hintStyle: WidgetStateProperty.all(
        AppFonts.normalText.copyWith(color: AppColors.textSecondary),
      ),
      textStyle: WidgetStateProperty.all(
        AppFonts.normalText.copyWith(color: AppColors.text),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.background),
      elevation: WidgetStateProperty.all(1),
      leading: Icon(Icons.search),
      trailing: [
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
              icon: const Icon(Icons.clear),
            );
          },
        ),
      ],
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
    );
  }
}
