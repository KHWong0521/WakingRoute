//
//  ContentView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            TabView {
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }

                RouteListView()
                    .tabItem {
                        Label("Route List", systemImage: "list.bullet")
                    }
            }
        }
    }

}

#Preview {
    ContentView()
}
