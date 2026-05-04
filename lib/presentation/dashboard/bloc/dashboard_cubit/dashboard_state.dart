class DashboardState {
  const DashboardState({
    required this.predictionResult,
    required this.total,
    this.isLoading = false,
    this.error,
  });
  final bool isLoading;
  final double total;
  final double predictionResult;
  final String? error;

  DashboardState copyWith({
    bool? isLoading,
    double? total,
    double? predictionResult,
    String? error,
  }) {
    return DashboardState(
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      predictionResult: predictionResult ?? this.predictionResult,
      error: error,
    );
  }
}
