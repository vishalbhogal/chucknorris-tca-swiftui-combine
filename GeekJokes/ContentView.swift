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
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor.black
       store = Store(initialState: AppState(currentFact: ""),
                                 reducer: reducer,
                                 environment: AppEnvironment(mainQueue: .main,
                                                             networkRequest: {
            Effect(ChuckNorrisAPIService().fetchData())
        }))
    }
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
            ZStack {
                LinearGradientColors(color: .duskyBrown)
                VStack(alignment: .center, spacing: 15) {
                    Text("Preach Norris")
                        .font(.system(.title, design: .monospaced))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .shadow(color: .gray, radius: 1)
                        .padding(.all, 9)
                        .background(LinearGradientColors(color: .duskyBrown))
                        .cornerRadius(12)
                        
                    
                    Image("chuckNorris")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Text(viewStore.currentFact)
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.black)
                        .frame(width: 300, height: 200, alignment: .center)
                        .padding(.all, 15)
                        .background(LinearGradientColors(color: .multiOrange))
                        .border(Color(0x202020), width: 3)
                        .cornerRadius(5)
                    
                    Text("Next Fact")
                        .font(.system(.headline, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 1)
                        .onTapGesture{ viewStore.send(.fetchNextFact)}
                        .padding(.all, 12)
                        .background(LinearGradientColors(color: .traditionalOrange))
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
}

struct LinearGradientColors: View {
    var color: Colors
    var body: some View {
        switch color {
        case .duskyBrown:
            LinearGradient(colors: [Color(0xfd533e), .orange], startPoint: .bottom, endPoint: .top)
        case .parrotGreen:
            LinearGradient(colors: [Color(0xcc001), .green], startPoint: .trailing, endPoint: .leading)
        case .traditionalOrange:
            Color(0xFD9346)
        case .multiOrange:
            LinearGradient(colors: [Color(0xfd533e), .orange], startPoint: .leading, endPoint: .trailing)
        case .dryLeaf:
                LinearGradient(colors: [Color(0x999966), .white], startPoint: .leading, endPoint: .trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
