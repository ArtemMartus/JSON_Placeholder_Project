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


import Foundation
import RealmSwift
import Realm


// MARK: - User
class User: Object, Codable {
    @objc dynamic var id = -1
    @objc dynamic var name, username, email: String?
    @objc dynamic var address: Address?
    @objc dynamic var phone, website: String?
    @objc dynamic var company: Company?
    
    convenience init(id: Int, name: String?, username: String?, email: String?, address: Address?, phone: String?, website: String?, company: Company?) {
        self.init()
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
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
class Address: Object, Codable {
    @objc dynamic var street, suite, city, zipcode: String?
    @objc dynamic var geo: Geo?
    
    convenience init(street: String?, suite: String?, city: String?, zipcode: String?, geo: Geo?) {
        self.init()
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
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

// MARK: - Geo
class Geo: Object, Codable {
    @objc dynamic var lat, lng: String?
    
    convenience init(lat: String?, lng: String?) {
        self.init()
        self.lat = lat
        self.lng = lng
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

// MARK: - Company
class Company: Object, Codable {
    @objc dynamic var name, catchPhrase, bs: String?
    
    convenience init(name: String?, catchPhrase: String?, bs: String?) {
        self.init()
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
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
