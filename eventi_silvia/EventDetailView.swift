


import SwiftUI
import MapKit



struct EventDetailView: View {
    
    // Per poter chiudere la pagina da un bottone x:
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    // L'evento da rappresentare
    var eventToShow: EventModel    

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

                    

                    Map(coordinateRegion: $region)
                        .frame(height: 160)
                        .cornerRadius(16)

                    

                    Text(eventToShow.address ?? "Indirizzo evento")
                        .bold()
                    
                    Text(eventToShow.description ?? "Descrizione evento")

                  
                    
                    Spacer()
                }
                .padding()
                
            }
            
            
            HStack {
                ImageView(url:eventToShow.user?.avatarUrl)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                VStack {
                    Text(eventToShow.user?.lastName ?? "Organizzatore")
                    Text("\(eventToShow.user?.eventsCount ?? 0)")
                    
                }
                Image (systemName: "arrow.right")
                    
                
                
            }
            
            Divider()
                
            
            HStack{
                            Text(eventToShow.priceString)
                            .font(.system(size: 30).bold())

                            Spacer()
                                .alert("🛒 Aggiunto al carrello", isPresented: $isAlertPurchaseVisible){}
                                .alert("🤑 Fondi insufficienti" , isPresented: $isAlertMoneyVisible){}
                            Button {
                                if LoginHelper.shared.loggedUser?.money == eventToShow.price {
                                    isAlertPurchaseVisible = true
                                } else {
                                    isAlertMoneyVisible = true
                                }
                            } label: {
                                Text("Acquista")
                                .foregroundColor(.white)
                                .bold()
                            }
                            .padding(.horizontal, 32)
                            .padding(.vertical, 16)
                            .background(.blue)
                            .cornerRadius(16)
                        }

            .padding()
            
        }
    }
}



struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            EventDetailView(eventToShow: EventModel(
                name: "evento di prova",
                coverUrl: "https://www.budapest.org/wp-content/uploads/sites/22/Calendario.jpg"
            ))
        }

        

    }

}

