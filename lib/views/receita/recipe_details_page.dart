import 'package:chefapp/controllers/notes_store.dart';
import 'package:chefapp/core/database/database_service.dart';
import 'package:chefapp/views/shared/cook_mode.dart';
import 'package:flutter/material.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:chefapp/views/receita/widget/recipe_header.dart';
import 'package:chefapp/views/receita/widget/recipe_info.dart';
import 'package:chefapp/views/receita/widget/recipe_stats.dart';
import 'package:chefapp/views/receita/widget/recipe_tabs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeDetailsPage extends StatefulWidget {

  final String mealId;

  const RecipeDetailsPage({
    super.key,
    required this.mealId,
  });

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {

  late Future<MealModel> mealFuture;

  final repository = MealRepositoryImpl(
    client: HttpClientImpl(),
  );

  final notesStore = NotesStore(
    databaseService: DatabaseService(),
  );

  final _databaseService = DatabaseService();

  late final TextEditingController _notesController;

  YoutubePlayerController? _videoController;
  bool _mostrarPlayer = false;

  @override
  void initState() {
    super.initState();
    mealFuture = repository.getMealById(widget.mealId);
    notesStore.load(widget.mealId);

    _notesController = TextEditingController();

    notesStore.nota.addListener(() {
      if (_notesController.text != notesStore.nota.value) {
        _notesController.text = notesStore.nota.value;
      }
    });
  }

  String? _extrairIdVideo(String? url) {
    if (url == null || url.isEmpty) return null;
    final uri = Uri.parse(url);
    return uri.queryParameters['v'];
  }

  void _abrirMiniPlayer(String videoId) {
    _videoController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
      ),
    );
    setState(() => _mostrarPlayer = true);
  }

  void _fecharMiniPlayer() {
    _videoController?.dispose();
    _videoController = null;
    setState(() => _mostrarPlayer = false);
  }

  @override
  void dispose() {
    _notesController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: FutureBuilder<MealModel>(
        future: mealFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar receita'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Receita não encontrada'));
          }

          final receita = snapshot.data!;
          final videoId = _extrairIdVideo(receita.urlVideo);

          return Stack(
            children: [

              SingleChildScrollView(
                child: Column(
                  children: [
                    RecipeHeader(
                      receita: receita,
                      onVerVideo: videoId != null
                          ? () => _abrirMiniPlayer(videoId)
                          : null,
                    ),
                    const TelasSempreLigadaWidget(),
                    RecipeInfo(receita: receita),
                    const RecipeStats(),
                    RecipeTabs(
                      receita: receita,
                      notesStore: notesStore,
                    ),

                    // campo de anotações
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            'Minhas anotações',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE8DDD4),
                              ),
                            ),
                            child: TextField(
                              controller: _notesController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(16),
                                hintText: 'Escreva aqui seus ajustes, dicas e observações...',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEC5C04),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () async {
                                final isFav = await _databaseService
                                    .isFavorite(widget.mealId);

                                if (!isFav) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Favorite a receita para adicionar anotações!',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                notesStore.salvarNota(
                                  widget.mealId,
                                  _notesController.text,
                                );

                                FocusScope.of(context).unfocus();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Anotação salva!'),
                                    backgroundColor: Color(0xFFEC5C04),
                                  ),
                                );
                              },
                              child: const Text(
                                'Salvar anotação',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // espaço para o mini player não cobrir o conteúdo
                          if (_mostrarPlayer)
                            const SizedBox(height: 220),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              if (_mostrarPlayer && _videoController != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _videoController!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: const Color(0xFFEC5C04),
                      progressColors: const ProgressBarColors(
                        playedColor: Color(0xFFEC5C04),
                        handleColor: Color(0xFFEC5C04),
                      ),
                    ),
                    builder: (context, player) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Assistindo receita',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: _fecharMiniPlayer,
                                  ),
                                ],
                              ),
                            ),

                            player,
                          ],
                        ),
                      );
                    },
                  ),
                  
                ),
            ],
          );
        },
      ),
    );
  }
}