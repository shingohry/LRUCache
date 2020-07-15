//
//  LRUCache.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class LRUCache<T: Equatable, Key: Hashable> {
    private var list = DoublyLinkedList<T, Key>()
    private var map = [Key: Node<T, Key>]()
    private let maxSize = 10

    subscript(key: Key) -> T? {
        get {
            return get(key: key)
        }
        set {
            guard let value = newValue else { return }
            set(key: key, value: value)
        }
    }
}

private extension LRUCache {
    // 値を返す
    func get(key: Key) -> T? {
        guard let node = map[key] else { return nil }

        // Nodeを先頭に移動し、値を返す
        moveToHead(node: node)
        return node.value
    }

    // 値を保存する
    func set(key: Key, value: T) {
        if let node = map[key] {
            // キャッシュされている場合は値を書き換えて、Nodeを先頭に移動する
            node.value = value
            moveToHead(node: node)
            return
        }

        if list.size == maxSize {
            // キャッシュが満杯の場合は末尾のNodeを削除する
            removeLast()
        }

        // Nodeを先頭に追加する
        let node = Node(value: value, key: key)
        insertToHead(node: node)
    }

    // Nodeを先頭に移動する
    func moveToHead(node: Node<T, Key>) {
        remove(node: node)
        insertToHead(node: node)
    }

    // 末尾のNodeを削除する
    func removeLast() {
        guard let tail = list.tail else { return }
        remove(node: tail)
    }

    // Nodeを削除する
    func remove(node: Node<T, Key>) {
        if node == list.tail {
            list.tail = list.tail?.prev
        }
        node.prev?.next = node.next
        node.next?.prev = node.prev
        list.size -= 1
        map[node.key] = nil
        print(#function, "remove node for \(node.key)")
    }

    // 先頭にNodeを追加する
    func insertToHead(node: Node<T, Key>) {
        node.next = list.head
        list.head?.prev = node
        list.head = node
        list.size += 1
        map[node.key] = node
        print(#function, "insert to head node for \(node.key)")
    }
}