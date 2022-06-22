//
//  EndpointResponseSpec.swift
//  CatchTestTests
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

import Quick

@testable import CatchTest

protocol EndpointResponseSpec {
  var cleanSpecName: String { get }

  func decodeResponseValue<T: Decodable>(
    statusCode: HTTPStatusCode,
    exampleNumber: Int?
  ) -> T?
}

extension EndpointResponseSpec where Self: XCTestCase {
  var cleanSpecName: String {
    // FROM: -[APIResponseTests (null)]
    // TO: APIResponseTests
    let ss = name.split(separator: " ").first!.replacingOccurrences(of: "-[", with: "")
    return String(ss)
  }

  func decodeResponseValue<T: Decodable>(
    statusCode: HTTPStatusCode,
    exampleNumber: Int? = nil
  ) -> T? {
    var jsonFile = "\(cleanSpecName)_\(statusCode.rawValue)"

    if let en = exampleNumber {
      jsonFile += "_\(en)"
    }

    // APIResponseTests_200.json
    // APIResponseTests_422_1.json
    // APIResponseTests_422_2.json

    var decoder = GenericAPIModel.decoder()
    if T.self == APIResponse.self {
      decoder = JSONDecoder()
    }

    return APIReponseGenerator.modelResponse(
      from: jsonFile,
      spec: self,
      decoder: decoder
    )
  }
}
