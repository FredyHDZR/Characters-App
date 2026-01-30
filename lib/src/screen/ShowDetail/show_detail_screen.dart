import 'package:flutter/material.dart';
import 'package:flutter_character_app/src/components/loading_component.dart';
import 'package:flutter_character_app/src/screen/ShowDetail/show_detail_cntroller.dart';
import 'package:flutter_character_app/src/theme/app_colors.dart';
import 'package:flutter_character_app/src/theme/app_fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ShowDetailScreen extends StatefulWidget {
  final String seriesName;
  const ShowDetailScreen({super.key, required this.seriesName});

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen> {
  late ShowDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = ShowDetailController(seriesName: widget.seriesName);
    controller.getShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.seriesName,
          style: AppFonts.boldTitle.copyWith(
            color: AppColors.text,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      ),
      body: Observer(
        builder: (context) {
          return controller.isLoading ? loading() : body();
        },
      ),
    );
  }

  Widget body() {
    var posterStack = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          controller.show?.poster ?? '',
          width: 200,
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.image_not_supported, size: 80),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.fromLTRB(8, 24, 8, 8),
          width: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary.withAlpha(0), AppColors.primary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(Icons.star, size: 32, color: AppColors.yellow),
              Text(
                controller.show?.imdbRating ?? '',
                style: AppFonts.normalTitle.copyWith(color: AppColors.yellow),
              ),
            ],
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            posterStack,
            const SizedBox(height: 24),
            Row(
              spacing: 5,
              children: [
                Expanded(
                  child: iconInformation(
                    Icons.workspace_premium,
                    'Awards: ',
                    controller.show?.awards ?? '',
                  ),
                ),
                Expanded(
                  child: iconInformation(
                    Icons.public,
                    'Country: ',
                    controller.show?.country ?? '',
                  ),
                ),
                Expanded(
                  child: iconInformation(
                    Icons.play_circle,
                    'Género: ',
                    controller.show?.genre ?? '',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            rowText('Cast: ', controller.show?.actors ?? ''),
            rowText('Plot: ', controller.show?.plot ?? ''),
            rowText('Rated: ', controller.show?.rated ?? ''),
            rowText('Released: ', controller.show?.released ?? ''),
            rowText('Writer: ', controller.show?.writer ?? ''),
          ],
        ),
      ),
    );
  }

  Widget rowText(String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: AppFonts.normalTextBold.copyWith(
              color: AppColors.text,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: AppFonts.normalText.copyWith(
              color: AppColors.text,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ),
      ],
    );
  }

  Widget iconInformation(IconData icon, String text, String value) {
    return Container(
      constraints: BoxConstraints(minHeight: 150, maxHeight: 160),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.grey.withAlpha(2), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppColors.text),
          Expanded(child: SizedBox()),
          Text(
            text,
            style: AppFonts.smallTextBold.copyWith(
              color: AppColors.text,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppFonts.smallText.copyWith(
              color: AppColors.textSecondary,
              fontFamily: AppFonts.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
