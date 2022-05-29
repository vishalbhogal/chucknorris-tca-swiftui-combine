//
//  GeekJokesServiceAPI.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import Combine
import Foundation

enum APIErrors: Error {
    case emptyURL
    case unableToDecodeTheFact(Error)
    case unsuccesfulStatusCode
}

protocol GeeksJokeServiceAPIServiceable {
    func fetchData() -> AnyPublisher<GeekJokesResponseModel, APIErrors>
}

class GeeksJokeServiceAPIService: GeeksJokeServiceAPIServiceable {
    func fetchData() -> AnyPublisher<GeekJokesResponseModel, APIErrors> {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")
        guard let url = url else {
            /// Creates a publisher that immediately terminates with the specified failure.
            return Fail(error: APIErrors.emptyURL).eraseToAnyPublisher()
        }

        let urlRequest = URLRequest(url: url)
        
        let publisher =  URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map{ $0.data }
            .flatMap {Just($0)}
            .decode(type: GeekJokesResponseModel.self, decoder: JSONDecoder())
            /// Handles the decoding error for the Data received
            .mapError { APIErrors.unableToDecodeTheFact($0) }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
