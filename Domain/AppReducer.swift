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
    case .displayJoke(.success(let jokeResponseModel)):
        appState.currentJoke = jokeResponseModel.joke
        return .none
        
    case .fetchNextJoke:
        return appEnvironment.joke()
            .receive(on: appEnvironment.mainQueue)
            .catchToEffect(AppActions.displayJoke)
        
    case .displayJoke(.failure(APIErrors.unableToDecodeTheFact(let errorText))):
        appState.currentJoke = errorText
        return .none
        
    case .displayJoke(.failure(APIErrors.emptyURL)):
        appState.currentJoke = "Please send the URL"
        return .none
        
    case .displayJoke(.failure(APIErrors.unsuccesfulStatusCode)):
        return .none
        
    case .displayJoke(.failure(_)):
        return .none
    }
}
