import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/doctor_model.dart';
import '../../doctor/providers/consultationmodel.dart';
import 'patientrepo.dart';
import 'package:flutter_riverpod/legacy.dart' ;

class DoctorState {
  final DoctorModel? selectedDoctor;
  final List<DoctorModel> doctors;
  final bool isLoading;
  final String? error;

  DoctorState({
    this.selectedDoctor,
    this.doctors = const [],
    this.isLoading = false,
    this.error,
  }); 

  DoctorState copyWith({
    DoctorModel? selectedDoctor,
    List<DoctorModel>? doctors,
    bool? isLoading,
    String? error,
  }) {
    return DoctorState(
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      doctors: doctors ?? this.doctors,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DoctorNotifier extends StateNotifier<DoctorState> {
  final Patientrepo _repo = Patientrepo();

  DoctorNotifier() : super(DoctorState());

  Future<void> loadDoctors(String speciality) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final doctors = await _repo.getDoctorsBySpeciality(speciality);
      state = state.copyWith(doctors: doctors, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceAll('Exception: ', ''),
        isLoading: false,
      );
    }
  }

  void selectDoctor(DoctorModel doctor) {
    state = state.copyWith(selectedDoctor: doctor);
  }

  void clearSelection() {
    state = state.copyWith(selectedDoctor: null);
  }
}

class ConsultationState {
  final List<Consultationmodel> unresolved;
  final List<Consultationmodel> resolved;
  final bool isLoading;
  final String? error;

  ConsultationState({
    this.unresolved = const [],
    this.resolved = const [],
    this.isLoading = false,
    this.error,
  });

  ConsultationState copyWith({
    List<Consultationmodel>? unresolved,
    List<Consultationmodel>? resolved,
    bool? isLoading,
    String? error,
  }) {
    return ConsultationState(
      unresolved: unresolved ?? this.unresolved,
      resolved: resolved ?? this.resolved,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ConsultationNotifier extends StateNotifier<ConsultationState> {
  final Patientrepo _repo = Patientrepo();

  ConsultationNotifier() : super(ConsultationState());

  Future<void> loadUnresolved() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final unresolved = await _repo.getunresolved();
      state = state.copyWith(unresolved: unresolved, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceAll('Exception: ', ''),
        isLoading: false,
      );
    }
  }

  Future<void> loadResolved() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final resolved = await _repo.getresolved();
      state = state.copyWith(resolved: resolved, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceAll('Exception: ', ''),
        isLoading: false,
      );
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([loadUnresolved(), loadResolved()]);
  }
}

final doctorProvider = StateNotifierProvider<DoctorNotifier, DoctorState>(
  (ref) => DoctorNotifier(),
);

final consultationProvider = StateNotifierProvider<ConsultationNotifier, ConsultationState>(
  (ref) => ConsultationNotifier(),
);