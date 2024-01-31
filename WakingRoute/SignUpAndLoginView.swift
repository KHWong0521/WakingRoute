//
//  LoginView.swift
//  WakingRoute
//
//  Created by KwanHoWong on 31/1/2024.
//

import SwiftUI
import Firebase

struct SignUpAndLoginView: View {
    
    @Binding var showLoginView : Bool
    @Binding var isLoggedIn : Bool
    @Binding var isSigningUp : Bool
    
    @Binding var username : String

    @State var email = ""
    @State var password = ""
    @State var copassword = ""
    @Binding var alertTitle : String
    @Binding var showAlert : Bool

    var body: some View {
        if isLoggedIn {
            // Profile page
            VStack {
                Text("Current User:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("\(username)").padding()
                Button(action: {
                    signOut()
                    isLoggedIn = false
                    showLoginView = false
                }, label: {
                    Text("Sign out")
                })
            }
        } else if isSigningUp {
            // Sign up
            VStack {
                Button(action: {
                    isSigningUp = false
                    clearInput()
                }, label: {
                    Text("Log in")
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Text("Sign up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                TextField("Email", text: $email)
                    .padding()
                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                Text("Confirm Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                SecureField("Confirm Password", text: $copassword)
                    .padding()
                Button(action: {
                    signUp()
                }) {
                    Text("Sign up")
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(alertTitle)")
                )
            }
        } else {
            // Login page
            VStack {
                Button(action: {
                    isSigningUp = true
                    clearInput()
                }, label: {
                    Text("Sign up")
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                Text("Log in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Email")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                TextField("Email", text: $email)
                    .padding()
                Text("Password")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()
                Button(action: {
                    login()
                }) {
                    Text("Sign in")
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(alertTitle)")
                )
            }
        }
        
    }
    
    func clearInput() {
        email = ""
        password = ""
        copassword = ""
    }
    
    func signUp() {
        if email.isEmpty {
            alertTitle = "Please fill your email"
            showAlert = true
        } else if password.isEmpty {
            alertTitle = "Please fill your password"
            showAlert = true
        } else if password.count < 6 {
            alertTitle = "Password length must be atleast 6 characters"
            showAlert = true
        } else if copassword.isEmpty {
            alertTitle = "Please confirm your password"
            showAlert = true
        } else if password != copassword {
            alertTitle = "Password and Confirmed Password do not match"
            showAlert = true
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("success sign up")
                    username = email
                    isLoggedIn = true
                    showLoginView = false
                }
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success log in")
                username = email
                isLoggedIn = true
            }
        }
        
    }
}

