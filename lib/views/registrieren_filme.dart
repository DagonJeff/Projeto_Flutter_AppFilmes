import 'package:flutter/material.dart';
import 'package:myapp/db/filmedao.dart';
import 'package:myapp/model/filme.dart';
// import 'package:myapp/model/formatter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RegistrierenFilme extends StatefulWidget {
  const RegistrierenFilme({super.key});

  @override
  State<RegistrierenFilme> createState() => _RegistrierenFilmeState();
}

class _RegistrierenFilmeState extends State<RegistrierenFilme> {
  final _formSchlussel = GlobalKey<FormState>();
  final _titelController = TextEditingController();
  final _urlController = TextEditingController();
  final _genreController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();

  List<String> ageGroup = ['Livre', '10', '12', '14', '16', '18'];
  String? ageGroupSelect;
  double _rating = 0;
  bool _teufel = true;

  // @override
  // void initState() {
  //   super.initState();

  //   _urlController.text =
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSupYyssyBDcH8y5XAa7prCw4cAP4xx4g1vyA&s';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Filme"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.66),
        child: Form(
            key: _formSchlussel,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //----------URL--------------------------------------------
                TextFormField(
                  controller: _urlController,
                  onChanged: (value) {
                    setState(() {
                      final regex = RegExp(
                          r'https?://(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
                      _teufel =  regex.hasMatch(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Url Imagem",
                    errorText: _teufel ? null : 'URL inválida!',
                  ),
                ),
                //------Título-----------------------------------------------------
                TextFormField(
                  controller: _titelController,
                  decoration: const InputDecoration(
                    labelText: "Título",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o titulo do filme';
                    }
                    return null;
                  },
                ),
                //--------------Gênero---------------------------------------------------
                TextFormField(
                  controller: _genreController,
                  decoration: const InputDecoration(
                    labelText: "Gênero",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o genero do filme';
                    }
                    return null;
                  },
                ),
                //---------Faixa Etária------------------------------------------
                Row(
                  children: [
                    const Text('Faixa Etária:'),
                    const SizedBox(width: 9),
                    Expanded(
                      child: DropdownButton<String>(
                        value: ageGroupSelect,
                        onChanged: (String? newValue) {
                          setState(() {
                            ageGroupSelect = newValue;
                          });
                        },
                        items: ageGroup.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                //-----Duração---------------------------------------------------
                TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(labelText: "Duração"),
                    keyboardType: TextInputType.number,
                    // inputFormatters: [DurationFormatter()],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a duração do filme';
                      }
                      return null;
                    }),
                //-------Nota-------------------------------------------------
                Row(
                  children: [
                    const Text('Nota:'),
                    const SizedBox(width: 9),
                    Expanded(
                      child: RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    )
                  ],
                ),
                //-------Ano-------------------------------------------------
                Expanded(
                  child: TextFormField(
                      controller: _yearController,
                      decoration: const InputDecoration(
                        labelText: "Ano",
                        // border: UnderlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o ano do filme';
                        }
                        return null;
                      }),
                ),
                //-----Descrição---------------------------------------------------
                Expanded(
                    child: TextFormField(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1994077011.
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Descrição",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a descrição do filme';
                    }
                    return null;
                  },
                )),
              ],
            )),
      ),
      //------Botão Salvar--------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formSchlussel.currentState!.validate()) {
            // Criar o objeto Filme
            Filme filme = Filme(
              _urlController.text,
              _titelController.text,
              _genreController.text,
              ageGroupSelect ?? 'Livre',
              _durationController.text,
              _rating.toInt(),
              _descriptionController.text,
              int.tryParse(_yearController.text) ?? 0,
            );

            Filmedao.insert(filme).then((value) {
              if (value! > 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Filme cadastrado com sucesso!')),
                );
                _titelController.clear();
                _urlController.clear();
                _genreController.clear();
                _durationController.clear();
                _descriptionController.clear();
                _yearController.clear();
                setState(() {
                  ageGroupSelect = null;
                  _rating = 0;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Erro ao cadastrar filme!')),
                );
              }
              Navigator.pop(context, true);
            });
          }
          // Filmedao.insert(filme)
        },
        child: const Icon(
          Icons.save,
          // color: Color.fromARGB(255, 235, 187, 56),
        ),
      ),
    );
  }
}
