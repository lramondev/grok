import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_bloc.dart';
import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_event.dart';
import 'package:grok/presentation/blocs/holerite_detail_pdf/holerite_detail_pdf_state.dart';

import 'package:grok/data/models/holerite_model.dart';

class HoleriteDetailPdfScreen extends StatelessWidget {

  const HoleriteDetailPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    HoleriteModel? holerite = ModalRoute.of(context)!.settings.arguments as HoleriteModel?;
    String? filePath;

    if(holerite != null) {
      context.read<HoleriteDetailPdfBloc>().add(PrintHolerite(holerite));
    }

    Future<void> sharePdf(context) async {
      if (filePath != null) {
        await Share.shareXFiles([XFile(filePath!)], text: 'Holerite ${holerite?.id}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF não está pronto para compartilhamento')));
      }
    }

    Future<void> savePdfToDevice(context) async {
      if (await Permission.storage.request().isGranted) {
        try {
          final sourceFile = File(filePath!);
          final documentsDir = await getDownloadsDirectory();
          final destinationPath = '$documentsDir/holerite_${holerite?.id}.pdf'.replaceAll("'", "");
          await sourceFile.copy(destinationPath);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF salvo em $destinationPath')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar PDF $e')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Permissão de armazenamento negada')));
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar ${holerite!.folha.descricao}'),
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () => sharePdf(context),
              tooltip: 'Compartilhar PDF',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 8),
            child: IconButton(
              icon: Icon(Icons.download),
              onPressed: () => savePdfToDevice(context),
              tooltip: 'Salvar PDF',
            ),
          ),
        ],
      ),
      body: BlocBuilder<HoleriteDetailPdfBloc, HoleriteDetailPdfState>(
        builder: (context, state) {
          if(state is HoleriteDetailPdfLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HoleriteDetailPdfPrinted) {
            filePath = state.file.path;
            return PDFView(
              filePath: filePath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              backgroundColor: theme.scaffoldBackgroundColor,
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao renderizar PDF')));
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
