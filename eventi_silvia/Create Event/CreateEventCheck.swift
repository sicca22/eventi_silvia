//
//  CreateEventCheck.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 06/12/22.
//

import SwiftUI
import DBNetworking



struct CreateEventCheck: View {
    
    @EnvironmentObject var event: CreatingEventModel
    @State var gotoNext = false
    
    // Quando è true la schermata si blocca e l'evento viene inviato al server
    @State private var isSendingEvent = false
    
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 24
            ) {
                VStack(alignment: .leading, spacing: 24
                ) {
                    Image(uiImage: event.photo ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .background(.gray)
                        .frame(height: 200)
                        .cornerRadius(16)
                        .clipped()
                     
                        .padding()
                }
                
                
                
                VStack(alignment: .leading) {
                    Text(event.nome)
                        .bold()
                }
                
                VStack(alignment: .leading) {
                    Text(event.descrizione)
                }
                
                HStack {
                    Text("Prezzo:").bold()
                    Text(event.price)
                }
                
                HStack {
                    Text("Data:").bold()
                    Text(event.dateString)
                }
                
                VStack(alignment: .leading) {
                    
                    Text(event.address)
                }
                
                .padding(.bottom, 8)
                Spacer()
                VStack {
                    
                   
                    
                    Button {
                        sendEventToServer()
                    } label: {
                        Text("Conferma e crea")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(.blue)
                    .cornerRadius(16)
                    
                }
                
               
                
            }
            .padding()
            .navigationTitle("Riepilogo")
            .opacity(isSendingEvent ? 0.4 : 1)
            .allowsHitTesting(!isSendingEvent)
            
            ProgressView()
                .opacity(isSendingEvent ? 1 : 0)
        }
        
    }
    @MainActor func sendEventToServer() {
        print(event)
        
        guard let cover = event.photo else {
            return
        }
        // Ridimensiono l'immagine sfruttando UIutilities
        let resized = UIHelper.resize(
            image: cover,
            targetSize: CGSize(width: 500, height: 500),
            fill: false
        )
        
        // Comprimo immagine e la salvo come compressed
        let compressed = UIHelper.compress(
            image: resized,
            compression: 0.8
        )
        
        let coverFile = DBNetworking.MultipartFile(
            parameterName: "cover",
            fileName: "cover.jpg",
            // Formato del file che stiamo inviando, questo è x i jpg
            mimeType: "image/jpg",
            data: compressed
        )
        
        isSendingEvent = true
        let request = DBNetworking.request(
            url: "https://edu.davidebalistreri.it/app/v2/event",
            type: .multipartPost,
            authToken: LoginHelper.shared.loggedUser?.authToken,
            parameters: [
                "name": event.nome,
                "description": event.descrizione,
                "price": event.price,
                "address":  event.address,
                "lat": event.coordinate?.latitude ?? 0,
                "lng": event.coordinate?.latitude ?? 0,
                "date": event.dateStringForServer,
            ],
            multipartFiles: [coverFile]
        )
        
        // Invio la richiesta al server
        Task {
            let response = await request.response()
            if response.success{
                event.isCreated = true
            } else {
                
            }
            try? await Task.sleep(nanoseconds:500_000_000)
            isSendingEvent = false
        }
    }
}

struct CreateEventRiepilogoView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let eventoPreview = CreatingEventModel()
        eventoPreview.nome = "Nome evento"
        eventoPreview.photo = UIImage()
        
        return NavigationView {
            
            CreateEventCheck()
                .environmentObject(eventoPreview)
                .navigationTitle("Riepilogo crea evento")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
