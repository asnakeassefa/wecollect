// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../feature/auth/data/auth_repository_impl.dart' as _i6;
import '../../feature/auth/domain/auth_repostiory.dart' as _i5;
import '../../feature/auth/presentation/bloc/auth_bloc.dart' as _i7;
import '../../feature/onboarding/bloc/onboarding_cubit.dart' as _i3;
import '../network/api_provider.dart' as _i4;

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
  gh.lazySingleton<_i4.ApiProivder>(() => _i4.ApiProivder());
  gh.factory<_i5.AuthenticationRepository>(
      () => _i6.AuthenticationRepositoryImp());
  gh.factory<_i7.AuthCubit>(
      () => _i7.AuthCubit(gh<_i5.AuthenticationRepository>()));
  return getIt;
}
