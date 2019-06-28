// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

internal enum Localizable {
  /// Author: %@
  internal static func author(_ p1: String) -> String {
    return Localizable.tr("author", p1)
  }
  /// No Internet Connection
  internal static let noInternetConnection = Localizable.tr("no_internet_connection")
  /// N/A
  internal static let notAvailable = Localizable.tr("not_available")
  /// Number of comments: %d
  internal static func numberOfComments(_ p1: Int) -> String {
    return Localizable.tr("number_of_comments", p1)
  }
  /// Posts
  internal static let posts = Localizable.tr("posts")

  private static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, arguments: args)
  }
}
