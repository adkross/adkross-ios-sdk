//
//  HttpClient.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation
import Alamofire

typealias NetworkResult<T: Decodable> = (Result<T, Error>) -> Void

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
        logger.logWith(info: "Network call for url: \(endpoint.url)")
        
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
        .responseData(completionHandler: { responseData in
            if let error = responseData.error {
                self.logger.logWith(error: error.localizedDescription)
                
                DispatchQueue.main.async {
                    
                    completion(.failure(error))
                }
                return
            }
            
            guard responseData.data != nil else {
                self.logger.logWith(fault: "Response data is nil!")
                
                DispatchQueue.main.async {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                }
                return
            }
            
            self.parser.parseResponse(data: responseData.data!, forType: ResponseModel.self) { parsedResponse in
                self.logger.logWith(info: responseData.data!.prettyPrinted())
                
                if let error = parsedResponse.error {
                    completion(.failure(error))
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(parsedResponse.data!))
                }
                
                return
            }
        })
    }
}
