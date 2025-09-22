import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:grok/presentation/blocs/auth/auth_bloc.dart';
import 'package:grok/presentation/blocs/auth/auth_state.dart';
import 'package:grok/presentation/blocs/auth/auth_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _maskCpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var _rememberMe = false;

  Future<void> _loadSavedCredentials() async {
    final savedCredentials = await context.read<AuthBloc>().loadSavedCredentials();
    if (savedCredentials != null) {
      setState(() {
        if(savedCredentials['cpf'] != null) {
          _cpfController.text = _maskCpfFormatter.maskText(savedCredentials['cpf'] ?? '');
        }
        _passwordController.text = savedCredentials['password'] ?? '';
        _rememberMe = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  BlocListener<AuthBloc, AuthState> (
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      Text(' ${state.message}')
                    ],
                  ),
                  duration: Duration(seconds: 4),
                ),
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.only(top: 36, bottom: 36),
                      child: Image.asset('assets/img/transoeste-sm.png'),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _cpfController,
                        decoration: InputDecoration(labelText: 'CPF'),
                        inputFormatters: [ _maskCpfFormatter ],
                        keyboardType: TextInputType.numberWithOptions(),
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) => setState(() => _rememberMe = value ?? false),
                            ),
                          ),
                          Text('Lembrar-me'),
                        ],
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              AuthLogin(
                                _maskCpfFormatter.unmaskText(_cpfController.text),
                                _passwordController.text,
                                rememberMe: _rememberMe
                              ),
                            );
                          },
                          child: BlocBuilder <AuthBloc, AuthState>(
                            builder: (context, state) {
                              if(state is AuthLoading) {
                                return CircularProgressIndicator();
                              } else {
                                return Text('Entrar', style: TextStyle(fontSize: 18));
                              }
                            },
                          )
                        ),
                      ),
                    )
                  ],
                )
              )
            ]
          ),
        ), 
      )
    );
  }
}
