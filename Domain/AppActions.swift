//
//  AppActions.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 21/05/22.
//

import Foundation

enum AppActions {
    case displayFact(Result<FactsResponseModel, APIErrors>)
    case fetchNextFact
}
