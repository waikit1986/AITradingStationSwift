//
//  Forecast10MinView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct ForecastHourlyView: View {
    let fcVM: ForecastVM
    let homeVM: HomeVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Chart1HView(fcVM: fcVM)

            ForecastDetailView(fcVM: fcVM, homeVM: homeVM)
                .onAppear {
                    fcVM.forecastSession = "hourly"
                }
        }
    }
}

#Preview {
    ForecastHourlyView(fcVM: ForecastVM(), homeVM: HomeVM())
}
