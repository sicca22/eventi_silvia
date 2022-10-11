//
//  WebView.swift
//  eventi_silvia
//
//  Created by iedstudent on 11/10/22.
//

import SwiftUI
import WebKit
//representable serve per utilizzare una vecchia view del framework uikit
struct WebView: UIViewRepresentable {
    
    var url: String?
    func makeUIView(context: Context) -> WKWebView {
        //creo la view da ui kit
        return WKWebView()
    }
    //configuro l apagina caricata
    func updateUIView(_ webView: WKWebView, context: Context) {
        //guard e in if al contrario , non va avanti se la condizione non si verifica
        guard let url = URL(string: url ?? "") else {
            return
            
        }
        let urlRequest = URLRequest(url:url)
        webView.load(urlRequest)
    }
}
