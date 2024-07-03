import XCTest
import NetworkClientInterface
@testable import NetworkClient

final class NetworkServiceTests: XCTestCase {
    
    let url = URL(string: "https://mempool.space/api/v1/lightning/nodes/rankings/connectivity")!
    
    func test_request_and_should_call_resume_dataTask_with_url() {
        
        let (sut, session) = makeSUT()
        let task = URLSessionStub.URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        
        sut.request(from: url) { _ in }
        
        XCTAssertEqual(session.receivedURLs, [url])
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    func test_request_result_error_for_all_invalid_cases() {
        let anyData = Data()
        let anyError = NSError(domain: "any error", code: 0)
        let anyHTTPURLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let anyURLResponse = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: anyURLResponse, error: nil))
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: anyHTTPURLResponse, error: nil))
        XCTAssertNotNil(resultErrorForInvalidCases(data: anyData, response: nil, error: nil))
        XCTAssertNotNil(resultErrorForInvalidCases(data: anyData, response: nil, error: anyError))
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: anyURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorForInvalidCases(data: anyData, response: anyURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorForInvalidCases(data: anyData, response: anyHTTPURLResponse, error: anyError))
        XCTAssertNotNil(resultErrorForInvalidCases(data: anyData, response: anyURLResponse, error: nil))
        XCTAssertNotNil(resultErrorForInvalidCases(data: nil, response: nil, error: anyError))
    }
    
    func test_request_result_success_for_valid_cases() {
        let anyData = Data()
        let anyHTTPURLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let result = resultSuccessForValidCases(data: anyData, response: anyHTTPURLResponse, error: nil)
        
        XCTAssertEqual(result?.data, anyData)
        XCTAssertEqual(result?.response, anyHTTPURLResponse)
        XCTAssertEqual(result?.response.statusCode , anyHTTPURLResponse.statusCode)
    }
}

extension NetworkServiceTests {
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: NetworkClient, session: URLSessionStub) {
        let session = URLSessionStub()
        let sut = NetworkService(session: session)
        return (sut, session)
    }
    
    private func resultErrorForInvalidCases(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Error? {
        
        let result = assert(data: data, response: response, error: error, file: file, line: line)
        
        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Espero falha, porem \(String(describing: result))", file: file, line: line)
        }
        
        return error
    }
    
    private func resultSuccessForValidCases(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line
    ) -> (data: Data, response: HTTPURLResponse)? {
        
        let result = assert(data: data, response: response, error: error, file: file, line: line)
        
        switch result {
        case let .success((data, response)):
            return (data, response)
        default:
            XCTFail("Espero sucesso, porem \(String(describing: result))", file: file, line: line)
        }
        
        return nil
    }
    
    private func assert(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line) -> NetworkClient.NetworkClientResult? {
            let (sut, session) = makeSUT(file: file, line: line)
            session.stub(url: url, data: data, response: response, error: error)
            
            let exp = expectation(description: "esperando bloco ser completado")
            
            var receivedResult: NetworkClient.NetworkClientResult?
            sut.request(from: url) { result in
                receivedResult = result
                exp.fulfill()
            }

            wait(for: [exp], timeout: 1.0)
            
            return receivedResult
    }
    
}
