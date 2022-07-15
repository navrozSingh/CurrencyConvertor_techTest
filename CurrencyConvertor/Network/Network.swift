//
//  Network.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import Foundation
import Apollo

class Network: NetworkAdaptor {
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {
        
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let provider = NetworkInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true, store: store)
        
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: baseUrl)
        
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }()
}
class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor, NetworkAdaptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "Authorization", value: headers["Authorization", default: ""])
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}

protocol NetworkAdaptor {
    
    var baseUrl: URL { get  }
    var headers: [String: String] { get }
}

extension NetworkAdaptor {
    var baseUrl: URL {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "swop.cx"
            components.path = "/graphql"
            guard let url = components.url else {
                preconditionFailure("Wrong base URL")
            }
            return url
        }
    }
    
    var headers: [String: String] {
        get {
            ["Authorization": "ApiKey 4567e8ba800c2e74dcf7f1a3f9a87ac7457499eeb91d4d85b14e5c407be3cc57"]
        }
    }
}
