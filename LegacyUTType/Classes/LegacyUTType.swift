//
//  LegacyUTType.swift
//  LegacyUTType
//
//  Created by Benjamin Erhart on 10.02.23.
//

import MobileCoreServices
import Photos
import UniformTypeIdentifiers

public struct LegacyUTTagClass: UTTagClassProtocol {

    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

/**
 Brings the convenience of `UTType`s to iOS before version 14.
 */
open class LegacyUTType: UTTypeProtocol {

    public enum CodingKeys: CodingKey {
        case uti
    }


    // MARK: Predefined Types

    public static let item = LegacyUTType(kUTTypeItem)
    public static let data = LegacyUTType(kUTTypeData)
    public static let audiovisualContent = LegacyUTType(kUTTypeAudiovisualContent)
    public static let movie = LegacyUTType(kUTTypeMovie)
    public static let audio = LegacyUTType(kUTTypeAudio)
    public static let video = LegacyUTType(kUTTypeVideo)
    public static let image = LegacyUTType(kUTTypeImage)
    public static let jpeg = LegacyUTType(kUTTypeJPEG)

    // TODO: Add more predefined types.


    // MARK: Equatable

    public static func == (lhs: LegacyUTType, rhs: LegacyUTType) -> Bool {
        UTTypeEqual(lhs.uti, rhs.uti)
    }


    // MARK: Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uti)
    }


    // MARK: Public Properties

    public let uti: CFString


    open var identifier: String {
        uti as String
    }


    // MARK: Initializers

    public required init(_ uti: CFString) {
        self.uti = uti
    }

    public required convenience init(_ uti: String) {
        self.init(uti as CFString)
    }

    public required convenience init(_ utType: any UTTypeProtocol) {
        self.init(utType.uti)
    }

    @available(iOS 14.0, *)
    public required convenience init?(_ utType: UTTypeReference) {
        self.init(utType.identifier as CFString)
    }


    // MARK: Decodable

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        uti = try container.decode(String.self, forKey: .uti) as CFString
    }


    // MARK: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(identifier, forKey: .uti)
    }
}

extension AVFileType: UTTypeProtocol {


    // MARK: Public Properties

    public var uti: CFString {
        rawValue as CFString
    }

    public var identifier: String {
        rawValue
    }


    // MARK: Initializers

    public init(_ uti: CFString) {
        self.init(rawValue: uti as String)
    }

    public init(_ utType: any UTTypeProtocol) {
        self.init(rawValue: utType.identifier)
    }

    @available(iOS 14.0, *)
    public init?(_ utType: UTTypeReference) {
        self.init(rawValue: utType.identifier)
    }
}

@available(iOS 14.0, *)
extension UTTagClass: UTTagClassProtocol {
}

@available(iOS 14.0, *)
extension UTType: UTTypeProtocol {

    public var uti: CFString {
        identifier as CFString
    }


    // MARK: Initializers

    public init?(_ uti: CFString) {
        self.init(uti as String)
    }

    public init?(_ utType: any UTTypeProtocol) {
        self.init(utType.identifier)
    }

    public init?(_ utType: UTTypeReference) {
        self.init(utType.identifier)
    }
}
