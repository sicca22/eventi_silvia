//
//  ArModel.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 31/01/23.
//

import Foundation


struct ArModel: Codable{
    /// Se presente, l'immagine del marker verrà scaricata da internet
    var markerUrl: String?
    
    /// Es: 0.05 metri
    var markerPhysicalWidth: Double = 0.05
    
    /// Es: "book.scn"
    var scnName: String?
    
    /// Se presente, l'oggetto 3D verrà scaricato da internet
    var scnObjectUrl: String?
    
    /// Se presente, la texture dell'oggetto 3D verrà scaricata da internet
    var scnTextureUrl: String?
    
    /// Es: "book"
    var nodeName: String?
    
    /// Es: 0.05
    var nodeScaleFactor: Double = 0.05
    
    /// Rotazione (es: 90 gradi)
    var nodeRotationX: Float = 0
    var nodeRotationY: Float = 0
    var nodeRotationZ: Float = 0
    
    /// Traslazione (es. 0.02)
    var nodePositionX: Float = 0
    var nodePositionY: Float = 0.02
    var nodePositionZ: Float = 0
}
