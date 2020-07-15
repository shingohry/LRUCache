//
//  Node.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class Node<T, Key: Hashable> {
    var prev: Node?
    var next: Node?
    var value: T
    var key: Key

    init(value: T, key: Key) {
        self.value = value
        self.key = key
    }
}
