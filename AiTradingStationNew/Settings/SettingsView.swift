//
//  SettingsView.swift
//  aitradingstation
//
//  Created by Low Wai Kit on 9/20/25.
//

import SwiftUI

struct SettingsView: View {
    let vm: ViewModel
    let reviewVM: ReviewVM
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("LEGAL")) {
                        NavigationLink(destination: TermsView(vm: vm)) {
                            Text("AI Forecast Terms and Conditions")
                        }
                        NavigationLink(destination: PrivacyPolicyView()) {
                            Text("Privacy Policy")
                        }
                        Text("Review the App")
                            .onTapGesture {
                                reviewVM.requestReview()
                            }
                        Link("Website", destination: URL(string: "https://aitradingstation.com")!)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemBackground))
                
                Spacer()

            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(vm: ViewModel(), reviewVM: ReviewVM())
}
