enum GenericStatus { initial, loading, success, failure, filtering }

enum ActionStatus { initial, inProgress, success, failure }

enum GenericFlowStep {
  none,
  loadingDetails,
  deletingItem,
  creatingItem,
  updatingItem,
  error
}
