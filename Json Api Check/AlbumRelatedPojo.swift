//
//  AlbumRelatedPojo.swift
//  Json Api Check
//
//  Created by Artem Martus on 24.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

// https://app.quicktype.io?share=xWTdBUMDltz1PkN52Mzm
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albums = try Albums(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAlbum { response in
//     if let album = response.result.value {
//       ...
//     }
//   }

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albums = try Albums(json)

import Foundation
import RealmSwift
import Realm

// MARK: - Album
@objcMembers class Album: Object, Codable {
    dynamic var userID = -1, id = -1
    dynamic var title: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
    
    convenience init(userID: Int, id: Int, title: String?) {
        self.init()
        self.userID = userID
        self.id = id
        self.title = title
    }
}

// MARK: Album convenience initializers and mutators

extension Album {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Album.self, from: data)
        self.init(userID: me.userID, id: me.id, title: me.title)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        userID: Int? = nil,
        id: Int? = nil,
        title: String? = nil
    ) -> Album {
        return Album(
            userID: userID ?? self.userID,
            id: id ?? self.id,
            title: title ?? self.title
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Albums = [Album]

extension Array where Element == Albums.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Albums.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
