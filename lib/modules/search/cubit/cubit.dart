import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/searchModel/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper/dio_helper.dart';

import '../../../shared/network/remote/end_point.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':text,
        },
      token: token,
    ).then((value) {
      print('true in search');
      model = SearchModel.fromJson(value!.data);
      print(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print('false in search');
      print(error.toString());
      emit(SearchErrorState(error));
    });
  }
}