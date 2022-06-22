//
//  LoremsTests.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

import Nimble
import Quick

@testable import CatchTest

class LoremsTests: QuickSpec {
  override func spec() {
    describe("Lorems") {
      var data: [Lorem]?

      afterEach {
        data = nil
      }

      context("when decoding status 200 response") {
        beforeEach {
          data = self.getDecodedObject()
        }

        it("should have non-nil decoded response") {
          expect(data).toNot(beNil())
        }
      }
    }
  }

  func getDecodedObject() -> [Lorem]? {
    let bundle = Bundle(for: LoremsTests.self)
    guard
      let path = bundle.path(forResource: "LoremsTests_200", ofType: "json")
    else {
      return nil
    }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path))
      let result = try JSONDecoder().decode([Lorem].self, from: data)
      return result
    } catch {
      return nil
    }
  }
}
