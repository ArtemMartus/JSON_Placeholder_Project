//
//  PostRelatedPojo.swift
//  Json Api Check
//
//  Created by Artem Martus on 24.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

// https://app.quicktype.io?share=xEK9DpdHkgNoFhoxcPY1
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let posts = try Posts(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePost { response in
//     if let post = response.result.value {
//       ...
//     }
//   }


import RealmSwift
import Realm
import Foundation
import Alamofire

// MARK: - Post
@objcMembers class Post: Object, Codable {
    dynamic var userID = -1, id = -1
    dynamic var title, body: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    convenience init(userID: Int, id: Int, title: String?, body: String?) {
        self.init()
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}

// MARK: Post convenience initializers and mutators

extension Post {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Post.self, from: data)
        self.init(userID: me.userID, id: me.id, title: me.title, body: me.body)
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
        title: String? = nil,
        body: String? = nil
    ) -> Post {
        return Post(
            userID: userID ?? self.userID,
            id: id ?? self.id,
            title: title ?? self.title,
            body: body ?? self.body
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Posts = [Post]

extension Array where Element == Posts.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Posts.self, from: data)
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

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responsePosts(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Posts>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
