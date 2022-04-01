import 'package:deep_rooted_task/screens/currency_pair/presentation/blocs/currency_pair/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deep_rooted_task/core/utils/constants.dart';
import 'package:deep_rooted_task/core/utils/theme.dart';
import 'package:deep_rooted_task/core/widgets/custom_snak_bar.dart';

import '../../../../injection_container.dart';

class CurrencyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _viewNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar _snackBar;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    _emailNode?.dispose();
    _passwordNode?.dispose();
    _viewNode?.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _snackBar = CustomSnackBar(key: Key("snackbar"), scaffoldKey: _scaffoldKey);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewNode),
      child: Scaffold(
        key: _scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: CustomColor.statusBarColor,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  BlocProvider<CurrencyBloc> _buildBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isKeyboardOpen = (MediaQuery.of(context).viewInsets.bottom > 0);
    return BlocProvider<CurrencyBloc>(
      create: (_) => sl<CurrencyBloc>(),
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(DEFAULT_PAGE_PADDING),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            ],
          ),
        ),
      ),
    );
  }
}
