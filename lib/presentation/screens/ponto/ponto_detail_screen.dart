import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_bloc.dart';
import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_event.dart';
import 'package:grok/presentation/blocs/ponto_detail/ponto_detail_state.dart';

import 'package:grok/data/models/ponto_model.dart';
import 'package:grok/data/models/ponto_registro_model.dart';

class PontoDetailScreen extends StatefulWidget {
  const PontoDetailScreen({super.key});

  @override
  State<PontoDetailScreen> createState() => _PontoDetailScreenState();
}

class _PontoDetailScreenState extends State<PontoDetailScreen> {
  final dateFormat = DateFormat('dd/MM/yyyy');
  final weekFormat = DateFormat('EEEE', 'pt_BR');

  TimeOfDay? primeira_hora_inicio;
  TimeOfDay? primeira_hora_fim;
  TimeOfDay? segunda_hora_inicio;
  TimeOfDay? segunda_hora_fim;

  Future<void> selectTime(BuildContext context, TimeOfDay? time, Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: Locale('pt', 'BR'),
          delegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: Builder(
            builder: (BuildContext context) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                ),
                child: child!,
              );
            },
          ),
        );
      },
    );
    if (picked != null && picked != time) {
      setState(() => onTimeSelected(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    PontoModel? ponto = ModalRoute.of(context)!.settings.arguments as PontoModel?;

    if (ponto != null) {
      context.read<PontoDetailBloc>().add(LoadDetail(ponto: ponto));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        elevation: 1,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.save)
      ),
      body: BlocConsumer<PontoDetailBloc, PontoDetailState>(
        listener: (context, state) {
          if (state is PontoDetailError) {
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
          if(state is PontoDetailLoading) {
            return Center(child: CircularProgressIndicator());
          } else if(state is PontoDetailLoaded) {
            final PontoRegistroModel registro = state.registro;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      children: [
                        Text(dateFormat.format(DateTime.parse(ponto!.data)), style: TextStyle(fontSize: 26)),
                        Text(weekFormat.format(DateTime.parse(ponto.data)), style: TextStyle(fontSize: 20))
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [

                      Divider(),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                        child: Text('1º Período', style: TextStyle(fontSize: 24)),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(registro.registro_primeira_hora_inicio == null) 
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(primeira_hora_inicio != null ? primeira_hora_inicio!.format(context) : '00:00', style: TextStyle(fontSize: 24, color: Colors.red)),
                              ),
                              onTap: () => selectTime(context, primeira_hora_inicio, (picked) => primeira_hora_inicio = picked),
                            ),
                          if(registro.registro_primeira_hora_inicio != null) 
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(registro.registro_primeira_hora_inicio ?? '', style: TextStyle(fontSize: 24)),
                            ),
                          
                          if(registro.registro_primeira_hora_fim == null) 
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(primeira_hora_fim != null ? primeira_hora_fim!.format(context) : '00:00', style: TextStyle(fontSize: 24, color: Colors.red)),
                              ),
                              onTap: () => selectTime(context, primeira_hora_fim, (picked) => primeira_hora_fim = picked),
                            ),
                          if(registro.registro_primeira_hora_fim != null) 
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(registro.registro_primeira_hora_fim ?? '', style: TextStyle(fontSize: 24)),
                            ),
                        ],
                      ),
                    
                      Divider(),
                      
                      if(registro.segunda_hora_inicio != null && registro.segunda_hora_fim != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                          child: Text('2º Período', style: TextStyle(fontSize: 24)),
                        ),

                      if(registro.segunda_hora_inicio != null && registro.segunda_hora_fim != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if(registro.registro_segunda_hora_inicio == null)
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(segunda_hora_inicio != null ? segunda_hora_inicio!.format(context) : '00:00', style: TextStyle(fontSize: 24, color: Colors.red)),
                                ),
                                onTap: () => selectTime(context, segunda_hora_inicio, (picked) => segunda_hora_inicio = picked),
                              ),
                            if(registro.registro_segunda_hora_inicio != null)
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(registro.registro_segunda_hora_inicio ?? '', style: TextStyle(fontSize: 24)),
                              ),

                            if(registro.registro_segunda_hora_fim == null)
                              InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(segunda_hora_fim != null ? segunda_hora_fim!.format(context) : '00:00', style: TextStyle(fontSize: 24, color: Colors.red)),
                                ),
                                onTap: () => selectTime(context, segunda_hora_fim, (picked) => segunda_hora_fim = picked),
                              ),
                            if(registro.registro_segunda_hora_fim != null)
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(registro.registro_segunda_hora_fim ?? '', style: TextStyle(fontSize: 24)),
                              )
                          ]
                        )
                    ],
                  ),
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}