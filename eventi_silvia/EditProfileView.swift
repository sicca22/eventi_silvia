//
//  EditProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 25/10/22.
//

import SwiftUI
import DBNetworking


struct EditProfileView: View {
    
    @State private var email = ""
    @State private var emailPlaceholder = ""
    @State private var emailError = false
    @State private var name = ""
    @State private var namePlaceholder = ""
    @State private var nameError = false
    @State private var surname = ""
    @State private var surnamePlaceholder = ""
    @State private var surnameError = false
    @State private var bornDate = ""
    @State private var bornDatePlaceholder = ""
    @State private var city = ""
    @State private var cityPlaceholder = ""
    //indica quando è possibile salvarel'utente
    @State private var canSave = true
    //per chiudere la pagina direttamente
    @Environment(\.presentationMode) private var presentationMode
    
    //enum Field: Int, Hashable {
    // case email
    // case name
    // }
    //@FocusState private var focused: Field?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    //Text("Email")
                   // TextField("\(emailPLaceholder)",text: $email)
                      //  .focused($focused, equals: .email)
                    //    .onSubmit {
                           // focused = .name
                        //}
                    
                   CustumTextField(
                   title: "Email", placeholder: "email", text: $email
                   , isError: emailError
                   )
                   .onChange(of: email) { _ in
                       validateForm()
                   }
                    CustumTextField(
                    title: "Nome", placeholder: "Nome", text: $name, isError:nameError
                    )
                    .onChange(of: name) { _ in
                        validateForm()
                    }
                    CustumTextField(
                    title: "Cognome", placeholder: "Cognome", text: $surname, isError:surnameError
                    )
                    .onChange(of: surname) { _ in
                        validateForm()
                    }
                    CustumTextField(
                    title: "Data di nascita", placeholder: "Data di nascita", text: $bornDate
                    )
                    CustumTextField(
                    title: "Città", placeholder: "Città", text: $city
                    )
                    
                
                }
                .padding()
            }
            .navigationTitle("Modifica profilo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismissModal()
                        }label: {
                            Image(systemName:  "xmark")
                        }
                    }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task{
                       await updateUserToServer()
                        }
                    }label: {
                        Image(systemName:  "checkmark")
                            
                    }
                    .disabled(canSave == false)
                }
                }
            .onAppear{
                email = LoginHelper.shared.loggedUser?.email ?? ""
            }
            
        }
    }
    //funzione da richiamare per chiudere questa pagina
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func validateForm() {
       //il nome deve andare in errore se è vuoto e h ameno di tre caratteri
        emailError = StringHelper.isValidEmail(email) == false
        //aggiorno il pulsante per salvare i dati
        canSave = isFormValid()
    }
    func isFormValid() -> Bool {

     // emailError == false
        return true
    }
   @MainActor func updateUserToServer()async {
//creo la lista dei parametri da inviare al server(solo qulli modifcati )
        var parameters = [String: String]()
        //metto l'email solo se non è vuota
        if email.isEmpty == false {
            parameters["email"] = self.email
        }
        let request = DBNetworking.request(
            url: "https://edu.davidebalistreri.it/app/v2/user",
            type: .put,
            parameters: parameters
        )
        let response = await request.response(type: ResponseModel.self)
    }
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelper.shared.load()
        return EditProfileView()
    }
    
}

struct CustumTextField: View{
    var title: String
    var placeholder: String
   @Binding var text: String
    
    var isError = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            TextField(placeholder,text: $text)
                .padding()
                .font(.system(size: 16, weight: .medium))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            isError ? .red : .gray
                       ,
                        lineWidth: 1
                        )
                }
                
            
        }
    }
}
