import 'package:chopper/chopper.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_local_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_remote_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/repositories/currency_repository_impl.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_currency_list.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_currency_ticker.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_order_book.dart';
import 'package:deep_rooted_task/screens/currency_pair/presentation/blocs/currency_pair/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:deep_rooted_task/core/network/network_info.dart';
import 'package:deep_rooted_task/core/network/rest_client_service.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerLazySingleton(
      () => CurrencyBloc(fetchCurrencyPair: sl(), fetchOrderBook: sl()));

  //Use cases
  sl.registerLazySingleton(() => FetchCurrencyTicker(repository: sl()));
  sl.registerLazySingleton(() => FetchOrderBook(repository: sl()));
  sl.registerLazySingleton(() => FetchCurrencyList(repository: sl()));

  //Repositories
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(
        localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()),
  );

  //Data sources
  sl.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrencyLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(restClientService: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );

  sl.registerLazySingleton(() => DataConnectionChecker());
  final client = ChopperClient(interceptors: [
    CurlInterceptor(),
    HttpLoggingInterceptor(),
  ]);
  sl.registerLazySingleton(() => RestClientService.create(client));
}
