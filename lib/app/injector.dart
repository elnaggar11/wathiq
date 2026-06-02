import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathiq/features/home/data/data_source/home_remote_data_source.dart';
import 'package:wathiq/features/home/data/repository/home_repo.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:wathiq/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:wathiq/features/profile/data/repository/profile_repo.dart';

import 'package:wathiq/core/api/api_consumer.dart';
import 'package:wathiq/core/api/app_interceptor.dart';
import 'package:wathiq/core/api/dio_consumer.dart';
import 'package:wathiq/core/network/network.dart';
import 'package:wathiq/core/storage/i_app_local_storage.dart';
import 'package:wathiq/core/storage/shared_preference.dart';
import 'package:wathiq/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:wathiq/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:wathiq/features/auth/data/repository/auth_repo.dart';
import 'package:wathiq/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:wathiq/features/paegs/data/data_source/pages_remote_data_source.dart';
import 'package:wathiq/features/paegs/data/repository/pages_repo.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:wathiq/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:wathiq/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:wathiq/features/wallet/data/repository/wallet_repo.dart';
import 'package:wathiq/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  //! Bloc
  await _setUpBloc();

  //! Repo
  await _setUpRepository();
  //! DataSource
  await _setUpDatasource();
  //! Utils
  await _setUpUtils();
  //!External
  await _setUpExternal();
}

Future<void> _setUpBloc() async {
  serviceLocator.registerLazySingleton(
    () => AuthCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => PagesCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ProfileCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => HomeCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => WalletCubit(
      serviceLocator(),
    ),
  );
  //     // serviceLocator.registerLazySingleton(
  //     //   () => DownloadsCubit(
  //     //     serviceLocator(),
  //     //   ),
  //     // );
  //     // serviceLocator.registerLazySingleton(
  //     //   () => HomeCubit(
  //     //     serviceLocator(),
  //     //   ),
  //     // );

  //     // serviceLocator.registerLazySingleton(
  //     //   () => ProfileCubit(
  //     //     serviceLocator(),
  //     //   ),
  //     // );
  //     // serviceLocator.registerLazySingleton(
  //     //   () => FormsAndQuestionsCubit(
  //     //     serviceLocator(),
  //     //   ),
  //     );
}

Future<void> _setUpRepository() async {
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PagesRepository>(
    () => PagesRepository(
      remoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      remoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepository(
      remoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<WalletRepository>(
    () => WalletRepository(
      remoteDataSource: serviceLocator(),
    ),
  );

  // serviceLocator.registerLazySingleton<HomeRepository>(
  //   () => HomeRepository(
  //     remoteDataSource: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton<ProfileRepository>(
  //   () => ProfileRepository(
  //     remoteDataSource: serviceLocator(),
  //     localDataSource: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton<FormsAndQuestionsRepository>(
  //   () => FormsAndQuestionsRepository(
  //     remoteDataSource: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerLazySingleton<DownloadsRepository>(
  //   () => DownloadsRepository(
  //     remoteDataSource: serviceLocator(),
  //   ),
  // );
}

Future<void> _setUpDatasource() async {
  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(apiConsumer: serviceLocator()));

  serviceLocator.registerLazySingleton<PagesRemoteDataSource>(
      () => PagesRemoteDataSource(apiConsumer: serviceLocator()));

  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSource(apiConsumer: serviceLocator()));

  serviceLocator.registerLazySingleton<WalletRemoteDataSource>(
      () => WalletRemoteDataSource(apiConsumer: serviceLocator()));
  // serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
  //     () => ProfileRemoteDataSource(serviceLocator()));

  // serviceLocator.registerLazySingleton<HomeRemoteDataSource>(
  //     () => HomeRemoteDataSource(serviceLocator()));
  // serviceLocator.registerLazySingleton<FormsAndQuestionsRemoteDataSource>(
  //     () => FormsAndQuestionsRemoteDataSource(serviceLocator()));
  // serviceLocator.registerLazySingleton<DownloadsRemoteDataSource>(
  //     () => DownloadsRemoteDataSource(serviceLocator()));
}

Future<void> _setUpUtils() async {
  serviceLocator.registerLazySingleton<NetworkInformation>(
    () => NetworkInformationImplementation(
      internetConnectionChecker: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<IAppLocalStorage>(
    () => SharedPreferenceLocalStorageImplementation(
      shared: serviceLocator(),
    ),
  );
}

Future<void> _setUpExternal() async {
  //! Inject SharedPreferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => AppInterceptor());
  serviceLocator.registerLazySingleton(
    () => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 60,
    ),
  );
  serviceLocator.registerLazySingleton(() => Dio());

  serviceLocator.registerLazySingleton(
    () => DioConsumer(
      dio: serviceLocator(),
    ),
  );
}
