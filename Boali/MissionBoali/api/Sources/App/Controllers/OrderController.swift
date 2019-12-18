import Vapor

final class OrderController {
    func index(_ req: Request) throws -> Future<[Order]> {
        return Order.query(on: req).all()
    }

    func create(_ req: Request) throws -> Future<Order> {
        return try req.content.decode(Order.self).flatMap { todo in
            return todo.save(on: req)
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Order.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}
