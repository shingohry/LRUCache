//
//  Node.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class Node<T> {
    var prev: Node?
    var next: Node?
    var value: T

    init(value: T) {
        self.value = value
    }
}
