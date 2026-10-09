/// Status of one operation group in a BLoC state (see _standards/02).
enum GenericStatus {
  initial, // Before any action
  loading, // Full load (first page, no prior data)
  filtering, // Triggered by search/filter (data already showing)
  success, // Operation completed
  failure, // Operation failed
}

/// Which CRUD action a BLoC is running; drives dialog loading overlays.
enum GenericFlowStep { none, creatingItem, updatingItem, deletingItem }
