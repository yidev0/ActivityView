//
//  PlayerCellView.swift
//  Timering
//
//  Created by Yuto on 2023/03/24.
//

import SwiftUI

struct PlayerCellView: View {
    
    let symbol: String
    let imageColor: Color
    var title: String
    var subtitle: String?
    var value: Double
    
    init(symbol: String, imageColor: Color, title: String, subtitle: String?, value: Double) {
        self.symbol = symbol
        self.imageColor = imageColor
        self.title = title
        self.subtitle = subtitle
        self.value = value
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: symbol)
                .foregroundStyle(imageColor.gradient)
            
            VStack(alignment: .leading) {
                if let subtitle = subtitle {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                } else {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.vertical, 8)
                }
            }
            .padding(.vertical, 12)
            
            Spacer()
            
            Text("\(value, specifier: "%.1f")")
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
    }
}

//struct PlayerCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerCellView()
//    }
//}
