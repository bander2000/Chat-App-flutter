import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/widget/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final Function submitFn;

   AuthForm(this.isLoading, this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {


   


    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
                child: Column(
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email address'),
                  validator: (value) {
                    if (value.isEmpty || ! value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'UserName'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(height: 12),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign up'),
                    onPressed: _trySubmit,
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
