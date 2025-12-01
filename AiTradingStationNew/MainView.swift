//
//  ContentView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI

struct MainView: View {
    @State private var homeVM = HomeVM()
    @State private var fcVM = ForecastVM()
    @State private var reviewVM = ReviewVM()
    
    var body: some View {
        VStack {
            ForecastView(fcVM: fcVM)
        }
        .fontDesign(.rounded)
        .preferredColorScheme(.dark)
        .onAppear {
            reviewVM.triggerReviewAfterDelay()
        }
        .sheet(isPresented: $homeVM.isShowingAiTerms) {
            TermsView(homeVM: homeVM)
                .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    MainView()
}
