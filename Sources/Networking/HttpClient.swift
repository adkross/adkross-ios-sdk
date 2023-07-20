//
//  HttpClient.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation
import Alamofire

typealias NetworkResult<T: Decodable> = (Result<T, String>) -> Void

protocol Networking {
    func request<EndPointItem: Endpoint, ResponseModel: Decodable, RequestModel: Encodable>(
        endpoint: EndPointItem,
        requestType: RequestModel.Type,
        responseType: ResponseModel.Type,
        completion: @escaping NetworkResult<ResponseModel>
    )
}

class HttpClient: Networking {
    private let session: Session
    private let apiKey: String
    private let appKey: String
    private let logger: Logging
    private let parser: Parsing
    private let encoder: JSONEncoder
    
    init(
        session: Session =  Alamofire.Session(),
        apiKey: String,
        appKey: String,
        logger: Logging,
        parser: Parsing,
        encoder: JSONEncoder
    ) {
        self.session = session
        self.apiKey = apiKey
        self.appKey = appKey
        self.logger = logger
        self.parser = parser
        self.encoder = encoder
    }
    
    public func request<EndPointItem, ResponseModel, RequestModel>(
        endpoint: EndPointItem,
        requestType: RequestModel.Type,
        responseType: ResponseModel.Type,
        completion: @escaping NetworkResult<ResponseModel>
    ) where ResponseModel: Decodable, RequestModel: Encodable, EndPointItem: Endpoint {
        encoder.dateEncodingStrategy = .iso8601
        
        let header = HTTPHeaders(
            HttpHeader.get(
                with: apiKey,
                appKey: appKey
            )
        )

        session.request(
            "\(endpoint.url)",
            method: .post,
            parameters: endpoint.request as? RequestModel,
            encoder: .json(encoder: encoder),
            headers: header)
        .validate()
        .responseData(completionHandler: { dataResponse in
            switch dataResponse.result {
            case .success(let data):
                self.parser.parseResponse(
                    data: data,
                    forType: ResponseModel.self
                ) { response in
                    completion(.success(response))
                }
            case .failure:
                guard let body = dataResponse.data else {
                    return
                }

                self.parser.parseResponse(
                    data: body,
                    forType: ErrorModel.self
                ) { parsedResponse in
                    completion(.failure(parsedResponse.message ?? "We cannot operate your request now. Please try again later!"))
                }
            }
        })
    }
}
