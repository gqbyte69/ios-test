//
//  Closures.swift
//  CatchTest
//
//  Created by Adonis Dumadapat on 6/22/22.
//

import Foundation

typealias EmptyResult<ReturnType> = () -> ReturnType

typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)

typealias SingleResult<T> = SingleResultWithReturn<T, Void>

typealias VoidResult = EmptyResult<Void>
typealias ErrorResult = SingleResult<Error>
