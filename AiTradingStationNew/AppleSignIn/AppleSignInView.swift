////
////  AppleSignInView.swift
////  Feel Buddha
////
////  Created by Low Wai Kit on 6/29/25.
////
//
//
//import SwiftUI
//import AuthenticationServices
//
//struct AppleSignInView: View {
//    @EnvironmentObject var appleSignInVM: AppleSignInVM
//    
//    var body: some View {
//        if let serverErrorMessage = appleSignInVM.serverErrorMessage {
//            Text(serverErrorMessage)
//        }
//        
//        if appleSignInVM.isLoggedIn == false {
//            ZStack {
//                Image("AppIcon")
//                    .frame(maxHeight: .infinity)
//                
//                SignInWithAppleButton(.signIn) { request in
//                    appleSignInVM.configure(request: request)
//                } onCompletion: { result in
//                    Task {
//                        await appleSignInVM.handleCompletion(result: result)
//                    }
//                }
//                .frame(width: 280, height: 45)
//                .cornerRadius(15)
//            }
//            
//        } else {
//            Button {
//                appleSignInVM.signOut()
//            } label: {
//                Text("Logout")
//                    .foregroundStyle(Color.white)
//                    .frame(width: 280, height: 45)
//                    .background {
//                        Color.black
//                    }
//                    .cornerRadius(15)
//            }
//        }
//    }
//}
//
//#Preview {
//    AppleSignInView()
//        .environmentObject(AppleSignInVM())
//}
