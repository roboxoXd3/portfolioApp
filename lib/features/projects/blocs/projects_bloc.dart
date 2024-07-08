import 'package:bloc/bloc.dart';
import 'package:portfolio_app/features/projects/blocs/project_state.dart';
import 'package:portfolio_app/features/projects/blocs/projects_event.dart';

import '../models/projects.dart';

class ProjectsBloc extends Bloc<ProjectsEvent,ProjectState>{
  ProjectsBloc(): super(ProjectState()){
    on<LoadProjectEvent>(_onLoadProjects);
    on<SelectProjectEvent>(_onSelectProject);
    on<FilterProjectEvents>(_onFilterProjects);
  }

  void _onLoadProjects(LoadProjectEvent event, Emitter<ProjectState> emit) async{
    emit(state.copyWith(isLoading: true));
     // Simulate loading projects from an API
    await Future.delayed(const Duration(seconds: 1));

      final projects = [
      Project(
        id: '1',
        title: 'Portfolio App',
        description: 'A Flutter app showcasing my projects',
        technologies: ['Flutter', 'Dart', 'BLoC'],
        imageUrl: 'https://example.com/portfolio.jpg',
      ),
      Project(
        id: '2',
        title: 'Task Manager',
        description: 'A web app for managing daily tasks',
        technologies: ['React', 'Node.js', 'MongoDB'],
        imageUrl: 'https://example.com/taskmanager.jpg',
      ),
      // Add more projects as needed
    ];

    emit(state.copyWith(
      isLoading: false,
      projects: projects,
      filteredProjects: projects,
    ));
  } 

void _onFilterProjects(FilterProjectEvents event, Emitter<ProjectState> emit)  {
 final filteredProjects = event.technology.isEmpty
        ? state.projects
        : state.projects.where((project) => 
            project.technologies.contains(event.technology)
          ).toList();

    emit(state.copyWith(filteredProjects: filteredProjects));
}

 void _onSelectProject(SelectProjectEvent event, Emitter<ProjectState> emit) {
    emit(state.copyWith(selectedProjectId: event.projectId));
  }
}