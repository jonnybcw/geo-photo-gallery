import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/banco_de_dados.dart';
import 'package:projeto_final/controllers/controller.dart';
import 'package:projeto_final/screens/tela_cadastro.dart';
import 'package:projeto_final/screens/tela_mapa.dart';
import 'package:projeto_final/screens/tela_visualizacao.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool loading = true;
  final Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    BancoDeDados db = BancoDeDados();
    db.openDb().then((value) {
      select();
    });
  }

  void select() {
    setState(() {
      loading = true;
    });
    controller.select().then((value) => {
          setState(() {
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galeria de fotos',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            tooltip: 'Visualizar mapa',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TelaMapa(controller: controller)));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Apagar todas as imagens',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          'Você tem certeza que deseja apagar todas as imagens?'),
                      content: Text('Esta ação é irreversível.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            controller.clearTable();
                            select();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Apagar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          tooltip: 'Tirar uma foto',
          onPressed: () {
            setState(() {
              loading = true;
            });
            controller.getImage().then((foto) async {
              if (foto != null) {
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TelaCadastro(
                    foto: foto,
                    controller: controller,
                  );
                }));
                select();
              }
              setState(() {
                loading = false;
              });
            });

          }),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                select();
              },
              child: Center(
                child: controller.fotos.isNotEmpty
                    ? Column(
                        children: [
                          Flexible(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return TelaVisualizacao(
                                                    i: i,
                                                    controller: controller,
                                                  );
                                                }));
                                        select();
                                      },
                                      child: Image.memory(
                                          controller.fotos[i].picture!,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.fotos.length,
                              padding: EdgeInsets.all(3),
                            ),
                          ),
                        ],
                      )
                    : Text('Nenhuma foto para listar.'),
              ),
            ),
    );
  }
}
