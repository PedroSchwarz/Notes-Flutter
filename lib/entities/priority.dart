enum Priority { Low, Medium, High }

class Priorities {
  static String enumToString(Priority priority) {
    switch (priority) {
      case Priority.Low:
        return 'Low';
      case Priority.Medium:
        return 'Medium';
      case Priority.High:
        return 'High';
      default:
        return 'Low';
    }
  }

  static Priority stringToEnum(String value) {
    switch (value) {
      case 'Low':
        return Priority.Low;
      case 'Medium':
        return Priority.Medium;
      case 'High':
        return Priority.High;
      default:
        return Priority.Low;
    }
  }
}
