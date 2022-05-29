//
//  ContentView.swift
//  GeekJokes
//
//  Created by Vishal, Bhogal (B.) on 16/04/22.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppActions>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                LinearGradient(colors: [.green, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack(alignment: .center, spacing: 15) {
                    Text("Chuck Norris Who??")
                        .font(.system(.title, design: .monospaced))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Image("chuckNorris")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Text(viewStore.currentFact)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.black)
                        .frame(width: 300, height: 200, alignment: .center)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                    
                    Text("Next Fact")
                        .font(.system(.headline, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .onTapGesture{ viewStore.send(.fetchNextFact)}
                        .padding(.all, 12)
                        .background(.black)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: .init(currentFact: "Looks like you wanna read some Norris Facts"),
                                 reducer: reducer,
                                 environment: AppEnvironment(mainQueue: .main,
                                                             networkRequest: {
            Effect(ChuckNorrisAPIService().fetchData())
        })))
    }
}
