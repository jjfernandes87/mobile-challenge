import Foundation

final class URLSessionStub: URLSession {
    
    class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }

    class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        override func resume() {
            resumeCallCount += 1
        }
    }
    
    private(set) var receivedURLs = [URL]()
    private var stubs = [URL: Stub]()
    
    struct Stub {
        let task: URLSessionDataTask
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    func stub(
        url: URL,
        task: URLSessionDataTask = FakeURLSessionDataTask(),
        data: Data? = nil,
        response: URLResponse? = nil,
        error: Error? = nil
    ) {
        stubs[url] = Stub(task: task, data: data, response: response, error: error)
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        receivedURLs.append(url)
        guard let stub = stubs[url] else {
            return FakeURLSessionDataTask()
        }
        completionHandler(stub.data, stub.response, stub.error)
        return stub.task
    }
    
}
