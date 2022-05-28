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
    case unableToDecodeTheFact(String)
    case unsuccesfulStatusCode
}

protocol GeeksJokeServiceAPIServiceable {
    func fetchData() -> AnyPublisher<GeekJokesResponseModel, Error>
}

class GeeksJokeServiceAPIService: GeeksJokeServiceAPIServiceable {
    func fetchData() -> AnyPublisher<GeekJokesResponseModel, Error> {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api?format=json")
        let urlRequest = URLRequest(url: url!)
        let publisher =  URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map({ $0.data })
            .decode(type: GeekJokesResponseModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return publisher
    }
}
