//
//  UTTagClassProtocol.swift
//  LegacyUTType
//
//  Created by Benjamin Erhart on 15.02.23.
//

public protocol UTTagClassProtocol: Codable, Hashable, CustomStringConvertible {

    var rawValue: String { get }

    init(rawValue: String)
}

extension UTTagClassProtocol {
    
    public static var filenameExtension: LegacyUTTagClass {
        LegacyUTTagClass(rawValue: "public.filename-extension")
    }

    public static var mimeType: LegacyUTTagClass {
        LegacyUTTagClass(rawValue: "public.mime-type")
    }


    // MARK: Equatable

    public static func == (lhs: Self, rhs: any UTTagClassProtocol) -> Bool {
        lhs.rawValue == rhs.rawValue
    }


    // MARK: Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }


    // MARK: CustomStringConvertible

    public var description: String {
        rawValue
    }
}
