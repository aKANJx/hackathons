import Vapor

final class EventController {

    func index(_ req: Request) throws -> Future<[Event]> {
        print(req.parameters.values)
        return Event.query(on: req).all()
    }

    func create(_ req: Request) throws -> Future<Event> {
        return try req.content.decode(Event.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Event.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}
