import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Order: SQLiteModel {
    var id: Int?

    var description: String

    init(id: Int? = nil, description: String) {
        self.id = id
        self.description = description
    }
}
extension Order: Migration { }
extension Order: Content { }
extension Order: Parameter { }
