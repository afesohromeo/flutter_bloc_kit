enum GenericStatus { initial, loading, success, failure, filtering }

enum ActionStatus { initial, inProgress, success, failure }

enum ArticleFlowStep {
  none,
  loadingDetails,

  deletingItem,
  creatingItem,
  updatingItem,
  // itemCreated,
  // itemUpdated,
  // itemDeleted,
  error
}

enum OrderFlowStep {
  none,
  loadingDetails,

  deletingItem,
  creatingItem,
  updatingItem,
  // itemCreated,
  // itemUpdated,
  // itemDeleted,
  error
}
