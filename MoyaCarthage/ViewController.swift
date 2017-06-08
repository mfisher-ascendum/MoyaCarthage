import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin()])

        provider.request(.get) { result in
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
}

extension Api: TargetType {
    var baseURL: URL { return URL(string: "https://httpbin.org")! }
    var path: String {
        return "/get"
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? { return nil }
    var parameterEncoding: ParameterEncoding { return URLEncoding.default }
    var sampleData: Data { return Data() }
    var task: Task { return .request }
}
