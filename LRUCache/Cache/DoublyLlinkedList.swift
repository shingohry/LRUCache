//
//  DoublyLlinkedList.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class DoublyLlinkedList<T, Key: Hashable> {
    var head: Node<T, Key>?
    var tail: Node<T, Key>?
    var size = 0
}
