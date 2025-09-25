import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:grok/core/config/environment_config.dart';

import 'package:grok/presentation/blocs/auth/auth_bloc.dart';
import 'package:grok/presentation/blocs/auth/auth_event.dart';
import 'package:grok/presentation/blocs/auth/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cacheManager = CacheManager(
      Config(
        'customCacheKey',
        stalePeriod: Duration(days: 365),
        maxNrOfCacheObjects: 100,
      ),
    );

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      builder: (context, state) {
        if (state is AuthUnauthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else if(state is AuthAuthenticated) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              title: Image.asset('assets/img/transoeste-sm.png', width: 180),
              backgroundColor: Colors.transparent,
              elevation: 1,
              iconTheme: IconThemeData(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
              ),
              leading: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () => {},
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      context.read<AuthBloc>().add(AuthLogout());
                    },
                  )
                )
              ]
            ),
            drawer: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(36),
                                child: CachedNetworkImage(
                                  imageUrl: EnvironmentConfig.instance.baseUrl + (state.user.registro.funcionario.foto_url ?? ''),
                                  cacheManager: cacheManager,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  width: 72,
                                  height: 72
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.user.registro.funcionario.nome_razao_social, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                                Text(state.user.registro.registro_cargo.cargo.descricao, style: const TextStyle(fontSize: 12))
                              ],
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 194,
                    child: GridView.count(
                      childAspectRatio: 1.0,
                      padding: const EdgeInsets.all(12),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/holerite'),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.monetization_on_outlined, size: 36),
                                SizedBox(height: 8),
                                Text('Holerite', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),

                        /*
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, '/ponto'),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            ),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.access_time, size: 36),
                                  SizedBox(height: 8),
                                  Text('Ponto', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                        ),
                        */
                        /*
                        InkWell(
                          onTap: () => {},//Navigator.pushNamed(context, '/imposto_renda'),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Opacity(
                            opacity: .6,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.percent, size: 36),
                                    SizedBox(height: 8),
                                    Text('Imposto de Renda', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        */
                        /*
                        InkWell(
                          onTap: () => {},//Navigator.pushNamed(context, '/ferias'),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Opacity(
                            opacity: .6,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(Icons.sunny_snowing, size: 36),
                                    SizedBox(height: 8),
                                    Text('Férias', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        */
                      ]
                    ),
                  ),
                )
              ],
            )
          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
