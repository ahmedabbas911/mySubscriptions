// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce_flutter/hive_flutter.dart' as _i919;
import 'package:injectable/injectable.dart' as _i526;

import '../../../subscriptions/core/di/subscriptions_module.dart' as _i322;
import '../../../subscriptions/data/data_source/local/subscription_local_data_source.dart'
    as _i546;
import '../../../subscriptions/data/models/subscription_model.dart' as _i199;
import '../../../subscriptions/data/repo_imp/subscription_repo_impl.dart'
    as _i293;
import '../../../subscriptions/domain/repo/subscription_repo.dart' as _i559;
import '../../../subscriptions/domain/use_case/add_subscription_usecase.dart'
    as _i358;
import '../../../subscriptions/domain/use_case/delete_subscription_usecase.dart'
    as _i869;
import '../../../subscriptions/domain/use_case/get_subscriptions_usecase.dart'
    as _i720;
import '../../../subscriptions/domain/use_case/update_subscription_usecase.dart'
    as _i406;
import '../../../subscriptions/presentation/cubit/subscription_cubit.dart'
    as _i519;
import '../../data/data_source/auth_remote_data_source.dart' as _i697;
import '../../data/repo_imp/auth_repo_impl.dart' as _i677;
import '../../domain/repo/auth_repo.dart' as _i716;
import '../../domain/use_case/get_current_user_usecase.dart' as _i454;
import '../../domain/use_case/login_usecase.dart' as _i151;
import '../../domain/use_case/logout_usecase.dart' as _i751;
import '../../domain/use_case/register_usecase.dart' as _i600;
import '../../domain/use_case/send_password_reset_email_usecase.dart' as _i111;
import '../../presentation/cubit/auth_cubit.dart' as _i729;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final subscriptionsModule = _$SubscriptionsModule();
    final appModule = _$AppModule();
    await gh.factoryAsync<_i919.Box<_i199.SubscriptionModel>>(
      () => subscriptionsModule.subscriptionBox,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.factory<_i546.SubscriptionLocalDataSource>(
      () => _i546.SubscriptionLocalDataSource(
        gh<_i738.Box<_i199.SubscriptionModel>>(),
      ),
    );
    gh.factory<_i697.AuthRemoteDataSource>(
      () => _i697.AuthRemoteDataSource(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i716.AuthRepo>(
      () => _i677.AuthRepoImpl(gh<_i697.AuthRemoteDataSource>()),
    );
    gh.factory<_i559.SubscriptionRepo>(
      () => _i293.SubscriptionRepoImpl(
        gh<_i546.SubscriptionLocalDataSource>(),
        gh<_i716.AuthRepo>(),
      ),
    );
    gh.factory<_i358.AddSubscriptionUseCase>(
      () => _i358.AddSubscriptionUseCase(gh<_i559.SubscriptionRepo>()),
    );
    gh.factory<_i869.DeleteSubscriptionUseCase>(
      () => _i869.DeleteSubscriptionUseCase(gh<_i559.SubscriptionRepo>()),
    );
    gh.factory<_i720.GetSubscriptionsUseCase>(
      () => _i720.GetSubscriptionsUseCase(gh<_i559.SubscriptionRepo>()),
    );
    gh.factory<_i406.UpdateSubscriptionUseCase>(
      () => _i406.UpdateSubscriptionUseCase(gh<_i559.SubscriptionRepo>()),
    );
    gh.factory<_i519.SubscriptionCubit>(
      () => _i519.SubscriptionCubit(
        gh<_i720.GetSubscriptionsUseCase>(),
        gh<_i358.AddSubscriptionUseCase>(),
        gh<_i406.UpdateSubscriptionUseCase>(),
        gh<_i869.DeleteSubscriptionUseCase>(),
      ),
    );
    gh.factory<_i454.GetCurrentUserUseCase>(
      () => _i454.GetCurrentUserUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i151.LoginUseCase>(
      () => _i151.LoginUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i751.LogoutUseCase>(
      () => _i751.LogoutUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i600.RegisterUseCase>(
      () => _i600.RegisterUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i111.SendPasswordResetEmailUseCase>(
      () => _i111.SendPasswordResetEmailUseCase(gh<_i716.AuthRepo>()),
    );
    gh.factory<_i729.AuthCubit>(
      () => _i729.AuthCubit(
        gh<_i151.LoginUseCase>(),
        gh<_i600.RegisterUseCase>(),
        gh<_i751.LogoutUseCase>(),
        gh<_i111.SendPasswordResetEmailUseCase>(),
        gh<_i454.GetCurrentUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$SubscriptionsModule extends _i322.SubscriptionsModule {}

class _$AppModule extends _i460.AppModule {}
