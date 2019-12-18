import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
   
    router.get("reset") { req -> String in
        Order.query(on: req).delete()
        return "OK"
    }
    
    let orderController = OrderController()
    router.get("order", use: orderController.index)
    router.post("order", use: orderController.create)
    router.delete("order", use: orderController.delete)
    
}
