import XCTest
@testable import SDL
@testable import SDL_image

final class SDL_image_Tests: XCTestCase {
    func testImage() {
        let flags = IMG_INIT_PNG.rawValue
        let rv = IMG_Init(Int32(flags))
        XCTAssertGreaterThanOrEqual(rv, 0, String(cString: SDL_GetError()))
        IMG_Quit()
    }
    
    func testLoadImage() {
        guard
          let imageURL = Bundle.module.url(forResource: "image", withExtension: "png"),
          let surface = IMG_LoadPNG_RW(SDL_RWFromFile(imageURL.path, "rb"))
        else {
            XCTFail(String(cString: SDL_GetError()))
            return
        }
        SDL_FreeSurface(surface)
    }
}
