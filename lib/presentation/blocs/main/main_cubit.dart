import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_state.dart';

class MainCubit extends Cubit<int> {
  final PageController controller = PageController();
  MainCubit() : super(0);

  void update(int value) {
    emit(value);
  }
}
