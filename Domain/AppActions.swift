//
//  AppActions.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 21/05/22.
//

import Foundation

enum AppActions {
    case displayJoke(Result<GeekJokesResponseModel, Error>)
    case fetchNextJoke
}
