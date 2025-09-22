import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/holerite/holerite_bloc.dart';
import 'package:grok/presentation/blocs/holerite/holerite_event.dart';
import 'package:grok/presentation/blocs/holerite/holerite_state.dart';

class HoleriteScreen extends StatelessWidget {
  const HoleriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NumberFormat decimalFormat = NumberFormat.currency(symbol: '', locale: 'pt_BR', decimalDigits: 2);
    context.read<HoleriteBloc>().add(LoadHolerites());

    return BlocBuilder<HoleriteBloc, HoleriteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Holerite'),
            elevation: 1,
            iconTheme: IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
            ),
          ),
          body: BlocConsumer<HoleriteBloc, HoleriteState>(
            listener:(context, state) {
              if (state is HoleriteError) {
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
              if(state is HoleriteLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HoleriteLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    itemCount: state.holerites.length,
                    separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final holerite = state.holerites[index];
                      return ListTile(
                        title: Text('REF ${holerite.folha.descricao}'),
                        subtitle: Text('Total: R\$ ${decimalFormat.format(holerite.total)}'),
                        trailing: holerite.status.id == 1 ? Icon(Icons.fingerprint) : Icon(Icons.check, color: Colors.greenAccent),
                        onTap: () {
                          Navigator.pushNamed(context, '/holerite/detail', arguments: holerite).then((onValue) => {
                            context.read<HoleriteBloc>().add(LoadHolerites())
                          });
                        } 
                      );
                    },
                  ),
                );
              }
              return Center(child: Text('Nenhum holerite para assinar'));
            },
          )
        );
      } 
    );
  }
}