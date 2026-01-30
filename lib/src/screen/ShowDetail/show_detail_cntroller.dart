import 'package:flutter_character_app/src/models/show_model.dart';
import 'package:flutter_character_app/src/services/show_service.dart';
import 'package:mobx/mobx.dart';

part 'show_detail_cntroller.g.dart';

class ShowDetailController = ShowDetailControllerBase with _$ShowDetailController;

abstract class ShowDetailControllerBase with Store {
  final String seriesName;
  ShowDetailControllerBase({required this.seriesName});

  @observable
  bool isLoading = false;

  @observable
  ShowModel? show;

  @action
  Future<void> getShow() async {
    isLoading = true;
    final response = await ShowService.getShow(seriesName);
    show = response['show'];
    isLoading = false;
  }
}