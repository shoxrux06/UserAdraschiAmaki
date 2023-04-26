import 'package:afisha_market/core/bloc/add/create_event.dart';
import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/data/repository/product_repository.dart';
import 'package:afisha_market/core/data/source/remote/response/addResponse.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final ProductRepository productRepository;

  CreateBloc(this.productRepository)
      : super(CreateState(createResponse: CreateResponse())) {
    on<CreateInitialEvent>((event, emit) {
      emit(state.copyWith(
          status: Status.initial,
          photos: [],
          name: '',
          cost: 0,
          desc: '',
          category: 8,
          color: '',
          compatibility: ''));
    });

    on<CreateSuccessEvent>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      var response = await productRepository.createProduct(event.createRequest);
      response.when(
        success: (data) {
          emit(state.copyWith(status: Status.success));
        },
        failure: (failure) {},
      );
    });
  }
}
