//
//  ContentView.swift
//  ActivityView
//
//  Created by Yuto on 2023/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var allowFullScreen = true
    @State var selectedColor: Color = .primary
    
    let colors: [Color] = [
        .yellow, .orange, .red, .blue, .green, .mint, .purple, .indigo
    ]
    
    var body: some View {
        TabView {
            ActivityView(allowFullScreen: $allowFullScreen) {
                List {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            self.selectedColor = color
                        } label: {
                            HStack {
                                Circle()
                                    .foregroundColor(color)
                                    .frame(height: 40)
                                Text(color.description)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
            } player: {
                ScrollView {
                    Circle().foregroundColor(selectedColor)
                }
            } label: {
                cell
            }
            .tabItem {
                Label("Tab 1", systemImage: "car")
            }
            
            ActivityView(allowFullScreen: $allowFullScreen) {
                selectedColor
            } player: {
                ScrollView {
                    Circle().foregroundColor(selectedColor)
                }
            } label: {
                cell
            }
            .tabItem {
                Label("Tab 1", systemImage: "tram")
            }
        }
    }
    
    var cell: some View {
        PlayerCellView(
            symbol: "circle.fill",
            imageColor: .blue,
            title: selectedColor.description,
            subtitle: nil,
            value: 0
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
