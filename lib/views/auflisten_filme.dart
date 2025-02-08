import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/db/filmedao.dart';
import 'package:myapp/model/filme.dart';
import 'package:myapp/views/andern_filme.dart';
import 'package:myapp/views/registrieren_filme.dart';
import 'package:myapp/views/zeigInfo.dart';

class AuflistenFilme extends StatefulWidget {
  const AuflistenFilme({super.key});

  @override
  State<AuflistenFilme> createState() => _AuflistenFilmeState();
}

class _AuflistenFilmeState extends State<AuflistenFilme> {
  List<Filme> _movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initDatabase().then((_) => _ladenmovies());
  }

  Future<void> _initDatabase() async {
    print('initDatabase');

    // await Filmedao.Satanas();
    await Filmedao.beginDatabase();
  }

//-------------Carregar filmes------------------------------
  Future<void> _ladenmovies() async {
    print('ladenmovies');
    try {
      final moviesLocal = await Filmedao.suchenAlle();
      setState(() {
        print('moviesLocal: $moviesLocal');
        _movies = moviesLocal ?? [];
        print('ladenmovies: $_movies');
      });
    } catch (e) {
      print('Erro ao buscar filmes do SQLite: $e');
    }
  }

//--------------excluir filme---------------------------
  Future<void> _loschenFilme(Filme filme) async {
    try {
      await Filmedao.delete(filme.id);
      setState(() {
        _movies.remove(filme);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Filme "${filme.title}" excluído!')),
      );
    } catch (e) {
      print('Erro ao excluir filme: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir filme!')),
      );
    }
  }

  //------------Callback-----------------------------
  void aktualisierenFilme(Filme filmeAktuel) {
    setState(() {
      int index = _movies.indexWhere((filme) => filme.id == filmeAktuel.id);
      if (index != -1) {
        _movies[index] = filmeAktuel;
      }
    });
  }

//----------Botão de alerta com o nome do grupo---------------------
  void _zeigenGrupen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Equipe:'),
          backgroundColor: const Color.fromARGB(255, 235, 187, 56),
          content: const Text('Jefferson Rodrigues\nJúlio César\nBruno Marion'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 193, 52, 42),
              ),

              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // GestureD
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filmes"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _zeigenGrupen(context);
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: FutureBuilder<List<Filme>?>(
          future: Filmedao.suchenAlle(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              // Verifica se há dados e se não são nulos
              _movies = snapshot.data!;
              return ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  print('Satanás:');
                  print(_movies[index]);
                  final filme = _movies[index];

                  return Dismissible(
                    key: Key(filme.title),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _loschenFilme(filme);
                    },
                    child: ListTile(
                      title: IntrinsicHeight(
                        // Envolve o Row com IntrinsicHeight
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              filme.url,
                              fit: BoxFit.cover,
                              width: 99,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              // Ocupa o espaço restante com os dados do filme
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filme.title,
                                    style: const TextStyle(
                                      // fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(filme.genre),
                                  Text(filme.year.toString()),
                                  Text(filme.duration),
                                  const Spacer(),
                                  RatingBarIndicator(
                                    rating: filme.score.toDouble(),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.zero),
                          ),
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 120,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: const Center(
                                      child: Text('Exibir Dados'),
                                    ),
                                    onTap: () {
                                      // print(filme);
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ZeigInfo(filme: filme)),
                                      );
                                    },
                                  ),
                                  ListTile(
                                    title: const Center(
                                      child: Text('Alterar'),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AndernFilme(
                                                  filme: filme,
                                                  aktualisierenFilmeCallback:
                                                      aktualisierenFilme,
                                                )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Erro: ${snapshot.error}"),
              );
            } else {
              return const Center(
                child:
                    // Text('Satanás'),
                    CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrierenFilme()),
          ).then((value) {
            if (value == true) {
              _ladenmovies();
            }
          });
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 235, 187, 56),
        ),
        // backgroundColor: Color.fromARGB(255, 193, 52, 42),
      ),
    );
  }
}
