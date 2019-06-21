// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


  // MARK: Post Equatable
  extension Post: Equatable {
      static func ==(lhs: Post, rhs: Post) -> Bool {
          guard lhs.userId == rhs.userId else { return false }
          guard lhs.id == rhs.id else { return false }
          guard lhs.title == rhs.title else { return false }
          guard lhs.body == rhs.body else { return false }
          return true
      }
  }
  