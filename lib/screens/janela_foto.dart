import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projeto_final/helpers/date_formatter.dart';
import 'package:projeto_final/models/foto.dart';

class JanelaFoto extends StatelessWidget {
  const JanelaFoto({required this.foto, Key? key}) : super(key: key);

  final Foto foto;

  @override
  Widget build(BuildContext context) {
    Uint8List? picture = foto.picture;
    return Dialog(
      child: SizedBox(
        width: 350,
        height: 550,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Text('Detalhes da foto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(picture != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image.memory(picture),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  text: 'Título: ',
                                ),
                                TextSpan(
                                  text: '${foto.titulo}',
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  text: '\nDescrição: ',
                                ),
                                TextSpan(
                                  text: '${foto.descricao}',
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  text: '\nData: ',
                                ),
                                TextSpan(
                                  text: DateFormatter.formatDate(foto.date),
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  text: '\nLatitude: ',
                                ),
                                TextSpan(
                                  text: '${foto.latitude}',
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  text: '\nLongitude: ',
                                ),
                                TextSpan(
                                  text: '${foto.longitude}',
                                ),
                              ]
                            ),
                          ),
                        ),
                        SizedBox(height: 24,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
