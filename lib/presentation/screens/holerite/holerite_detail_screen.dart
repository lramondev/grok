import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_bloc.dart';
import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_event.dart';
import 'package:grok/presentation/blocs/holerite_detail/holerite_detail_state.dart';

import 'package:grok/data/models/holerite_model.dart';

class HoleriteDetailScreen extends StatelessWidget {
  const HoleriteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NumberFormat decimalFormat = NumberFormat.currency(symbol: '', locale: 'pt_BR', decimalDigits: 2);
    HoleriteModel? holerite = ModalRoute.of(context)!.settings.arguments as HoleriteModel?;

    if (holerite != null) {
      context.read<HoleriteDetailBloc>().add(LoadDetail(holerite: holerite));
    }
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes ${holerite!.folha.descricao}'),
        elevation: 1,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/holerite/detail/pdf', arguments: holerite);
        },
        child: Icon(Icons.print)
      ),
      body: BlocConsumer<HoleriteDetailBloc, HoleriteDetailState>(
        listener: (context, state) {
          if (state is HoleriteDetailError) {
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
          if(state is HoleriteDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HoleriteDetailLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                            
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Text('Proventos ( + )', style: TextStyle(fontSize: 20)),
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(12),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(5)
                      },
                      children: state.eventos.where((e) => e.valor > 0).map((e) => 
                        TableRow(
                          children: [
                            TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(e.evento_tipo.descricao, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                              ),
                            )
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(decimalFormat.format(e.quantidade), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
                              ),
                            )
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text('R\$ ${decimalFormat.format(e.valor)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
                              ),
                            )
                          )
                        ]
                      )).toList()
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: Text('Descontos ( - )', style: TextStyle(fontSize: 20)),
                    ),
                    Table(
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(12),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(5)
                      },
                      children: state.eventos.where((e) => e.valor < 0).map((e) => 
                        TableRow(
                          children: [
                            TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(e.evento_tipo.descricao, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                              ),
                            )
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(decimalFormat.format(e.quantidade), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
                              ),
                            )
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text('R\$ ${decimalFormat.format(e.valor)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
                              ),
                            )
                          )
                        ]
                      )).toList()
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Text('R\$ ${decimalFormat.format(state.eventos.map((e) => e.valor).reduce((a, b) => a + b))}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}