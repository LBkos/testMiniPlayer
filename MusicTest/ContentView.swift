//
//  ContentView.swift
//  MusicTest
//
//  Created by Константин Лопаткин on 26.07.2023.
//

import SwiftUI

struct ContentView: View {
    @Namespace var animation
    @State var expand = false
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView {
                    Text("Text")
                        .tag(1)
                        .tabItem {
                            Label("Browse", systemImage: "rectangle.grid.2x2.fill")
                        }
                    Text("Text")
                        .tag(2)
                        .tabItem {
                            Label("Night", systemImage: "moon.stars.fill")
                        }
                    Text("Text")
                        .tag(3)
                        .tabItem {
                            Label("Reed", systemImage: "book.fill")
                        }
                    Text("Text")
                        .tag(4)
                        .tabItem {
                            Label("Library", systemImage: "bookmark.fill")
                        }
                    Text("Text")
                        .tag(5)
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
            }
            MiniPlayer(animation: animation, expand: $expand)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
