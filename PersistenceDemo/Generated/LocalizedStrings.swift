// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

internal enum Localizable {
  /// Posts
  internal static let posts = Localizable.tr("posts")

  private static func tr(_ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, arguments: args)
  }
}
