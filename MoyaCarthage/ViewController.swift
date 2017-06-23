import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin()])

        provider.request(.post(number: 1, text: "test")) { result in
            switch result {
            case let .success(response):
                let data = response.data
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

enum Api {
    case get
    case post(number: Int, text: String)
}

extension Api: TargetType {
    var baseURL: URL { return URL(string: "https://httpbin.org")! }
    var path: String {
        switch self {
        case .get:
            return "/get"
        case .post:
            return "/post"
        }
    }

    var method: Moya.Method {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .get:
            return nil
        case .post(let number, let text):
            return ["first": number, "second": text]
        }
    }
    var parameterEncoding: ParameterEncoding { return URLEncoding.queryString }
    var sampleData: Data { return Data() }
    var task: Task { return .request }
}
