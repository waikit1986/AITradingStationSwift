//
//  Forecast10MinView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastHourlyView: View {
    let fcVM: ForecastVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Chart10MinView(fcVM: fcVM)

            ForecastDetailView(fcVM: fcVM)
                .onAppear {
                    fcVM.forecastSession = "hourly"
                }
        }
    }
}

#Preview {
    ForecastHourlyView(fcVM: ForecastVM())
}
