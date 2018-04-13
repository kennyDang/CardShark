//
//  CardService.swift
//  CardSharkiOS
//
//  Created by Kenny Dang on 4/11/18.
//

import Foundation

struct DeckService: Gettable {
    
    // MARK: - Instance properties
    
    typealias Data = DeckServerResponse
    var service: Service
    
    // MARK: - Initialization
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Gettable
    
    func get(completion: @escaping (Result<DeckServerResponse>) -> ()) {
        guard let request = service.request else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request) { (data, _, error) in
            defer {
                completion(Result.failure(error))
            }
            
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let cardData = try decoder.decode(DeckServerResponse.self, from: data)
                completion(Result.success(cardData))
            } catch let err {
                completion(Result.failure(err))
            }
        }.resume()
    }
}
