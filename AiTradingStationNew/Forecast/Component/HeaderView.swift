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
        f.timeZone = TimeZone(identifier: "America/New_York")
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
                    Text((fcVM.forecastSession == "hourly" ? fcVM.headerLatestPrice.last?.symbol : fcVM.chartDailyData.last?.symbol) ?? "--")
                    .font(.title)
                    .fontWeight(.bold)

                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .opacity(0.7)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            
            VStack {
                Text(fcVM.headerLatestPrice.last?.symbol_name ?? "--")
                    .font(.title3)
                    .fontWeight(.thin)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Text(String(format: "%.2f", fcVM.headerLatestPrice.last?.marketstack_last ?? 0))
                .font(.largeTitle)
                .fontWeight(.bold)
            
//            HStack(spacing: 20) {
//                VStack(alignment: .leading) {
//                    Text("Prev Open")
//                        .font(.caption2)
//                        .foregroundStyle(Color.gray)
//                    Text(String(format: "%.2f", fcVM.headerLatestPrice.last?.open ?? 0))
//                        .font(.caption)
//                        .foregroundStyle(Color.white)
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Prev High")
//                        .font(.caption2)
//                        .foregroundStyle(Color.gray)
//                    Text(String(format: "%.2f", fcVM.headerLatestPrice.last?.high ?? 0))
//                        .font(.caption)
//                        .foregroundStyle(Color.green)
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Prev Low")
//                        .font(.caption2)
//                        .foregroundStyle(Color.gray)
//                    Text(String(format: "%.2f", fcVM.headerLatestPrice.last?.low ?? 0))
//                        .font(.caption)
//                        .foregroundStyle(Color.red)
//                }
//                
//                VStack(alignment: .leading) {
//                    Text("Prev Close")
//                        .font(.caption2)
//                        .foregroundStyle(Color.gray)
//                    Text(String(format: "%.2f", fcVM.headerLatestPrice.last?.low ?? 0))
//                        .font(.caption)
//                        .foregroundStyle(Color.blue)
//                }
//            }

            Text("last updated derived data: \(fcVM.headerLatestPrice.last?.timestamp != nil ? Self.timeFormatter.string(from: fcVM.headerLatestPrice.last!.timestamp) : "--")")
                .font(.caption2)
                .fontWeight(.thin)
        }
        .onAppear {
            Task {
                await fcVM.fetchLatestHeaderPrice()
                await fcVM.fetchDailyChart()
                await fcVM.fetch15minChart()
            }
        }
        .task(id: fcVM.symbol) {
            await fcVM.fetchLatestHeaderPrice()
            await fcVM.fetchDailyChart()
            await fcVM.fetch15minChart()
        }
    }
}

#Preview {
    HeaderView(fcVM: ForecastVM())
}
