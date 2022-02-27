part of 'motiphrase_bloc.dart';

abstract class MotiphraseState extends Equatable {
  const MotiphraseState();
  
  @override
  List<Object> get props => [];
}

class MotiphraseInitial extends MotiphraseState {}

class MotiphraseErrorState extends MotiphraseState{
  final String errMsg;

  MotiphraseErrorState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}

class MotiphraseReady extends MotiphraseState{
  final String frase;
  final String autor;

  MotiphraseReady({required this.frase, required this.autor});

  @override
  List<Object> get props => [frase, autor];
}