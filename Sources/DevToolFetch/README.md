# FetchSwift


### Usage

```swift
final class JsonPlaceholderAPI: Fetch {
    /// ref: https://jsonplaceholder.typicode.com/
    var domain: String = "https://jsonplaceholder.typicode.com/"

    var decoder = JSONDecoder()

    var encoder = JSONEncoder()

    static var shared: JsonPlaceholderAPI = JsonPlaceholderAPI()

    func willSend(params: [String: Any], method: HttpMethod, path: String) -> Params {
        params
    }

    func willSend(request: URLRequest, method: HttpMethod, path: String, params: [String: Any]) -> URLRequest {
        request
    }

    func show(progress: Float?) {}

    func hide(progress: Float?) {}
}

extension JsonPlaceholderAPI {
    struct Todo: Codable {
        var id: Int?
        var userId: Int?
        var title: String?
        var completed: Bool?
    }

    func todos() -> Response<[Todo]> {
        self.fetch(path: "todos")
            .fromObject(mapPath: "data")
    }

    func todosAsync() async throws -> [Todo] {
        try await self.fetchAsync(path: "todos", designatedPath: "data")
    }
}
```
