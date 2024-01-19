//
//  ContentView.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 06.01.2024.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        ZStack {
            TabView {
                PictureOfTheDayView().environmentObject(network)
                    .frame(height: 670)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous).fill(
                            .white
                        ).shadow(radius: 10)
                    )
                    .padding(.horizontal, 24)
                NasaSearchVeiw().environmentObject(network)
            }
            .tabViewStyle(.page)
            .ignoresSafeArea()
        }.ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
    }
}

struct YoutubeVideoView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let path = url
        guard let url = URL(string: path) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
