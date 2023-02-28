/// The possible permission levels necessary to access any given resource.
enum PermissionLevel {
  /// Anyone can access this resource.
  all,

  /// Only logged users may access this resource.
  userOnly,

  /// Only administrators may access this resource.
  adminOnly,

  /// No one may access this resource.
  none,
}
