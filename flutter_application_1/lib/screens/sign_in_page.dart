import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/locator.dart';
import 'package:provider/provider.dart';
import '../viewmodels/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _editingController = TextEditingController();

    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel model, Widget? child) =>
            Scaffold(
          appBar: AppBar(
            title: Text('Sign In for ChatApp'),
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: model.busy
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('User Name'),
                      TextField(
                        controller: _editingController,
                      ),
                      ElevatedButton(
                          child: Text('Sign In'),
                          onPressed: () async => {
                                await model.signIn(_editingController.text),
                              })
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
