//
//  NasaSearchVeiw.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 10.01.2024.
//

import SwiftUI

struct NasaSearchVeiw: View {
    @EnvironmentObject var network: Network
    @State var query = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "Nasa Search",
                text: $query
            ).textFieldStyle(.roundedBorder).onChange(of: query) {
                network.getNasaSearch(query: query)
            }.padding()
            
            NasaSearchCardView().environmentObject(network)
        }
    }
}

struct NasaSearchCardView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(network.searchResult.collection.items, id: \.id) { res in
                    VStack(alignment: .center) {
                        Text(res.data[0].title).font(.title)
                        YoutubeVideoView(url: res.links[0].href)
                        Text(res.data[0].description)
                    }
                    .frame(width: 300, height: 600)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous).fill(
                            .white
                        ).shadow(radius: 10)
                    )
                    .padding(.horizontal, 24)
                }.rotationEffect(.degrees(-90))
                    .frame(width: proxy.size.width, height: proxy.size.height)
                
            }.rotationEffect(.degrees(90), anchor: .topLeading)
                .frame(width: proxy.size.height, height: proxy.size.width)
                .offset(x: proxy.size.width)
        }.tabViewStyle(
            PageTabViewStyle(indexDisplayMode: .never)
        )
    }
}
