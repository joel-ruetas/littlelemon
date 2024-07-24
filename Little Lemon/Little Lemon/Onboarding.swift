//  Onboarding.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-21.
//

import SwiftUI

let kFirstName = "First Name key"
let kLastName = "Last Name key"
let kEmail = "Email key"
let kIsLoggedIn = "IsLoggedIn key"

struct Onboarding: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isLoggedIn = false
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                
                Text("Sign Up")
                    .font(.custom("MarkaziText-Medium", size: 64))
                    .fontWeight(.bold)
                    .foregroundColor(.highlight2)
                
                Spacer()
                
                VStack(spacing: 16) {
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 16)
                
                Spacer()
                
                Button(action: {
                    validateForm()
                }) {
                    Text("Register")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary 1"))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 24)
                
                Spacer()
            }
            .alert(isPresented: $showFormInvalidMessage) {
                Alert(
                    title: Text("ERROR"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func validateForm() {
        // customerFirstName and customerLastName must contain just letters
        let firstNameIsValid = isValid(name: firstName)
        let lastNameIsValid = isValid(name: lastName)
        let emailIsValid = isValid(email: email)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid
        else {
            var invalidFirstNameMessage = ""
            if firstName.isEmpty || !isValid(name: firstName) {
                invalidFirstNameMessage = "First Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if lastName.isEmpty || !isValid(name: lastName) {
                invalidLastNameMessage = "Last Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidEmailMessage = ""
            if !email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return
        }
                
        if firstNameIsValid && lastNameIsValid && emailIsValid {
            // Save Customer information
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            
            // form is valid, proceed
            isLoggedIn = true
        }
    }
    
    func isValid(name: String) -> Bool {
        let nameRegex = "^[A-Za-z]{3,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    
    func isValid(email: String) -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
