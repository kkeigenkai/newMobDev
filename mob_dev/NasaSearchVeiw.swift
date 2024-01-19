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
            
            NavigationStack {
                NasaSearchCardView().environmentObject(network)
            }
        }
    }
}

struct NasaSearchCardView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                TabView {
                    ForEach(network.searchResult.collection.items, id: \.id) { res in
                        NavigationLink(destination: NasaSearchCardDetailView(detail: res)) {
                            VStack(alignment: .center) {
                                Text(res.data[0].title).font(.title)
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                                YoutubeVideoView(url: res.links[0].href)
                            }
                            .frame(width: 300)
                            .padding(.horizontal, 24)
                            .padding(.top, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 30, style: .continuous).fill(
                                    .white
                                ).shadow(radius: 10)
                            )
                            .padding(.horizontal, 24)
                        }
                        
                    }.rotationEffect(.degrees(-90))
                        .frame(width: proxy.size.width)
                    
                }.rotationEffect(.degrees(90), anchor: .topLeading)
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .offset(x: proxy.size.width)
        }.tabViewStyle(
            PageTabViewStyle(indexDisplayMode: .never)
        )
    }
}

struct NasaSearchCardDetailView: View {
    var detail: NasaSearch.Collection.Item
    
    var body: some View {
        VStack {
            Text(detail.data[0].title)
                .font(.title)
                .multilineTextAlignment(.center)
            AsyncImage(url: URL(string: detail.links[0].href), scale: 2)
            Text(detail.data[0].description).padding()
            Spacer()
        }.padding(.top, 30)
    }
}
