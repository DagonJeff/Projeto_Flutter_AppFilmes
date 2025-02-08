class Filme {
  int id;
  String url;
  String title;
  String genre;
  String ageGroup;
  String duration;
  int score;
  String description;
  int year;

  Filme(this.url, this.title, this.genre, this.ageGroup, this.duration,
      this.score, this.description, this.year,
      {this.id = 0});

  Map<String, Object?> toMap() {
    return {
      'url': url,
      'title': title,
      'genre': genre,
      'ageGroup': ageGroup,
      'duration': duration,
      'score': score,
      'description': description,
      'year': year
    };
  }

  factory Filme.fromMap(Map<String, Object?> map) {
    return Filme(
        map['url'] as String,
        map['title'] as String,
        map['genre'] as String,
        map['ageGroup'] as String,
        map['duration'] as String,
        map['score'] as int,
        map['description'] as String,
        map['year'] as int,
        id: map['id'] as int);
  }

  @override
  String toString() {
    return "$title: Título, $year: Ano";
  }
}

// class Contato {
//   int id;
//   String nome;
//   String email;
//   String telefone;

  //Contato(this.nome, this.email, this.telefone, {this.id = 0});

  // Map<String, Object?> toMap() {
  //   return {'nome': nome, 'email': email, 'telefone': telefone};
  // }

  // factory Contato.fromMap(Map<String, Object?> map) {
  //   return Contato(map['nome'] as String, map['email'] as String,
  //       map['telefone'] as String,
  //       id: map['id'] as int);
  // }

  // @override
  // String toString() {
  //   return "$nome: nome, $email: email";
  // }
