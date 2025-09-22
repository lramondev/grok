import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grok/presentation/blocs/auth/auth_bloc.dart';
import 'package:grok/presentation/blocs/auth/auth_state.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Card(
                    child: Text('card'),
                  )
                ],
              )
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


/* 
Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (state.user.avatar_url != null && state.user.avatar_url!.isNotEmpty)
                    ClipOval(
                      child: Image.network(
                        state.user.avatar_url!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
                  Text('Name: ${state.user.name}'),
                  Text('Email: ${state.user.email}'),
                  SizedBox(height: 16),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) {
                      return Column(

                      children: [
                        Text('Select Mode:', style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(ThemeMode.system, themeState.themeName));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeMode == ThemeMode.system ? Colors.blueGrey : null,
                              ),
                              child: Text('System'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(ThemeMode.light, themeState.themeName));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeMode == ThemeMode.light ? Colors.blueGrey : null,
                              ),
                              child: Text('Light'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(ThemeMode.dark, themeState.themeName));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeMode == ThemeMode.dark ? Colors.blueGrey : null,
                              ),
                              child: Text('Dark'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text('Select Theme:', style: Theme.of(context).textTheme.titleMedium),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(themeState.themeMode, 'default'));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeName == 'default' ? Colors.blue : null,
                              ),
                              child: Text('Default'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(themeState.themeMode, 'green'));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeName == 'green' ? Colors.green : null,
                              ),
                              child: Text('Green'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(themeState.themeMode, 'purple'));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeName == 'purple' ? Colors.purple : null,
                              ),
                              child: Text('Purple'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(ToggleTheme(themeState.themeMode, 'orange'));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeState.themeName == 'orange' ? Colors.orange : null,
                              ),
                              child: Text('Orange'),
                            ),
                          ],
                        ),
                      ],
                    );
                    },
                  ),
                ],
              ),
*/