//
//  UTTypeProtocol.swift
//  LegacyUTType
//
//  Created by Benjamin Erhart on 15.02.23.
//

import MobileCoreServices
import Photos
import UniformTypeIdentifiers


public protocol UTTypeProtocol: Codable, Hashable, CustomStringConvertible {

    var uti: CFString { get }

    var identifier: String { get }

    var preferredMIMEType: String? { get }

    var preferredFilenameExtension: String? { get }

    associatedtype TagClass: UTTagClassProtocol
    var tags: [TagClass: [String]] { get }

    var isDeclared: Bool { get }

    var isDynamic: Bool { get }

    var isPublic: Bool { get }

    var legacy: LegacyUTType { get }

    var avFileType: AVFileType { get }

    @available(iOS 14.0, *)
    var utType: UTType? { get }

    @available(iOS 14.0, *)
    var utTypeReference: UTTypeReference? { get }


    init?(_ uti: CFString)

    init?(_ uti: String)

    init?(_ utType: any UTTypeProtocol)

    @available(iOS 14.0, *)
    init?(_ utType: UTTypeReference)

    func conforms(to base: LegacyUTType) -> Bool

    func conforms(to base: AVFileType) -> Bool

    @available(iOS 14.0, *)
    func conforms(to base: UTType) -> Bool

    @available(iOS 14.0, *)
    func conforms(to base: UTTypeReference) -> Bool

    func conforms(to base: String) -> Bool

    func conforms(to base: CFString?) -> Bool
}

extension UTTypeProtocol {

    // MARK: Public Properties

    public var preferredMIMEType: String? {
        UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() as String?
    }

    public var preferredFilenameExtension: String? {
        UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension)?.takeRetainedValue() as String?
    }

    public var tags: [LegacyUTTagClass: [String]] {
        var tags = [LegacyUTTagClass: [String]]()

        let append = { (tagClass: CFString) in
            if let data = UTTypeCopyAllTagsWithClass(self.uti, tagClass)?.takeRetainedValue() {
                var t = [String]()

                for i in 0 ..< CFArrayGetCount(data) {
                    t.append(unsafeBitCast(CFArrayGetValueAtIndex(data, i), to: CFString.self) as String)
                }

                tags[LegacyUTTagClass(rawValue: tagClass as String)] = t
            }
        }

        append(kUTTagClassMIMEType)

        append(kUTTagClassFilenameExtension)

        return tags
    }

    public var legacy: LegacyUTType {
        LegacyUTType(uti)
    }

    public var avFileType: AVFileType {
        AVFileType(rawValue: identifier)
    }

    @available(iOS 14.0, *)
    public var utType: UTType? {
        UTType(identifier)
    }

    @available(iOS 14.0, *)
    public var utTypeReference: UTTypeReference? {
        UTTypeReference(identifier)
    }

    public var isDeclared: Bool {
        UTTypeIsDeclared(uti)
    }

    public var isDynamic: Bool {
        UTTypeIsDynamic(uti)
    }

    public var isPublic: Bool {
        identifier.hasPrefix("public.")
    }


    // MARK: CustomStringConvertible

    public var description: String {
        identifier
    }

    public var localizedDescription: String? {
        UTTypeCopyDescription(uti)?.takeRetainedValue() as String?
    }


    // MARK: Public Methods

    public func conforms(to base: LegacyUTType) -> Bool {
        conforms(to: base.uti)
    }

    public func conforms(to base: AVFileType) -> Bool {
        conforms(to: base.uti)
    }

    @available(iOS 14.0, *)
    public func conforms(to base: UTType) -> Bool {
        conforms(to: base.uti)
    }

    @available(iOS 14.0, *)
    public func conforms(to base: UTTypeReference) -> Bool {
        conforms(to: base.identifier)
    }

    public func conforms(to base: String) -> Bool {
        conforms(to: base as CFString)
    }

    public func conforms(to base: CFString?) -> Bool {
        guard let base = base else {
            return false
        }

        return UTTypeConformsTo(uti, base)
    }
}
