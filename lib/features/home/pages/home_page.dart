import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHomeDataEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Rishav').animate().fadeIn(duration: 600.ms),
                actions: [
                  TextButton(onPressed: () {}, child: const Text('About', style: TextStyle(color: Colors.white))),
                  TextButton(onPressed: () {}, child: const Text('Skills', style: TextStyle(color: Colors.white))),
                  TextButton(onPressed: () {}, child: const Text('Projects', style: TextStyle(color: Colors.white))),
                  TextButton(onPressed: () {}, child: const Text('Contact', style: TextStyle(color: Colors.white))),
                  IconButton(
                    icon: Icon(state.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
                    onPressed: () => context.read<HomeBloc>().add(ToggleThemeEvent()),
                  ),
                ].animate(interval: 100.ms).fadeIn(duration: 300.ms).slideX(begin: 30, end: 0),
              ),
              body: _buildBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state.isLoading) {
      return Center(child: const CircularProgressIndicator().animate().scale());
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            const SizedBox(height: 32),
            _buildAboutSection(),
            const SizedBox(height: 32),
            _buildSkillsSection(state.skills),
            const SizedBox(height: 32),
            _buildProjectsSection(state.projects),
            const SizedBox(height: 32),
            _buildContactSection(),
          ].animate(interval: 200.ms).fadeIn(duration: 500.ms).slideY(begin: 30, end: 0),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_photo.jpg'),
            ).animate().scale(delay: 300.ms, duration: 600.ms),
            const SizedBox(height: 16),
            const Text(
              'Rishav',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
            Text(
              'Flutter Developer',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About Me', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text(
          'I am a passionate Flutter developer with a keen interest in creating beautiful and functional mobile applications. With a strong foundation in Dart and a eye for design, I strive to deliver high-quality, user-friendly solutions.',
          style: TextStyle(fontSize: 16),
        ),
      ].animate(interval: 100.ms).fadeIn(duration: 500.ms).slideX(begin: -30, end: 0),
    );
  }

Widget _buildSkillsSection(List<String> skills) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Skills', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: skills.asMap().entries.map((entry) {
          int index = entry.key;
          String skill = entry.value;
          return Chip(label: Text(skill)).animate()
            .fadeIn(duration: 300.ms, delay: (index * 50).ms)
            .scaleXY(begin: 0.8, end: 1, duration: 300.ms, delay: (index * 50).ms);
        }).toList(),
      ),
    ],
  );
}


  Widget _buildProjectsSection(List<String> projects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Projects', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(projects[index]),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Navigate to project details
                },
              ),
            ).animate(delay: Duration(milliseconds: 100 * index)).fadeIn(duration: 500.ms).slideX(begin: 30, end: 0);
          },
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Contact', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          icon: const Icon(Icons.email),
          label: const Text('Get in Touch'),
          onPressed: () {
            // Open contact form or email client
          },
        ).animate().scale(delay: 300.ms, duration: 300.ms),
      ],
    );
  }
}