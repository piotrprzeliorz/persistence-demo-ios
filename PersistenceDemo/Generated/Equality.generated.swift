// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


  // MARK: Author Equatable
  extension Author: Equatable {
      static func ==(lhs: Author, rhs: Author) -> Bool {
          guard lhs.id == rhs.id else { return false }
          guard lhs.name == rhs.name else { return false }
          guard lhs.username == rhs.username else { return false }
          return true
      }
  }
  // MARK: PersistenceDemoError Equatable
  extension PersistenceDemoError: Equatable {
      static func ==(lhs: PersistenceDemoError, rhs: PersistenceDemoError) -> Bool {
          return true
      }
  }
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
  