//
//  PlayerView.swift
//  Timering
//
//  Created by Yuto on 2023/02/04.
//

import Foundation
import SwiftUI

struct PlayerView<Label: View, Content: View>: View {
    
    @Namespace var namespace
    @Binding var style: PlayerStyle
    @Binding var allowFullPlayer: Bool
    @State var visibility: Visibility = .visible
    
    @State var viewHeight: CGFloat = 0
    @State var cellOffset: CGFloat = 0
    @State var dragOrigin: CGPoint = .zero
    
    var content: Content
    var label: Label
    @State var radius: CGFloat
    
    init(
        _ style: Binding<PlayerStyle>,
        allowFullScreen: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self._style = style
        self._allowFullPlayer = allowFullScreen
        self.label = label()
        self.content = content()
        
        self._radius = .init(initialValue: 0)
        print(self.radius, self._radius, Date())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch style {
            case .compact:
                Spacer()
                cell
                    .matchedGeometryEffect(id: "Player", in: namespace)
//                Divider()
            case .fullScreen:
                fullScreen
            }
        }
        .toolbar(visibility, for: .tabBar)
        .animation(.easeInOut, value: style)
        .onChange(of: style) { newValue in
            switch newValue {
            case .compact:
                visibility = .visible
            case .fullScreen:
                visibility = .hidden
            }
        }
        .highPriorityGesture(
            DragGesture()
                .onChanged { value in
                    if dragOrigin == .zero {
                        dragOrigin = value.location
                    } else {
                        if value.location.y > dragOrigin.y {
                            cellOffset = value.location.y - dragOrigin.y
                        }
                    }
                    checkCollpase(0.5)
                }
                .onEnded { value in
                    withAnimation {
                        cellOffset = 0
                        dragOrigin = .zero
                    }
                    checkCollpase(0.3)
                }
        )
    }
    
    var fullScreen: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: cellOffset)
                cell
                Divider()
                    .background(Color.secondary)
                VStack {
                    content
                    Spacer()
                }
                .opacity(style == .fullScreen ? 1:0)
                .animation(.easeOut, value: style)
                .transition(.move(edge: .bottom))
                .background(.thinMaterial)
                .matchedGeometryEffect(id: "Player", in: namespace)
            }
            .onAppear {
                viewHeight = geometry.size.height
            }
            .onChange(of: geometry.size.width) { newValue in
                viewHeight = newValue
            }
        }
    }
    
    var cell: some View {
        Button {
            withAnimation {
                style = (style == .compact) ? (allowFullPlayer ? .fullScreen:.compact):.compact
            }
        } label: {
            label
        }
        .background(.thinMaterial)
        .matchedGeometryEffect(id: "Cell", in: namespace)
    }
    
    func checkCollpase(_ percentage: CGFloat) {
//        print(cellOffset, viewHeight * percentage)
        if cellOffset > viewHeight * percentage && cellOffset > 0 {
            style = .compact
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayerView(.constant(.compact), allowFullScreen: .constant(true)) {
                ScrollView {
                    ForEach(0..<10) { i in
                        Text("\(i)")
                    }
                }
            } label: {
                PlayerCellView(symbol: "camera",
                           imageColor: .blue,
                           title: "Title",
                           subtitle: "Subtitle",
                           value: 12.3)
            }
            
            PlayerCellView(symbol: "camera",
                       imageColor: .blue,
                       title: "Title",
                       subtitle: "Subtitle",
                       value: 12.3)
            
            PlayerCellView(symbol: "car",
                       imageColor: .orange,
                       title: "Title",
                       subtitle: "Subtitle",
                       value: 123.4)
        }
    }
}

