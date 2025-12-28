//
//  ContentView.swift
//  AiTradingStationNew
//
//  Created by Low Wai Kit on 11/23/25.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

struct MainView: View {
    @State private var vm = ViewModel()
    @State private var reviewVM = ReviewVM()
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_MyODCWbHNtKLbXyzEyacImWUYUX", appUserID: nil)
    }
    
    var body: some View {
        VStack {
            ForecastView(vm: vm, reviewVM: reviewVM)
        }
        .fontDesign(.rounded)
        .preferredColorScheme(.dark)
        .task {
            reviewVM.triggerReviewAfterDelay()
            
            if let customerInfo = try? await Purchases.shared.customerInfo() {
                let entitlementActive = customerInfo.entitlements[Constants.ENTITLEMENT_ID]?.isActive == true
                vm.hasPremiumAccess = entitlementActive
            }
            
            for await customerInfo in Purchases.shared.customerInfoStream {
                let entitlementActive = customerInfo.entitlements[Constants.ENTITLEMENT_ID]?.isActive == true
                await MainActor.run {
                    vm.hasPremiumAccess = entitlementActive
                }
            }
        }
    }
}


struct Constants {
    static let ENTITLEMENT_ID = "Monthly AI Forecast Access"
}

#Preview {
    MainView()
}
