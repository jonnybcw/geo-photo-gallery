import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/controller.dart';

class TelaVisualizacao extends StatelessWidget {
  TelaVisualizacao({required this.i, required this.controller, Key? key})
      : super(key: key);

  final Controller controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    String? titulo = controller.fotos[i].titulo;
    String? descricao = controller.fotos[i].descricao;
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo ?? 'Foto'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.remove(i).then((value) {
            Navigator.of(context).pop();
          });
        },
        label: Text('Excluir'),
      ),
      body: SingleChildScrollView(
        child: controller.fotos[i].picture != null
            ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.memory(controller.fotos[i].picture!),
                SizedBox(
                  height: 12,
                ),
                if(descricao != null && descricao.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      descricao,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16, color: Colors.white,),
                    ),
                  ),
                if(descricao != null  && descricao.isNotEmpty)
                  SizedBox(
                    height: 12,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: RichText(text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.3,
                    ),
                    children: [
                    TextSpan(
                        text: 'Data: ${DateTime.parse(controller.fotos[i].date!).day}'
                            '/${DateTime.parse(controller.fotos[i].date!).month}/${DateTime.parse(controller.fotos[i].date!).year}'),
                    TextSpan(
                        text: '\nLatitude: ${controller.fotos[i].latitude!.toStringAsFixed(4)}'),
                    TextSpan(
                        text: '\nLongitude: ${controller.fotos[i].longitude!.toStringAsFixed(4)}'),
                  ],),),
                ),
              ],
            )
            : Center(
                child: RefreshProgressIndicator(),
              ),
      ),
    );
  }
}
