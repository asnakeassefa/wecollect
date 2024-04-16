// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/auth/data/auth_repository_impl.dart' as _i5;
import '../../feature/auth/domain/auth_repostiory.dart' as _i4;
import '../../feature/auth/presentation/bloc/auth_bloc.dart' as _i6;
import '../../feature/onboarding/bloc/onboarding_cubit.dart' as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.OnboardingCubit>(() => _i3.OnboardingCubit());
  gh.factory<_i4.AuthenticationRepository>(
      () => _i5.AuthenticationRepositoryImp());
  gh.factory<_i6.AuthCubit>(
      () => _i6.AuthCubit(gh<_i4.AuthenticationRepository>()));
  return getIt;
}
