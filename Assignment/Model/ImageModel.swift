//
//  ImageModel.swift
//  Assignment
//
//  Created by Vijay's Macbook on 21/08/20.
//  Copyright © 2020 Vijay. All rights reserved.
//

struct ImageModel: Codable {
    let total: Int
    let totalHits: Int
    var hits: [ImageDetail]
}

struct ImageDetail: Codable {
    let id: Int
    let type: String
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let views: Int
    let downloads: Int
    let likes: Int
}
