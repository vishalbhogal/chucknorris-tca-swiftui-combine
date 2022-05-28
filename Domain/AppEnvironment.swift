//
//  AppEnvironment.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 21/05/22.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    var joke: () -> Effect<GeekJokesResponseModel, Error>
}
