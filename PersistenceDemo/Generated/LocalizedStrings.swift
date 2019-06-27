// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

internal enum Localizable {
  /// No Internet Connection
  internal static let noInternetConnection = Localizable.tr("no_internet_connection")
  /// N/A
  internal static let notAvailable = Localizable.tr("not_available")
  /// Posts
  internal static let posts = Localizable.tr("posts")

  private static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, arguments: args)
  }
}
