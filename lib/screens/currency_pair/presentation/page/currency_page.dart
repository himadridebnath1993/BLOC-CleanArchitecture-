import 'package:deep_rooted_task/core/utils/utils.dart';
import 'package:deep_rooted_task/screens/currency_pair/presentation/blocs/currency_pair/bloc.dart';
import 'package:deep_rooted_task/screens/currency_pair/domain/usecases/fetch_currency_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_rooted_task/core/utils/constants.dart';
import 'package:deep_rooted_task/core/utils/theme.dart';
import 'package:deep_rooted_task/core/widgets/custom_snak_bar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../injection_container.dart';
part 'currency_ui.dart';

class CurrencyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _taCurrencyController = TextEditingController();

  final FocusNode _currencyPairNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar _snackBar;
  CurrencyBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _currencyPairNode?.dispose();
    _taCurrencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _snackBar = CustomSnackBar(key: Key("snackbar"), scaffoldKey: _scaffoldKey);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_currencyPairNode),
      child: SafeArea(child: _buildBody(context)),
    );
  }

  BlocProvider<CurrencyBloc> _buildBody(BuildContext context) {
    return BlocProvider<CurrencyBloc>(
      create: (context) => sl<CurrencyBloc>(),
      lazy: false,
      child: Scaffold(
        key: _scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: CustomColor.statusBarColor,
          ),
          child: Container(
            padding: EdgeInsets.all(DEFAULT_PAGE_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildSearch(),
                Padding(padding: EdgeInsets.only(top: 30)),
                _buildTickerView(),
                _buildOrderBook(),
                _buildStatusView()
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFabButton(),
      ),
    );
  }

  BlocBuilder _buildFabButton() {
    return BlocBuilder<CurrencyBloc, CurrencyPairState>(
      buildWhen: (prevState, currState) {
        return (currState is TickerSearchedState);
      },
      builder: (context, state) {
        return state is TickerSearchedState
            ? FloatingActionButton(
                onPressed: () {
                  sl<CurrencyBloc>()
                      .add(SearchTickerEvent(sl<CurrencyBloc>().config));
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.replay_outlined),
              )
            : Container();
      },
    );
  }
}
