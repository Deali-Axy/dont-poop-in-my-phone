enum HistoryStatus {
  success,
  failed,
  pending, // For operations that might be queued or take time
  reverted, // If a revert operation was performed on this history item
} 