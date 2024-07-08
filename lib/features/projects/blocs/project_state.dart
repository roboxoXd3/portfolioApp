import 'package:portfolio_app/features/projects/models/projects.dart';

class ProjectState {
  final List<Project> projects;
  final List<Project> filteredProjects;
  final String? selectedProjectId;
   final String selectedTechnology;
  final bool isLoading;
  final String? error;

  ProjectState({
    this.projects = const [],
    this.filteredProjects = const[],
    this.selectedProjectId,
    this.selectedTechnology = '',
    this.isLoading = false,
    this.error,
  });

  ProjectState copyWith({
     List<Project>? projects,
    List<Project>? filteredProjects,
    String? selectedProjectId,
    bool? isLoading,
     String? selectedTechnology,
    String? error,
  }){
 return ProjectState(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      selectedProjectId: selectedProjectId ?? this.selectedProjectId,
      selectedTechnology: selectedTechnology ?? this.selectedTechnology,
      isLoading: isLoading ?? this.isLoading,
      error: error ,
    );
  }
}
