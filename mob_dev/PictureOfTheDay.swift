//
//  PictureOfTheDay.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 06.01.2024.
//

import Foundation

struct PictureOfTheDay: Decodable {
    var date: String
    var url: String
    var title: String
    var explanation: String
}
