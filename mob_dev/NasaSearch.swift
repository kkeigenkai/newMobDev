//
//  NasaSearch.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 10.01.2024.
//

import Foundation

func NewEmptyNasaSearch() -> NasaSearch {
    return NasaSearch(collection: NasaSearch.Collection(items: []))
}

struct NasaSearch: Decodable {
    var collection: Collection
    
    struct Collection: Decodable {
        var items: [Item]
        
        struct Item: Identifiable, Decodable {
            var id = UUID()
            var data: [Data]
            var links: [Links]
            
            private enum CodingKeys: String, CodingKey {
                case data
                case links
            }
            
            struct Data: Decodable {
                var title: String
                var date_created: String
                var description: String
            }
            
            struct Links: Decodable {
                var href: String
            }
            
            
            
        }
    }
}
