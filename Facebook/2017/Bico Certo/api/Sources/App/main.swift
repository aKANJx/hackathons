import Vapor
import VaporPostgreSQL

let drop = Droplet()
drop.preparations.append(Worker.self)

do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    assertionFailure("Error adding provider: \(error)")
}

drop.get("") { request in
    return try drop.view.make("welcome")
}

drop.get("version") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    }
    else {
        return "No db connection"
    }
    
}

drop.post("cadastro") { request in
//    var worker = Worker(fbID: "1", name: "Jean", email: "jpsmarinho@me.com", role: "iOS Engineer", about: "I'm a developer")
    var worker = try Worker(node: request.json)
    try worker.save()
    return try worker.makeJSON()
}

drop.get("todos") { request in
    return try JSON(node: Worker.all().makeNode())
}

drop.get("worker") { request in
    var worker = Worker(fbID: "1", name: "Jean", email: "jpsmarinho@me.com", role: "iOS Engineer", about: "I'm a developer")
    try worker.save()
    return try JSON(node: Worker.all().makeNode())
}

drop.run()
