//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Adam Saxton on 8/30/24.
//

// TODO: Add more tests

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {

    let imageFetcher = ImageFetcher.shared
    let dataFetcher = DataFetcher()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

    }

    func testImageFetcherEmptyStringInput() async throws {
        do {
            let image = try await imageFetcher.imageFetcher(imageName:"")
            XCTAssert(false)
        } catch ErrorWithData.retrievingImageFromURL {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }

    func testDataFetcherEmptyStringInput() async throws {
        do {
            let data = try await dataFetcher.getWeatherData(location: "")
            XCTAssert(false)
        } catch ErrorWithData.retrievingData {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
