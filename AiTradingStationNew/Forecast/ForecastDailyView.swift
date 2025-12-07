//
//  ForecastDailyView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastDailyView: View {
    let fcVM: ForecastVM
    let homeVM: HomeVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ChartDailyView(fcVM: fcVM)

            ForecastDetailView(fcVM: fcVM, homeVM: homeVM)
                .onAppear {
                    fcVM.forecastSession = "morning"
                }
        }
    }
}

#Preview {
    ForecastDailyView(fcVM: ForecastVM(), homeVM: HomeVM())
}
