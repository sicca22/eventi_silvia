//
//  CreateEventView.swift
//  eventi_silvia
//
//  Created by iedstudent on 15/11/22.
//

import SwiftUI
import DBNetworking

//@State var goToNext = true


import SwiftUI

struct CreateEvent: View {
    
    @StateObject var event = CreatingEventModel()
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var gotoNext = false
    
    @State var isActive = false
    
   
    
    var body: some View {
        
        NavigationView {
            

            VStack (alignment: .leading, spacing: 0) {
               
                
                Text("Benvenuto organizzatore")
                    .bold()
                    .font(.system(size:36).bold())
                    .padding(.bottom)
                Text("Inizia la pianificazionedel tuo evento")
                    .bold()
                    .font(.system(size:16).bold())
                    .foregroundColor(Color("secondaryColor"))
                    .padding(.bottom)
                CustumTextField(
                    title: "Nome",
                    placeholder: "Inserisci il nome",
                    text: $event.nome
                )
                .padding(.bottom)
                
                CustumTextField(
                    title: "Descrizione",
                    placeholder: "Inserisci la Descrizione",
                    text: $event.descrizione
                )
                .padding(.bottom)
                
                CustumTextField(
                    title: "Prezzo",
                    placeholder: "Inserisci il prezzo",
                    text: $event.price
                )
                .padding(.bottom)
                Spacer()
                VStack (alignment: .center){
                   
                    Button {

                        // Chiudo la pagina corrente

                        self.presentationMode.wrappedValue.dismiss()
                    
                    } label: {

                        Text("Torna alla pagina eventi")
                            .foregroundColor(Color("secondaryColor"))
                            .font(.system(size: 18).bold())
                     
                    }
                    

                }
                Spacer()
                
                Button  {
                    gotoNext = true
                } label: {
                    Text("Avanti")
                        .font(.system(size:16).bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(Color("baseColor2"))
                .cornerRadius(16)
                
                
                NavigationLink(destination: CreateEventDateView(), isActive: $gotoNext) {}
                    .opacity(0)
                
                
                
            }
            
            .padding()
            .navigationTitle("Crea Evento")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: event.isCreated) { _ in
           dismissModal()
            
            
        }
        .environmentObject(self.event)
    }
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}


struct CreateEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateEvent()
    }
}
