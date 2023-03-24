//
//  ActivityView.swift
//  Timering
//
//  Created by Yuto on 2023/02/04.
//

import Foundation
import SwiftUI

struct ActivityView<Content: View, Player: View, Label: View>: View{
    
    @Environment(\.colorScheme) var colorScheme
    @State var playerStyle: PlayerStyle = .compact
    
    @Binding var allowFullScreen: Bool
    
    var content: () -> Content
    var player: () -> Player
    var label: () -> Label
    
    @ViewBuilder var body: some View{
        ZStack {
            NavigationStack {
                content()
            }
            .accessibilityElement(children: playerStyle == .compact ? .contain:.ignore)
            .disabled(playerStyle == .compact ? false:true)
            
            if playerStyle == .fullScreen {
                Button {
                    playerStyle = .compact
                } label: {
                    Text("Close")
                }
            }
            
            PlayerView($playerStyle, allowFullScreen: $allowFullScreen) {
                player()
            } label: {
                label()
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(allowFullScreen: .constant(true)) {
            Text("aa")
        } player: {
            ScrollView {
                ForEach(0..<20) { i in
                    Text("\(i)")
                }
            }
        } label: {
            PlayerCellView(
                symbol: "car",
                imageColor: .orange,
                title: "Car",
                subtitle: "",
                value: 135.7
            )
        }
    }
}
