import Vapor
import Cache


extension Droplet {
    func setupRoutes() throws {
        get("token") { req in
            guard let id = req.query?["id"]?.int else {
                return Response(status: .badRequest)
            }
            
            var json = JSON()
            
            guard let token = try self.cache.get("\(id)") else {
                return Response(status: .noContent)
            }
            
            try json.set("id", id)
            try json.set("token", token)
            
            return json
        }
        
        post("register-token") { req in
            guard let id = req.json?["id"]?.int, let token = req.json?["token"]?.string else {
                return Response(status: .badRequest)
            }
            
            try self.cache.set("\(id)", token, expiration: Date(timeIntervalSinceNow: Constants.tokenDuration))
            
            return Response(status: .ok)
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let tokenDuration: Double = 5 * 60 // seconds
}
