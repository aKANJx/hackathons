import Vapor

final class Worker: Model {
    
    var id: Node?
    var exists: Bool = false
    
    var fbID: String
    var name: String
    var email: String
    var role: String
    var about: String
    
    init(fbID: String, name: String, email: String, role: String, about: String) {
        self.id = nil
        self.fbID = fbID
        self.name = name
        self.email = email
        self.role = role
        self.about = about
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        fbID = try node.extract("fbID")
        name = try node.extract("name")
        email = try node.extract("email")
        role = try node.extract("role")
        about = try node.extract("about")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id":id,
            "fbID":fbID,
            "name":name,
            "email":email,
            "role":role,
            "about":about
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("workers") { workers in
            workers.string("fbID")
            workers.string("name")
            workers.string("email")
            workers.string("role")
            workers.string("about")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("workers")
    }
}
