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
import '../../feature/auth/presentation/bloc/auth_bloc.dart' as _i13;
import '../../feature/landing/data/repository_imp.dart' as _i7;
import '../../feature/landing/domain/dashboard_repository.dart' as _i6;
import '../../feature/landing/presentation/bloc/dashboard_bloc.dart' as _i12;
import '../../feature/onboarding/bloc/onboarding_cubit.dart' as _i3;
import '../../feature/pickup_request/data/request_repository_impl.dart' as _i9;
import '../../feature/pickup_request/domain/request_repository.dart' as _i8;
import '../../feature/pickup_request/presentation/bloc/request_bloc.dart'
    as _i15;
import '../../feature/profile/data/profile_repository_impl.dart' as _i11;
import '../../feature/profile/domain/profile_repository.dart' as _i10;
import '../../feature/profile/presentation/bloc/user_bloc.dart' as _i14;

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
  gh.factory<_i6.DashboardRepository>(() => _i7.DashboardRepositoryImp());
  gh.factory<_i8.RequestRepository>(() => _i9.RequestRepositoryImp());
  gh.factory<_i10.ProfileRepository>(() => _i11.ProfileRepositoryImpl());
  gh.factory<_i12.DashboardCubit>(() =>
      _i12.DashboardCubit(dashboardRepository: gh<_i6.DashboardRepository>()));
  gh.factory<_i13.AuthCubit>(
      () => _i13.AuthCubit(gh<_i4.AuthenticationRepository>()));
  gh.factory<_i14.UserCubit>(
      () => _i14.UserCubit(gh<_i10.ProfileRepository>()));
  gh.factory<_i15.RequestCubit>(
      () => _i15.RequestCubit(gh<_i8.RequestRepository>()));
  return getIt;
}
