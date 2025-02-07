//
//  StatisticsView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import SwiftUI

struct StatisticsView: View {
    
    let stat: Statistic
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accentColor)
            
            HStack {
                Image(systemName: "triangle.fill")
                    .rotationEffect(
                        Angle(degrees: (
                            stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                    .font(.caption2)
                    .foregroundStyle(
                        (stat.percentageChange ?? 0) >= 0 ?
                        Color.theme.greenColor :
                        Color.theme.redColor
                    )
                Text((stat.percentageChange ?? 0).asPercentString())
                    .font(.caption)
                    .bold()
                    .foregroundStyle(
                        (stat.percentageChange ?? 0) >= 0 ?
                        Color.theme.greenColor :
                        Color.theme.redColor
                    )
            }
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
                
        }
    }
}

#Preview {
    StatisticsView(stat: Statistic(name: "Market Cap",
                                   value: "$123.4Tr",
                                   percentageChange: 2.4))
}
