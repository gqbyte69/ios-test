// 
//  LoremsTests.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

import Quick
import Nimble

@testable import CatchTest

class LoremsTests: QuickSpec, EndpointResponseSpec {
  override func spec() {
    describe("Lorems") {
      var apiResponse: APIResponse!
      var data: Lorem!
      
      afterEach {
        apiResponse = nil
        data = nil
      }
      
      context("when decoding status 200 response") {
        beforeEach {
          apiResponse = self.decodeResponseValue(statusCode: .ok)
        }
        
        it("should have non-nil decoded response") {
          expect(apiResponse).toNot(beNil())
        }
        
        it("should have 200 status code") {
          data = apiResponse.decodedValue()
          
          expect(data).toNot(beNil())
        }
      }
    }
  }
}
