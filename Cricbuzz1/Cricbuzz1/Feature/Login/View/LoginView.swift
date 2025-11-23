//
//  LoginView.swift
//  AppTest
//
//  Created by ganesh shankar on 23/11/25.
//

//import SwiftUI
//
//struct LoginView: View {
//    @EnvironmentObject var router: Router
//    @StateObject private var vm = LoginViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("Welcome")
//                    .font(.largeTitle)
//                    .bold()
//
//                TextField("Username", text: $vm.username)
//                    .textFieldStyle(.roundedBorder)
//                    .autocapitalization(.none)
//                    .padding(.horizontal)
//
//                SecureField("Password", text: $vm.password)
//                    .textFieldStyle(.roundedBorder)
//                    .padding(.horizontal)
//
//                Button(action: {
//                    if vm.login() {
//                        // navigate to movie list
//                        router.navigate(to: .movieList)
//                    } else {
//                        // simple feedback — replace with proper alert if needed
//                        print("Invalid credentials")
//                    }
//                }) {
//                    Text("Login")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(.borderedProminent)
//                .padding(.horizontal)
//
//                Spacer()
//            }
//            .padding(.top, 40)
//            .navigationBarHidden(true)
//        }
//    }
//}
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @StateObject private var vm = LoginViewModel()

    @State private var showLoginSheet = false

    var body: some View {
        ZStack {
            // MARK: - Background Image
            Image("backgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()
                    .frame(height: 700)

                // MARK: - Logo Button
                Button(action: {
                    withAnimation(.spring(response: 0.45, dampingFraction: 0.8)) {
                        showLoginSheet.toggle()
                    }
                }) {
                    Image("User")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                }
                Text("User")
                    .font(.title2)
                    .bold()
                Spacer()
            }

            // MARK: - LOGIN SHEET
            if showLoginSheet {
                loginPanel
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(100)
            }
        }
    }

    // MARK: - Login Panel
    private var loginPanel: some View {
        VStack(spacing: 20) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.black.opacity(0.4))
                .padding(.top, 8)

            Text("Login")
                .font(.title2)
                .bold()

            TextField("Username", text: $vm.username)
                .frame(width: 350, height: 80)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding(.horizontal , 20)

            SecureField("Password", text: $vm.password)
                .frame(width: 350, height: 80)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal , 20)

            Button(action: {
                if vm.login() {
                    router.navigate(to: .movieList)
                } else {
                    print("Invalid credentials")
                }
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .frame(width: 100,height: 50)
            .buttonStyle(.borderedProminent)
            .padding(.horizontal , 20)
            .padding(.bottom, 20)

        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height * 0.45) 
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.ultraThinMaterial)
                .frame(width: UIScreen.main.bounds.height * 0.45 ,height:  UIScreen.main.bounds.height * 0.45)
        )
        .ignoresSafeArea(edges: .bottom)
    }
}
