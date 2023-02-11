//
//  LegacyUTType.swift
//  LegacyUTType
//
//  Created by Benjamin Erhart on 10.02.23.
//

import MobileCoreServices
import Photos
import UniformTypeIdentifiers

/**
 Brings the convenience of `UTType`s to iOS before version 14.
 */
open class LegacyUTType: Hashable, Codable, CustomStringConvertible {

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


    // MARK: Public Properties

    public let uti: CFString


    open var identifier: String {
        uti as String
    }

    open var preferredMIMEType: String? {
        UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() as String?
    }

    open var preferredFilenameExtension: String? {
        UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension)?.takeRetainedValue() as String?
    }

    open var tags: [String: [String]] {
        var tags = [String: [String]]()

        let append = { (tagClass: CFString) in
            if let data = UTTypeCopyAllTagsWithClass(self.uti, tagClass)?.takeRetainedValue() {
                var t = [String]()

                for i in 0 ..< CFArrayGetCount(data) {
                    t.append(unsafeBitCast(CFArrayGetValueAtIndex(data, i), to: CFString.self) as String)
                }

                tags[tagClass as String] = t
            }
        }

        append(kUTTagClassMIMEType)

        append(kUTTagClassFilenameExtension)

        return tags
    }

    @available(iOS 14.0, *)
    open var utType: UTType? {
        UTType(identifier)
    }

    open var isDeclared: Bool {
        UTTypeIsDeclared(uti)
    }

    open var isDynamic: Bool {
        UTTypeIsDynamic(uti)
    }

    open var isPublic: Bool {
        identifier.hasPrefix("public.")
    }


    // MARK: CustomStringConvertible

    public var description: String {
        identifier
    }

    public var localizedDescription: String? {
        UTTypeCopyDescription(uti)?.takeRetainedValue() as String?
    }


    // MARK: Initializers

    @available(iOS 14.0, *)
    public convenience init(_ utType: UTType) {
        self.init(utType.identifier)
    }

    public convenience init(_ avFileType: AVFileType) {
        self.init(avFileType.rawValue)
    }

    public convenience init(_ uti: String) {
        self.init(uti as CFString)
    }

    public init(_ uti: CFString) {
        self.uti = uti
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


    // MARK: Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uti)
    }


    // MARK: Public Methods

    open func conforms(to base: LegacyUTType) -> Bool {
        conforms(to: base.uti)
    }

    @available(iOS 14.0, *)
    open func conforms(to base: UTType) -> Bool {
        conforms(to: base.identifier)
    }

    open func conforms(to base: String) -> Bool {
        conforms(to: base as CFString)
    }

    open func conforms(to base: CFString?) -> Bool {
        guard let base = base else {
            return false
        }

        return UTTypeConformsTo(uti, base)
    }
}

extension AVFileType {

    public var legacy: LegacyUTType {
        LegacyUTType(self)
    }
}

@available(iOS 14.0, *)
extension UTType {

    public var legacy: LegacyUTType {
        LegacyUTType(self)
    }
}
