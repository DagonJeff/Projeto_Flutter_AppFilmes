import 'package:myapp/db/verbidung.dart';
import 'package:myapp/model/filme.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filmedao {
  //----Lista de filmes iniciais-------------------------------------------
  static List<Filme> _beginMovies() {
    print('beginMovies');
    return [
      Filme(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSupYyssyBDcH8y5XAa7prCw4cAP4xx4g1vyA&s',
          'O Poderoso Chefão',
          'Crime, Policial Drama',
          '14',
          '2h 55min',
          5,
          'Baseando-se na novela "best-seller” de Mario Puzo "The Godfather", Francis Ford Coppola fez uma das mais brutais e movimentadas crônicas da vida americana até agora apresentadas dentro do limite de um entretenimento popular. Ö Poderoso Chefão “, todo fotografado em Nova York (com algumas cenas em Las Vegas, Sicília e Hollywood), É o melodrama de gangsters do passados, mostrando o inferior que existe em nós, onde o crime não deve ser, mostrar que o castigo sofrido pelos membros da família Corlone não são limitados por súbitas emboscadas nas esquinas das ruas ou pelos mais elaborados assassinatos. Ele também inclui as perpétuas sentenças do ostracismo, o burguês confinamento do dinheiro, o poder maso não com muito mais glória do que pode ser obtido pela habilidade “. O PODEROSO CHEFÃO “joga com as emoções das coisas doces da vida - casamento, batizado, festas familiares - que tornam-se uma inexpugnável pano de fundo para terríveis assassinatos a tiros de revólver, metralhadoras, garrotes e atropelamento. O filme é sobre um imperial palácio. Tudo onde várias pessoas ceiam enquanto crianças choram e gritam, Isto é muito mais do que um pequeno distúrbio, ao mostrar que os personagens que estavam tão vivos a poucos minutos, vão na outra cena ter seus miolos estourados sobre a branca mesa. Não é nada pessoal, é apenas o corriqueiro modo que tinham para negociarem.',
          1972),
      Filme(
          'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/16/32/19872655.jpg',
          'Pulp Fiction - Tempo de Violência',
          'Policial, Drama',
          '18',
          '2h 29min',
          5,
          'Vincent Vega (John Travolta) e Jules Winnfield (Samuel L. Jackson) são dois assassinos profissionais trabalham fazendo cobranças para Marsellus Wallace (Ving Rhames), um poderosos gângster. Vega é forçado a sair com a garota do chefe, temendo passar dos limites; enquanto isso, o pugilista Butch Coolidge (Bruce Willis) se mete em apuros por ganhar luta que deveria perder.',
          1994),
      Filme(
          'https://br.web.img2.acsta.net/c_310_420/pictures/22/10/20/16/25/1413867.jpg',
          'Nada de Novo no Front',
          'Guerra, Drama, Histórico',
          '16',
          '2h 28min',
          5,
          'Em uma adaptação do romance homônimo de Erich Maria Remarque, Nada de Novo no Front é uma história que segue o adolescente Paul Baumer e seus amigos Albert e Muller, que se alistam voluntariamente no exército alemão, movidos por uma onda de fervor patriótico. Mas isso é rapidamente dissipado quando enfrentam a realidade brutal da vida no front. Os preconceitos de Paul sobre o inimigo e os acertos e erros do conflito logo os desequilibram. No entanto, em meio à contagem regressiva, Paul deve continuar lutando até o fim, com nenhum objetivo além de satisfazer o desejo do alto escalão de acabar com a guerra com uma ofensiva alemã.',
          2022),
      Filme(
          'https://br.web.img3.acsta.net/c_310_420/pictures/15/03/09/21/23/308238.jpg',
          'Hellraiser - Renascido do Inferno',
          'Terror',
          '18',
          '1h 34min',
          5,
          'Frank Cotton (Sean Chapman) é um conhecedor da depravação sexual, que busca a mais nova experiência sensual e compra um belo e intrincado cubo de quebra-cabeças. Só que Frank tem uma experiência atra com o cubo ao resolver o enigma e abrir as portas do Inferno e do Céu, o que provoca sua morte. Após vários anos seu irmão Larry (Andrew Robinson), que ignora o que aconteceu com Frank, decide voltar para a casa da família, que estava fechada há dez anos. Larry se muda juntamente com sua segunda esposa, Julia (Clare Higgins), mas sua filha, Kirsty (Ashley Laurence), optou por morar sozinha. Um acidente faz o sangue de Larry cair no chão do sótão, fazendo com que ocorra a ressurreição de Frank. Porém o corpo dele está só meio composto, assim ele procura a ajuda de Julia, com quem tivera um tórrido envolvimento, para ter novamente a forma humana. Ainda secretamente apaixonada por Frank, Julia o ajuda seduzindo homens da cidade e levando-os até a casa, pois assim seu renascido amante pode beber o sangue deles para recuperar seu aspecto humano. Tentando melhorar sua relação com Julia, Kirsty, que nunca se sentiu a vontade com a madrasta, vai até a casa para conversar com ela. Quando está chegando vê Julia com um desconhecido, que na verdade é a próxima vítima e não o que Kirsty pensa. Ao entrar na casa, Kirsty fica diante do estranho que está coberto de sangue, e pede por socorro. Aterrorizada, ela se depara com o ainda incompleto Frank, que se identifica e tenta dominá-la. Apavorada, Kirsty pega por acaso o cubo e sente que ele é importante para Frank, então o atira pela janela, o que deixa Frank em pânico. Ao fugir, ela resgata o cubo e anda pelas ruas desnorteada, pois está dominada por um medo que nunca sentiu.',
          1987)
    ];
  }

//------Método que reinicia o Banco de dados---------------------------------------
  static Future<void> Satanas() async {
    try {
      var dbpath = await getDatabasesPath();
      String path = join(dbpath, 'filmesdb.db');
      await deleteDatabase(path);

      final teufel = await SharedPreferences.getInstance();
      await teufel.setBool('initialisiert', false);

      print('Deletado com sucesso!');
    } catch (ex) {
      print('Erro ao deletar banco de dados: $ex');
    }
  }

//--------------Inicia a tabela com a lista de filmes iniciais--------------------
  static Future<void> beginDatabase() async {
    print("beginDatabase");

    final satan = await SharedPreferences.getInstance();

    final initialisiert = satan.getBool('initialisiert') ?? false;

    if (!initialisiert) {
      print('inicialisiert');
      try {
        Database db = await Verbidung.getConnection();
        List<Map<String, Object?>> listMap = await db.query('filmes');

        print('entrei no try de begindatabase');

        if (listMap.isEmpty) {
          print('Entrei no if');
          for (var movie in _beginMovies()) {
            await db.insert('filmes', movie.toMap());
          }
        }
        await satan.setBool('initialisiert', true);
      } catch (ex) {
        print('Erro ao inicilaizar banco de dados: $ex');
      }
    }
  }

  //------------Inserir
  static Future<int?> insert(Filme filme) async {
    try {
      Database db = await Verbidung.getConnection();
      return await db.insert('filmes', filme.toMap());
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  //----------------Buscar Todos
  static Future<List<Filme>?> suchenAlle() async {
    print('suchenAlle');
    try {
      Database db = await Verbidung.getConnection();

      List<Map<String, Object?>> listMap = await db.query('filmes');
      List<Filme> filmes = [];

      for (Map<String, Object?> map in listMap) {
        filmes.add(Filme.fromMap(map));
      }
      print(listMap.length);
      print(filmes);
      return filmes;
    } catch (ex) {
      print("Erro ao executar o método suchenAlle: $ex");
      return null;
    }
  }

//------------------Atualizar
  static Future<int?> update(int id, Filme filme) async {
    try {
      Database db = await Verbidung.getConnection();
      return await db
          .update('filmes', filme.toMap(), where: 'id = ?', whereArgs: [id]);
      // print('atualizei');
      // print(Filmedao.suchenAlle());
    } catch (ex) {
      return null;
    }
  }

//-------------------Excluir
  static Future<int?> delete(int id) async {
    try {
      print('deletando');
      Database db = await Verbidung.getConnection();
      return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
    } catch (ex) {
      return null;
    }
  }
}
