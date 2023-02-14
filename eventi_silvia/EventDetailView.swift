

import SwiftySound
import SwiftUI
import MapKit
import DBNetworking


//aggiugere possibilta di cancellare i prori eventi
//aggiungere il pulsante per visualizzare l'getto ar 

struct EventDetailView: View {
    
    // Per poter chiudere la pagina da un bottone x:
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // L'evento da rappresentare
    var eventToShow: EventModel    
    //meteo
    @State private var temperatura: Double?
    @State var alertsuccess = false
        @State var alertdelete = false
        @State var alerterror = false
    // L'area sulla mappa
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42, longitude: 12),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5)
    )

    
    //questo boolean determina se se è visibile l'alert di acquisto
    @State var isAlertPurchaseVisible = false
    @State var isAlertMoneyVisible = false
   
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
           ImageView(url: eventToShow.coverUrl )
                .ignoresSafeArea()
                .frame(height: 220)
                .mask(Rectangle().edgesIgnoringSafeArea(.top))
            // Nascondo il pulsante per tornare indietro
                .navigationBarHidden(true)
            // Aggiungo il pulsante custom per tornare indietro
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            Button {

                                // Chiudo la pagina corrente

                                self.presentationMode.wrappedValue.dismiss()
                            
                            } label: {

                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22).bold())
                                    .padding()

                            }

                            .padding()

                        }

                      
                        Spacer()
                    }

                }

            

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(eventToShow.categoryName ?? "senza categoria".uppercased())
                       
                        .foregroundColor(.gray)
                        .bold()

                    

                    Text(eventToShow.name ?? "Evento senza titolo")

                        .font(.system(size: 24).weight(.semibold))

                    

                    HStack {
                        // Data
                        VStack {
                            Text(eventToShow.dayString)
                                .font(.system(size: 20).bold())
                            
                            Text(eventToShow.monthString.uppercased())
                                .font(.system(size: 14).bold())
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(hex: 0x000000, alpha: 0.8))
                        .cornerRadius(16)
                        .padding(.trailing, 8)

                        

                        VStack(alignment: .leading) {
                            Text(eventToShow.address ?? "Nome posto")
                                .font(.system(size: 24).weight(.semibold))

                            

                            Text(eventToShow.timeString)
                                .font(.system(size: 18).weight(.semibold))

                        }

                    }

                    

                    NavigationLink (destination: EventMapView(eventToShow: eventToShow)) {
                        Map(
                            coordinateRegion: $region,
                            //disabilito l'interazione dell'utente
                            
                            annotationItems: [eventToShow.mapLocation],
                            annotationContent: { location in
                                MapMarker(coordinate: location.coordinate )
                            }
                        )
                        
                            .frame(height: 160)
                        .cornerRadius(16)
                    }

                    

                    Text(eventToShow.address ?? "Indirizzo evento")
                        .bold()
                    
                    Text(eventToShow.description ?? "Descrizione evento")

                    HStack {
                                           
                                            Text("Previsioni meteo🌦")
                                            Text("")
                                            if temperatura == nil {
                                                Text("-")
                                                
                                            }else {
                                                Text("\(Int(temperatura!))°C")
                                            }
                                                
                                            }
                    HStack  {
                        ImageView(url:eventToShow.user?.avatarUrl)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                            VStack (alignment: .leading){
                                Text(eventToShow.user?.lastName ?? "Organizzatore")
                                Text("Eventi creati: \(eventToShow.user?.eventsCount ?? 0)")
                                
                            
                        }
                        HStack() {
                                                        
                                                        Button{
                                                            alertdelete = true
                                                        } label: {
                                                            Text("Elimina evento")
                                                                .font(.system(size: 18).bold())
                                                                .foregroundColor(.red)
                                                                .padding()
                                                        }
                                                        .background(Color("Error"))
                                                        .cornerRadius(16)
                                                        .padding(.bottom)
                                                        .alert(isPresented: $alertdelete) {
                                                            Alert(
                                                                title: Text("Vuoi eliminare l'evento?"),
                                                                primaryButton: .destructive(Text("Elimina")) {
                                                                    Task {
                                                                        await deleteEvent()
                                                                    }
                                                                },
                                                                secondaryButton: .cancel(Text("Annulla"))
                                                            )
                                                        }
                                                    }
                        Spacer()
                        NavigationLink (destination: UserView(userToShow: eventToShow.user ?? UserModel())) {
                            Image (systemName: "arrow.right")
                        }
                            
                        
                        
                    }
                    
                    Spacer()
                }
                .padding()
              
                
            
            }
            
            
            
            
            Divider()
                
            
            HStack{
                            Text(eventToShow.priceString)
                            .font(.system(size: 30).bold())

                            Spacer()
                                .alert("🛒 Hai appena acquistato 🤪", isPresented: $isAlertPurchaseVisible){}
                                .alert("🤑 Fondi insufficienti" , isPresented: $isAlertMoneyVisible){}
                            Button {
                                //codice bottone
                                addEventToCard()
                               
                            } label: {
                                Text("Acquista")
                                .foregroundColor(.white)
                                .bold()
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(Color("baseColor"))
                            .cornerRadius(16)
                        }

            .padding()
            
        }
        .onAppear{
                    region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: eventToShow.lat ?? 0, longitude: eventToShow.lng ?? 0),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.5,
                            longitudeDelta: 0.5
                        )
                    )
                    
                    Task{
                        let weatherRequest = DBNetworking.request(
                            url: "https://edu.davidebalistreri.it/app/v2/weather",
                            parameters: [
                                "lat": eventToShow.lat ?? 0,
                                "lng": eventToShow.lng ?? 0,
                                "appid": "ied",
                            ])

                        let weatherResponse = await weatherRequest
                            .response(type: NSDictionary.self)
                        
                        temperatura = weatherResponse.body?.value(forKeyPath: "main.temp") as? Double
                    }
                }
    }
      
    
    
    func addEventToCard () {
        //controlla se il biglietto è superiore
        //- aggiungere l'evento al carrello
        //mostrare l'alert di successo
        
        let loggedUserMoney = LoginHelper.shared.loggedUser?.money ?? 0
        
        let eventPrice = eventToShow.price ?? 0
        
        if loggedUserMoney >= eventPrice {
            isAlertPurchaseVisible = true
            CartHelper.shared.add(item: eventToShow)
            Sound.play(file:"acquisto.mp3")
        } else {
            isAlertMoneyVisible = true
            
        }
        
        
    }
    func deleteEvent() async {
                let request = DBNetworking.request(
                    url: "https://edu.davidebalistreri.it/app/v2/event/\(eventToShow.id ?? 0)",
                    type: .delete,
                    authToken: LoginHelper.shared.loggedUser?.authToken
                )
                Task {
                    let response = await request.response()
                    if response.success {
                        alertsuccess = true
                    }
                    else {
                        alerterror = true
                    }
                }
            }


}


struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            EventDetailView(eventToShow: EventModel(
                name: "evento di prova",
                coverUrl: "https://www.budapest.org/wp-content/uploads/sites/22/Calendario.jpg",
                lat: 42,
                lng:12
            ))
        }

        

    }

}

