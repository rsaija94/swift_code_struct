//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation


struct MovieModel:Codable {
    let feed:Feed?
}

struct Feed: Codable {
    let author:Author?
    let entry:[Entry]?
    let updated:Updated?
    let rights:Rights?
    let title:Title?
    let icon:Icons?
    let link:[ArrAttributes]?
    let id:Id?
    
}

struct Entry :Codable {
    let name: Name?
    let rights:Rights?
    let arrImage:[Image]?
    let summary:Summary?
    let rentalPrice:RentalPrice?
    let price:Price?
    let contentType:ContentType?
    let title:Title?
    let link:[Link]?
    let id:Id?
    let artist:Artist?
    let category:Category?
    let releaseDate:ReleaseDate?

    enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case rights
        case arrImage = "im:image"
        case summary
        case rentalPrice = "im:rentalPrice"
        case price = "im:price"
        case contentType = "im:contentType"
        case title
        case link
        case id
        case artist = "im:artist"
        case category
        case releaseDate = "im:releaseDate"
        
    }
}

struct ReleaseDate : Codable {
    let label:String?
    let attributes:Attributes?
}

struct Artist: Codable {
    let label:String?
}

struct Link : Codable {
    let duration:Duration?
    let attributes:Attributes?
    
    enum CodingKeys: String, CodingKey {
        case duration = "im:duration"
        case attributes
    }
}

struct Duration: Codable { 
    let label:String?
}


struct ContentType:Codable {
    let attributes:Attributes?
}

struct Price: Codable {
    let label:String?
    let attributes:Attributes?
}

struct Image : Codable {
    let label:String?
    let attributes:Attributes?
    
}

struct RentalPrice: Codable {
    let label:String?
    let attributes:Attributes?
}

struct Summary: Codable {
    let label:String?
}


struct Author:Codable {
    let name:Name?
    let uri:Uri?
}

struct Name: Codable {
    let label:String?
}

struct Uri: Codable {
    let label:String?

}

struct Updated:Codable {
    let label:String?

}

struct Rights:Codable {
    let label:String?
}


struct Title:Codable {
    let label:String?
}

struct Icons:Codable {
    let label:String?
}

struct Id: Codable {
    let label:String?
    let attributes:Attributes?
}

struct ArrAttributes : Codable {
    let attributes:Attributes?
}

struct Category:Codable {
    let attributes:Attributes?
}

struct Attributes: Codable {
    let rel,type,href,height,amount,currency,term,label,title,scheme,assetType,id: String?
    
    enum CodingKeys: String, CodingKey {
        case rel,type,href,height,amount,currency,term,label,title,scheme
        case assetType = "im:assetType"
        case id = "im:id"
        
    }
}
