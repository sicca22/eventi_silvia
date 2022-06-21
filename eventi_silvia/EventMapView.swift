//
//  EventMapView.swift
//  eventi_silvia
//
//  Created by iedstudent on 21/06/22.
//

import SwiftUI
import MapKit

struct EventMapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var eventToShow: EventModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 42, longitude: 12),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5)
    )
    var body: some View {
      
        ZStack {
       
            Map(
                coordinateRegion: $region,
                //disabilito l'interazione dell'utente
                
                annotationItems: [eventToShow.mapLocation],
                annotationContent: { location in
                    MapMarker(coordinate: location.coordinate )
                }
            )
                .ignoresSafeArea()
        
        
        
            VStack {
                Spacer()
                Button {
                
            } label: {
                Text("Apri mappe")
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

struct EventMapView_Previews: PreviewProvider {
    static var previews: some View {
        EventMapView(eventToShow: EventModel(
            name: "evento di prova",
            coverUrl: "https://www.budapest.org/wp-content/uploads/sites/22/Calendario.jpg",
            lat: 42,
            lng:12
        ))
    }
}
