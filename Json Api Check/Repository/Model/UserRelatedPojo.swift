//
//  UserRelatedPojo.swift
//  Json Api Check
//
//  Created by Artem Martus on 16.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

// https://app.quicktype.io?share=3C8e4RzrklGLRSOSp3dn
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let users = try Users(json)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUser { response in
//     if let user = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire
import RealmSwift
import Realm


// MARK: - User
@objcMembers class User: Object, Codable {
    dynamic let id: Int
    dynamic let name, username, email: String
    dynamic let address: Address
    dynamic let phone, website: String
    dynamic let company: Company

    init(id: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
        super.init()
    }
    
    required init() {
        id = -1
        name = noInternetString;
        username = name; email = name; phone = name; website = name
        address = Address(); company = Company()
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

// MARK: User convenience initializers and mutators

extension User {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(User.self, from: data)
        self.init(id: me.id, name: me.name, username: me.username, email: me.email, address: me.address, phone: me.phone, website: me.website, company: me.company)
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
        id: Int? = nil,
        name: String? = nil,
        username: String? = nil,
        email: String? = nil,
        address: Address? = nil,
        phone: String? = nil,
        website: String? = nil,
        company: Company? = nil
    ) -> User {
        return User(
            id: id ?? self.id,
            name: name ?? self.name,
            username: username ?? self.username,
            email: email ?? self.email,
            address: address ?? self.address,
            phone: phone ?? self.phone,
            website: website ?? self.website,
            company: company ?? self.company
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAddress { response in
//     if let address = response.result.value {
//       ...
//     }
//   }

// MARK: - Address
@objcMembers class Address: Object, Codable {
    dynamic let street, suite, city, zipcode: String
    dynamic let geo: Geo

    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
        super.init()
    }
    
    required init() {
        city = noInternetString
        street = city; zipcode = city; suite = city
        geo = Geo()
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

// MARK: Address convenience initializers and mutators

extension Address {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Address.self, from: data)
        self.init(street: me.street, suite: me.suite, city: me.city, zipcode: me.zipcode, geo: me.geo)
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
        street: String? = nil,
        suite: String? = nil,
        city: String? = nil,
        zipcode: String? = nil,
        geo: Geo? = nil
    ) -> Address {
        return Address(
            street: street ?? self.street,
            suite: suite ?? self.suite,
            city: city ?? self.city,
            zipcode: zipcode ?? self.zipcode,
            geo: geo ?? self.geo
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseGeo { response in
//     if let geo = response.result.value {
//       ...
//     }
//   }

// MARK: - Geo
@objcMembers class Geo: Object, Codable {
    dynamic let lat, lng: String

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
        super.init()
    }
    
    required init() {
        lat = noInternetString
        lng = lat
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

// MARK: Geo convenience initializers and mutators

extension Geo {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Geo.self, from: data)
        self.init(lat: me.lat, lng: me.lng)
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
        lat: String? = nil,
        lng: String? = nil
    ) -> Geo {
        return Geo(
            lat: lat ?? self.lat,
            lng: lng ?? self.lng
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCompany { response in
//     if let company = response.result.value {
//       ...
//     }
//   }

// MARK: - Company
@objcMembers class Company: Object, Codable {
    dynamic let name, catchPhrase, bs: String

    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
        super.init()
    }
    
    required init() {
        bs = noInternetString
        name = bs; catchPhrase = bs
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}

// MARK: Company convenience initializers and mutators

extension Company {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Company.self, from: data)
        self.init(name: me.name, catchPhrase: me.catchPhrase, bs: me.bs)
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
        name: String? = nil,
        catchPhrase: String? = nil,
        bs: String? = nil
    ) -> Company {
        return Company(
            name: name ?? self.name,
            catchPhrase: catchPhrase ?? self.catchPhrase,
            bs: bs ?? self.bs
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias Users = [User]

extension Array where Element == Users.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Users.self, from: data)
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

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
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
    func responseUsers(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Users>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
