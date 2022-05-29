//
//  GeekJokesApp.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct GeekJokesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: AppState(currentFact: ""),
                                     reducer: reducer,
                                     environment: AppEnvironment(mainQueue: .main,
                                                                 networkRequest: {
                Effect(ChuckNorrisAPIService().fetchData())
            })))
        }
    }
}
