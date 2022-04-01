import 'package:chopper/chopper.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:deep_rooted_task/core/usecases/fetch_currency_pair.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/datasources/currency_local_datasource.dart';
import 'package:deep_rooted_task/screens/currency_pair/data/repositories/currency_repository_impl.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/repositories/currency_repository.dart';
import 'package:deep_rooted_task/screens/currency_pair/presentation/blocs/currency_pair/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:deep_rooted_task/core/network/network_info.dart';
import 'package:deep_rooted_task/core/network/rest_client_service.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerFactory(
    () => CurrencyBloc(
      fetchCurrencyPair: sl()
    )..add(SearchEvent('')),
  );
  

  //Use cases
  sl.registerLazySingleton(() => FetchCurrencyPair(repository:  sl()));

  //Repositories
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepositoryImpl(
      localDataSource: sl()
    ),
  );


  //Data sources
  sl.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrencyLocalDataSourceImpl(),
  );
  

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );
}
