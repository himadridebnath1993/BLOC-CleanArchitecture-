part of 'currency_page.dart';

extension CurrencyUI on _CurrencyPageState {
  Widget _buildSearch() {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          focusNode: _currencyPairNode,
          controller: this._taCurrencyController,
          autofocus: false,
          decoration: InputDecoration(
              hintText: "Enter currency pair",
              fillColor: Colors.grey[200],
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              suffixIcon: Icon(Icons.search))),
      suggestionsCallback: (search) async {
        var data = await sl<FetchCurrencyList>().call(search);
        return data.fold((failure) => [], (success) => success);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion.toString().toUpperCase()));
      },
      onSuggestionSelected: (search) {
        _taCurrencyController.text = search.toString().toUpperCase();
        sl<CurrencyBloc>().add(SearchTickerEvent(search));
      },
    );
  }

  BlocBuilder _buildTickerView() {
    return BlocBuilder<CurrencyBloc, CurrencyPairState>(
      buildWhen: (prevState, currState) {
        return (currState is TickerSearchedState);
      },
      builder: (context, state) {
        return state is TickerSearchedState
            ? Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.name ?? '', style: TextStyle(fontSize: 40)),
                        Text(parseTimeStamp(
                            int.tryParse(state.currency.timestamp)))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        tInfoView("OPEN", state.currency.open),
                        tInfoView("HIGH", state.currency.high)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        tInfoView("LOW", state.currency.low),
                        tInfoView("LAST", state.currency.last)
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [tInfoView("VOLUME", state.currency.volume)])
                ],
              )
            : Container();
      },
    );
  }

  BlocBuilder _buildOrderBook() {
    return BlocBuilder<CurrencyBloc, CurrencyPairState>(
      buildWhen: (prevState, currState) {
        return (currState is TickerSearchedState ||
            currState is OrderBookLoadedState ||
            currState is OrderBookHideState);
      },
      builder: (context, state) {
        return state is TickerSearchedState || state is OrderBookHideState
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: Text("View Order Book"),
                          onPressed: () {
                            sl<CurrencyBloc>().add(ToggleOrderBookEvent());
                          }),
                    ],
                  ),
                ],
              )
            : state is OrderBookLoadedState
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              child: Text("Hide Order Book"),
                              onPressed: () {
                                sl<CurrencyBloc>()
                                    .add(ToggleOrderBookEvent(false));
                              }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("ORDER BOOK",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(children: [
                                Expanded(
                                    child: Text("BID PRICE",
                                        textAlign: TextAlign.center)),
                                Expanded(
                                    child: Text("QTY",
                                        textAlign: TextAlign.center)),
                                Expanded(
                                    child: Text("QTY",
                                        textAlign: TextAlign.center)),
                                Expanded(
                                    child: Text("ASK PRICE",
                                        textAlign: TextAlign.center))
                              ]),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.orderbooks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Row(children: [
                                      Expanded(
                                          child: Text(
                                              state.orderbooks[index].bid,
                                              textAlign: TextAlign.center)),
                                      Expanded(
                                          child: Text(
                                              state.orderbooks[index].qty,
                                              textAlign: TextAlign.center)),
                                      Expanded(
                                          child: Text(
                                              state.orderbooks[index].qty2,
                                              textAlign: TextAlign.center)),
                                      Expanded(
                                          child: Text(
                                              state.orderbooks[index].ask,
                                              textAlign: TextAlign.center))
                                    ]),
                                  );
                                })
                          ],
                        ),
                      ),
                    ],
                  )
                : Container();
      },
    );
  }

  BlocBuilder _buildStatusView() {
    return BlocBuilder<CurrencyBloc, CurrencyPairState>(
      buildWhen: (prevState, currState) {
        _snackBar.hideAll();
        if (currState is LoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _snackBar.showLoadingSnackBar();
          });
        }
        if (currState is ErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _snackBar.showErrorSnackBar(currState.message);
          });
        }
        return false;
      },
      builder: (context, state) {
        return Container();
      },
    );
  }

  Widget tInfoView(String title, String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title),
          Text("\$ ${value}", style: TextStyle(fontSize: 20))
        ]),
      ),
    );
  }
}
