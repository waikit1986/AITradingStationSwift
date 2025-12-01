//
//  ForecastView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastView: View {
    let fcVM: ForecastVM
    
    var body: some View {
        VStack {
            HeaderView(fcVM: fcVM)
                .padding()
            
            TabView {
                ForecastHourlyView(fcVM: fcVM)
                    .padding()
                    .tabItem {
                        Text("Hourly")
                    }
                    .tag(0)
                
                ForecastDailyView(fcVM: fcVM)
                    .padding()
                    .tabItem {
                        Text("Daily")
                    }
                    .tag(1)
            }
        }
    }
}

#Preview {
    ForecastView(fcVM: ForecastVM())
        .preferredColorScheme(.dark)
}

