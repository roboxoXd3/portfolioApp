abstract class ProjectsEvent{}

class LoadProjectEvent extends ProjectsEvent{}

class FilterProjectEvents extends ProjectsEvent{
  final String technology;

  FilterProjectEvents(String s, {required this.technology});
  
}

class SelectProjectEvent extends ProjectsEvent{
  final String projectId;

  SelectProjectEvent({required this.projectId});
}

