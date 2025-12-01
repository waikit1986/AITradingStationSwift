//
//  ReviewViewModel.swift
//  Buddha
//
//  Created by Low Wai Kit on 11/17/24.
//

import Foundation
import StoreKit

@MainActor
@Observable
class ReviewVM {
    var reviewRequestCounter = 0 {
        didSet {
            UserDefaults.standard.set(reviewRequestCounter, forKey: "reviewRequestCounter")
        }
    }
    var hasTriggeredReview = false
    
    func requestReview() {
        if reviewRequestCounter < 3 {
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                AppStore.requestReview(in: windowScene)
                reviewRequestCounter += 1
                print("review requested: \(reviewRequestCounter)")
            } else {
                print("No active UIWindowScene for requestReview found.")
            }
        }
    }
    
    func triggerReviewAfterDelay() {
        guard !hasTriggeredReview else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.hasTriggeredReview = true
            self.requestReview()
        }
    }
}
