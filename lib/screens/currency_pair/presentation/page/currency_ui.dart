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
