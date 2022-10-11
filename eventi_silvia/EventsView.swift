//
//  EventsView.swift
//  eventi_silvia
//
//  Created by iedstudent on 24/05/22.
//

import SwiftUI
import MapKit

struct EventsView: View {
    //eventi da mostrare
    
    @State var eventsToShow: [EventModel] = []
    @State var isList = true
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42, longitude: 12),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5)
    )

    
    var body: some View {
        NavigationView {
            
            Group{
                if isList {
            List(eventsToShow) { event in
                ZStack {
                    EventCard(eventToShow: event)
                        
                    NavigationLink(destination: EventDetailView(eventToShow: event)) { }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
                
            }
            
            //tolgo il padding intorno alla lista
            .listStyle(.plain)
                } else {
                    Map(coordinateRegion: $region)
                }
            }
            //metto un titolo provvisorio alla pagina
            .navigationTitle("Eventi")
            .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    Task {
                        //scarico la lista degli eventi appena compare la pagina
                        await updateEvents()
                    }
            }
                .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                isList.toggle()
                            }label: {
                                Image(systemName: isList ? "map" : "list.bullet.below.rectangle")
                            }
                        }
                    }
        }
    }
    @MainActor func updateEvents() async {
        eventsToShow = await DBNetworking
            .request(url: "https://edu.davidebalistreri.it/app/v2/events")
            .response(type: EventResponse.self)
            .body?.data ?? []
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}


struct EventCard: View {
    var eventToShow: EventModel
    
    var body: some View {
        VStack (alignment: .leading){
            ImageView(
                url: eventToShow.coverUrl )
                .frame(height:200)
                .cornerRadius(24)
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text(eventToShow.dayString)
                                    .font(.system(size: 20) .bold())
                                Text(eventToShow.monthString.uppercased())
                                    .font(.system(size:14).bold())
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hex: 0x00000, alpha: 8.0))
                            .cornerRadius(16)
                        .padding()
                        }
                        Spacer()
                    }
                }
            
            
            Text( eventToShow.name ?? "Evento senza titolo")
                .font(.system(size: 24).weight(.medium))
                .padding(.bottom,1 )
            HStack () {
                
            Image(systemName: "tag.fill")
                
            Text(eventToShow.priceString).bold()
            
        }
        }
        
    }
}
