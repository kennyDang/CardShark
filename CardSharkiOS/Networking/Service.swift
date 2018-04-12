//
//  Service.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

protocol ServiceAPI {
    var path: String { get }
    var headers: [String: Any] { get }
    var baseURL: URL? { get }
    var method: HTTPMethod { get }
    var parameters: [URLQueryItem]? { get }
}

enum HTTPMethod: String {
    case get = "GET"
}

enum Service {
    case getDeckOfCardsID
    case shuffleDeckOfCards(withID: String)
    case getDeckOfCards(withID: String)
}

extension Service: ServiceAPI {
    var path: String {
        switch self {
        case .getDeckOfCardsID:
            return "/api/deck/new/"
        case .shuffleDeckOfCards(let id):
            return "/api/deck/\(id)/shuffle"
        case .getDeckOfCards(let id):
            return "/api/deck/\(id)/draw"
        }
    }
    
    var headers: [String : Any] {
        switch self {
        default:
            return ["Accept": "application/json"]
        }
    }
    
    var baseURL: URL? {
        guard let url = URL(string: "https://deckofcardsapi.com") else { return nil }
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getDeckOfCards:
            return [URLQueryItem(name: "count", value: "52")]
        default:
            return nil
        }
    }
    
    var request: URLRequest? {
        guard let baseURL = baseURL else { return nil }
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { return nil }
        urlComponents.path = path
        urlComponents.queryItems = parameters
        
        guard let headerValue = headers.values.first as? String else { return nil }
        guard let headerField = headers.keys.first else { return nil }
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(headerValue, forHTTPHeaderField: headerField)
        
        return urlRequest
    }
    
}
