//
//  LoremsServiceTests.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/23/22.
//

import Foundation

import Nimble
import Quick

@testable import CatchTest

class LoremsServiceTests: QuickSpec {
  override func spec() {
    describe("LoremsService") {
      var sut: LoremsService!
      var api: MockLoremsAPI!

      beforeEach {
        api = MockLoremsAPI()
        sut = LoremsService(
          api: api
        )
      }

      afterEach {
        api = nil
        sut = nil
      }

      it("should pass correct params and call api.someFunc once on someFunc") {
        expect(api.getLoremsCallCount).to(equal(0))

        sut.fetchLorems(
          onSuccess: DefaultClosure.singleResult(),
          onError: DefaultClosure.singleResult()
        )

        expect(api.getLoremsCallCount).to(equal(1))
      }

      context("when initialized with successful api") {
        beforeEach {
          api.errorToReturn = nil
        }

        it("should call onSuccess closure once on someFunc") {
          var onSuccessCallCount = 0

          sut.fetchLorems(
            onSuccess: { _ in onSuccessCallCount += 1 },
            onError: DefaultClosure.singleResult()
          )

          expect(onSuccessCallCount).toEventually(equal(1))
        }
      }

      context("when initialized with failing api") {
        var apiError: Error!

        beforeEach {
          apiError = NSError(domain: #function, code: 1, userInfo: nil)
          api.errorToReturn = apiError
        }

        afterEach {
          apiError = nil
        }

        it("should return apiError and call onError closure once on fetchLorems") {
          var passedError: Error?
          var onErrorCallCount = 0

          sut.fetchLorems(
            onSuccess: DefaultClosure.singleResult(),
            onError: {
              passedError = $0
              onErrorCallCount += 1
            }
          )

          expect(passedError).toEventually(be(apiError.self))
          expect(onErrorCallCount).toEventually(equal(1))
        }
      }
    }
  }
}
