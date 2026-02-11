import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'docrepo.dart';
import './consultationmodel.dart';
final docrepoprovider= Provider((ref)=>DocRepo());
final normalcasesprovider=FutureProvider<List<Consultationmodel>> ((ref) async {
  return ref.watch(docrepoprovider).getnormal();

});
final emergencycasesprovider=FutureProvider<List<Consultationmodel>> ((ref) async {
  return ref.watch(docrepoprovider).getemergency();

});

final historycasesprovider=FutureProvider<List<Consultationmodel>> ((ref) async {
  return ref.watch(docrepoprovider).gethistory();

});

final consultprovider=FutureProvider.family<Consultationmodel, String>((ref, consultId) async {
  return ref.watch(docrepoprovider).getconsult(consultId);
});