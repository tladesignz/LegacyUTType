//
//  LegacyUTType.swift
//  LegacyUTType
//
//  Created by Benjamin Erhart on 10.02.23.
//

import Foundation
import MobileCoreServices
import UniformTypeIdentifiers

open class LegacyUTType {

    public static let movie = LegacyUTType(kUTTypeMovie)
    public static let audio = LegacyUTType(kUTTypeAudio)
    public static let video = LegacyUTType(kUTTypeVideo)
    public static let image = LegacyUTType(kUTTypeImage)

    // TODO: Add more predefined types.


    public let uti: CFString


    open var identifier: String {
        uti as String
    }

    open var preferredMIMEType: String? {
        guard let mimeType = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return nil
        }

        return mimeType as String
    }

    open var preferredFilenameExtension: String? {
        guard let ext = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension)?.takeRetainedValue()
        else {
            return nil
        }

        return ext as String
    }


    @available(iOS 14.0, *)
    public convenience init(_ uttype: UTType) {
        self.init(uttype.identifier)
    }

    public convenience init(_ uti: String) {
        self.init(uti as CFString)
    }

    public init(_ uti: CFString) {
        self.uti = uti
    }


    open func conforms(to base: LegacyUTType) -> Bool {
        conforms(to: base.uti)
    }

    @available(iOS 14.0, *)
    open func conforms(to base: UTType) -> Bool {
        conforms(to: base.identifier)
    }

    open func conforms(to base: String) -> Bool {
        conforms(to: base as CFString?)
    }

    open func conforms(to base: CFString?) -> Bool {
        guard let base = base else {
            return false
        }

        return UTTypeConformsTo(uti, base)
    }
}

