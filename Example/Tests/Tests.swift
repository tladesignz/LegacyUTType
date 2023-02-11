import XCTest
import LegacyUTType
import MobileCoreServices
import UniformTypeIdentifiers
import Photos

class Tests: XCTestCase {

    private let video = LegacyUTType.video
    private let jpeg = LegacyUTType.jpeg

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProperties() {
        XCTAssertEqual(jpeg.uti, "public.jpeg" as CFString)

        XCTAssertEqual(jpeg.identifier, "public.jpeg")

        XCTAssertEqual(jpeg.preferredFilenameExtension, "jpeg")

        XCTAssertEqual(jpeg.preferredMIMEType, "image/jpeg")

        XCTAssertEqual(jpeg.tags, ["public.mime-type": ["image/jpeg", "image/jpg"], "public.filename-extension": ["jpeg", "jpg", "jpe"]])

        XCTAssertTrue(video.isDeclared)

        XCTAssertFalse(video.isDynamic)

        XCTAssertTrue(video.isPublic)

        XCTAssertEqual(video.description, "public.video")

        XCTAssertEqual(video.localizedDescription, "video")
    }

    func testConformance() {
        XCTAssertTrue(video.conforms(to: .movie))

        XCTAssertTrue(video.conforms(to: kUTTypeMovie))

        XCTAssertTrue(video.conforms(to: kUTTypeMovie as String))
    }

    func testAVFileType() {
        XCTAssertEqual(AVFileType.jpg.legacy, jpeg)

        XCTAssertEqual(LegacyUTType(AVFileType.jpg).identifier, "public.jpeg")

        XCTAssertTrue(AVFileType.jpg.legacy.conforms(to: .image))
    }

    @available(iOS 14.0, *)
    func testUTType() {
        XCTAssertTrue(video.conforms(to: UTType.movie))

        XCTAssertEqual(video.utType, UTType.video)

        XCTAssertEqual(UTType.video.legacy, video)

        var tags = [String: [String]]()

        for t in UTType.video.tags {
            tags[t.key.rawValue] = t.value
        }

        let uttJpeg = UTType.jpeg

        XCTAssertEqual(video.tags, tags)

        XCTAssertEqual(jpeg.uti, uttJpeg.identifier as CFString)

        XCTAssertEqual(jpeg.identifier, uttJpeg.identifier)

        XCTAssertEqual(jpeg.preferredFilenameExtension, uttJpeg.preferredFilenameExtension)

        XCTAssertEqual(jpeg.preferredMIMEType, uttJpeg.preferredMIMEType)

        XCTAssertEqual(jpeg.isDeclared, uttJpeg.isDeclared)

        XCTAssertEqual(jpeg.isDynamic, uttJpeg.isDynamic)

        XCTAssertEqual(jpeg.isPublic, uttJpeg.isPublic)

        XCTAssertEqual(jpeg.description, uttJpeg.description)

        XCTAssertEqual(jpeg.localizedDescription, uttJpeg.localizedDescription)
    }
}
