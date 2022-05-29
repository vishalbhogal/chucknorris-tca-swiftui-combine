//
//  AppReducer.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 21/05/22.
//

import Foundation
import ComposableArchitecture

let reducer = Reducer<AppState, AppActions, AppEnvironment> { appState, appActions, appEnvironment in
    switch appActions {
    case .displayFact(.success(let factResponse)):
        appState.currentFact = factResponse.fact
        return .none
        
    case .fetchNextFact:
        return appEnvironment.networkRequest()
            .receive(on: appEnvironment.mainQueue)
            .catchToEffect(AppActions.displayFact)
        
    case .displayFact(.failure(.unableToDecodeTheFact(let error))):
        appState.currentFact = "Chuck is unable to decode the error \(error)"
        return .none
        
    case .displayFact(.failure(.emptyURL)):
        appState.currentFact = "Sorry mate, Chuck didn't receive the URL"
        return .none
        
    case .displayFact(.failure(_)):
        return .none
    }
}
