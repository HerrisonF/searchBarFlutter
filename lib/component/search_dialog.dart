import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  List<String> textos = [
    'Banana',
    'Balde',
    'Macarrão',
    'Escova',
  ];

  List<String> termosMaisBuscados = [
    'óleo',
    'arroz',
    'hamburguer',
    'cerveja',
    'óleo',
    'teste',
    'teste2'
  ];

  List<String> lista;

  String example;

  @override
  void initState() {
    lista = [];

    example = "";
  }

  Future<List<String>> _getTextos() async {
    await Future.delayed(Duration(seconds: 3), () {
      lista.clear();
      for (String c in textos) {
        print('$example,$c');
        if (c.toLowerCase().contains(example.toLowerCase())) {
          lista.add(c);
        }
      }
    });
    return lista;
  }

  Future<List<String>> _getTermosMaisBuscados() async {
    await Future.delayed(Duration(seconds: 1));

    return termosMaisBuscados;
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(64.0),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (text) {
                                    setState(() {
                                      example = text;
                                    });
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    hintText: 'Pesquise o item que deseja',
                                    suffixIcon: Container(
                                      margin: EdgeInsets.only(right: 24.0),
                                      child: InkWell(
                                        onTap: () {
                                          _searchController.clear();
                                          setState(() {
                                            example = "";
                                          });
                                        },
                                        child: Visibility(
                                          visible: example.length > 0,
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    prefixIcon: InkWell(
                                      onTap: Navigator.of(context).pop,
                                      child: Icon(
                                        Icons.arrow_back_sharp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  textInputAction: TextInputAction.search,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 24.0),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(Icons.record_voice_over),
                          ),
                        ),
                      ],
                    ),
                    example.length > 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06),
                            child: FutureBuilder<List<String>>(
                              future: _getTextos(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                  case ConnectionState.none:
                                    return Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 3,
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.red[200],
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.red),
                                        ),
                                      ),
                                    );
                                    break;
                                  case ConnectionState.done:
                                    if (!snapshot.hasError &&
                                        snapshot.data.length > 0) {
                                      return _loadedItems(
                                          snapshot, context, false);
                                    } else {
                                      return Container();
                                    }
                                    break;
                                  default:
                                    return Container();
                                }
                              },
                            ),
                          )
                        : Container(),
                    termosMaisBuscados.length > 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.06),
                            child: FutureBuilder<List<String>>(
                              future: _getTermosMaisBuscados(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  default:
                                    if (!snapshot.hasError &&
                                        snapshot.data != null) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            child: Text(
                                              'Itens mais procurados',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 10, top: 10),
                                          ),
                                          _loadedItems(snapshot, context, true),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                }
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom,
                  child: GestureDetector(
                    onTap: Navigator.of(context)
                        .pop, // Navegaria para a tela de scan
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.qr_code_scanner),
                              margin: EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                            ),
                            Text(
                              'Pesquise pelo código de barras',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _loadedItems(AsyncSnapshot snapshot, BuildContext context, bool divider) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: Navigator.of(context)
                  .pop, //levaria para alguma tela ou retornaria o valor
              child: Text(
                snapshot.data[index],
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.black, ),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
