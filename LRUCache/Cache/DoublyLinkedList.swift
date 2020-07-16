//
//  DoublyLinkedList.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class DoublyLinkedList<T: Equatable, Key: Hashable> {
    var head: Node<T, Key>?
    var tail: Node<T, Key>?
}
