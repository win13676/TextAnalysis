//
//  CountingDictionary.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/6/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import Foundation

class CountingDictionary<T: Hashable>: NSObject {

    private(set) var dict: [T: Int] = [:]

    func addCountToKey(key: T, numCount: Int) {
        if let value = dict[key] {
            dict[key] = value + numCount
        } else {
            dict[key] = numCount
        }
    }

    func addCountToKey(key: T) {
        addCountToKey(key, numCount: 1)
    }

    func combineWithDict(otherDict: CountingDictionary<T>) {
        for (key, count) in otherDict.dict {
            addCountToKey(key, numCount: count)
        }
    }

    override var description: String {
        return dict.description
    }

}