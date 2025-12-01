//
//  HeaderView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct HeaderView: View {
    let fcVM: ForecastVM
    
    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "dd/MM HH:mm"
        return f
    }()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Menu {
                ForEach(fcVM.symbolList, id: \.self) { sym in
                    Button(sym) {
                        Task {
                            fcVM.symbol = sym
                        }
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text((fcVM.forecastSession == "hourly" ? fcVM.chart10MinData.last?.symbol : fcVM.chartDailyData.last?.symbol) ?? "--")
                    .font(.title)
                    .fontWeight(.bold)

                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .opacity(0.7)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            
            Text(String(format: "%.2f", fcVM.chart10MinData.last?.close ?? 0))
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("last updated: \(fcVM.chart10MinData.last?.timestamp != nil ? Self.timeFormatter.string(from: fcVM.chart10MinData.last!.timestamp) : "--")")
                .font(.caption2)
                .fontWeight(.thin)
            
            Text(fcVM.chart10MinData.last?.symbol_name ?? "--")
                .font(.title3)
                .fontWeight(.thin)
        }
    }
}

#Preview {
    HeaderView(fcVM: ForecastVM())
}
