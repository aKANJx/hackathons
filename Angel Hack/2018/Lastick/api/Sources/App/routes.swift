import Vapor

public func routes(_ router: Router) throws {

    let eventController = EventController()
    router.get("events", use: eventController.index)
    router.post("events", use: eventController.create)
    router.delete("events", Event.parameter, use: eventController.delete)
}
