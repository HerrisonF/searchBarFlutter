import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  final List<String> listExample;

  List<String> termosMaisBuscados = [
    'óleo',
    'arroz',
    'hamburguer',
    'cerveja',
    'óleo',
    'teste',
    'teste2'
  ];

  Search(this.listExample);

  @override
  String get searchFieldLabel => 'Pesquise o item que deseja';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      TextButton(
        child: Text(
          'Cancelar',
          style: TextStyle(color: Colors.grey),
        ),
        onPressed: Navigator.of(context).pop,
      ),
      IconButton(
          icon: Icon(
            Icons.settings_voice,
            color: Colors.black,
          ),
          onPressed: () {
            //Faz algo muito especial xD
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.red,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  @override
  void showResults(BuildContext context){
    close(context, query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty
        ? suggestionList = termosMaisBuscados
        : suggestionList.addAll(
            listExample.where(
              (item) => item.toLowerCase().contains(query.toLowerCase()),
            ),
          );

    return Stack(
      children: [
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom,
          child: GestureDetector(
            onTap: Navigator.of(context).pop, // Navegaria para a tela de scan
            child: Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              // decoration:
              //BoxDecoration(border: Border.all(color: Colors.grey)),
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
              )
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: query.isEmpty && query != null
                  ? Text(
                      'Termos mais buscados',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    )
                  : Text(
                      'Sugestões',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 35),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestionList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.access_time_rounded),
                            title: Text(
                              suggestionList[index],
                            ),
                            onTap: () {
                              close(context, suggestionList[index]);
                            },
                          ),
                          Divider(),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
