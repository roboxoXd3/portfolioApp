// lib/features/projects/pages/projects_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/core_bloc.dart';
import '../blocs/project_state.dart';
import '../blocs/projects_bloc.dart';
import '../blocs/projects_event.dart';
import '../models/projects.dart';

// ignore: use_key_in_widget_constructors
class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsBloc()..add(LoadProjectEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Projects')),
        body: Column(
          children: [
            _buildFilterDropdown(),
            Expanded(child: _buildProjectsList()),
          ],
        ),
         floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.brightness_6),
        onPressed: () {
          context.read<CoreBloc>().add(ChangeThemeEvent());
        },
      ),
      ),
    );
    
  }


Widget _buildFilterDropdown() {
    return BlocBuilder<ProjectsBloc, ProjectState>(
      builder: (context, state) {
        final technologies = state.projects
            .expand((project) => project.technologies)
            .toSet()
            .toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: state.selectedTechnology.isEmpty ? null : state.selectedTechnology,
            hint: const Text('Filter by technology'),
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: '',
                child: Text('All Technologies'),
              ),
              ...technologies.map((tech) => DropdownMenuItem<String>(
                    value: tech,
                    child: Text(tech),
                  )),
            ],
            onChanged: (value) {
context.read<ProjectsBloc>().add(FilterProjectEvents(value.toString(), technology: value.toString())); },
          ),
        );
      },
    );
  }

Widget _buildProjectsList() {
    return BlocBuilder<ProjectsBloc, ProjectState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text('Error: ${state.error}'));
        }
        if (state.filteredProjects.isEmpty) {
          return const Center(child: Text('No projects found.'));
        }
        return ListView.builder(
          itemCount: state.filteredProjects.length,
          itemBuilder: (context, index) {
            final project = state.filteredProjects[index];
            return ProjectCard(project: project);
          },
        );
      },
    );
  }
}

// FilterProjectEvents(value ?? '', technology: '')
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(project.title),
        subtitle: Text(project.description),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          context.read<ProjectsBloc>().add(SelectProjectEvent(projectId: project.id));
          // TODO: Navigate to project details page
        },
      ),
    );
  }
}