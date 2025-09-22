import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/ponto/ponto_bloc.dart';
import 'package:grok/presentation/blocs/ponto/ponto_event.dart';
import 'package:grok/presentation/blocs/ponto/ponto_state.dart';

class PontoScreen extends StatelessWidget {
  const PontoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    context.read<PontoBloc>().add(LoadPontos());

    return BlocBuilder<PontoBloc, PontoState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Ponto'),
            elevation: 1,
            iconTheme: IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
            ),
          ),
          body: BlocConsumer<PontoBloc, PontoState>(
            listener:(context, state) {
              if (state is PontoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            },
            builder: (context, state) {
              if(state is PontoLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PontoLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: state.pontos.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final ponto = state.pontos[index];
                      return ListTile(
                        title: Text(dateFormat.format(DateTime.parse(ponto.data))),
                        subtitle: Text(ponto.resultado),
                        trailing: ponto.batidas != ponto.esperadas ? Icon(Icons.error) : Icon(Icons.check, color: Colors.greenAccent),
                        onTap: () {
                          Navigator.pushNamed(context, '/ponto/detail', arguments: ponto).then((onValue) => {
                            context.read<PontoBloc>().add(LoadPontos())
                          });
                        } 
                      );
                    },
                  ),
                );
              }
              return Center(child: Text('Nenhum ponto para justificar'));
            },
          )
        );
      } 
    );
  }
}