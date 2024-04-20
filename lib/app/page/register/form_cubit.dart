import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/entities/form_register.dart';
import 'package:rongchoi_app/domain/entities/language.dart';

class FormRegisterCubit extends Cubit<FormRegister>{

  FormRegisterCubit() : super(FormRegister('', '', '', '', '', ''));

  void changeForm(FormRegister form) => emit(form); 

}