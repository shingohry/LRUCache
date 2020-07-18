//
//  LRUCache.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import Foundation

class LRUCache<T: Equatable, Key: Hashable> {
    // # 空間計算量
    // - O(1) (最大要素数が固定なので。要素数が可変で数がkだとすると、o(k)。DictionaryとDoublyLinkedListのメモリ使用量は要素数に比例する)
    //
    // # 時間計算量
    // - get: O(1) (Dictionaryから値をO(1)で取得できるので)
    // - set: O(1) (値の書き換え、削除、追加がO(1)でできるので)

    private var list = DoublyLinkedList<T, Key>()
    private var map = [Key: Node<T, Key>]()
    private let maxCount = 10

    var count: Int {
        return map.count
    }

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

        if map.count == maxCount {
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
        map[node.key] = nil
        print(#function, "remove node for \(node.key), map.count: \(map.count)")
    }

    // 先頭にNodeを追加する
    func insertToHead(node: Node<T, Key>) {
        node.next = list.head
        list.head?.prev = node
        list.head = node
        map[node.key] = node

        if list.tail == nil {
            list.tail = list.head
        }

        print(#function, "insert to head node for \(node.key), map.count: \(map.count)")
    }
}
