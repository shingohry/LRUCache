//
//  LRUCacheTests.swift
//  LRUCacheTests
//
//  Created by Shingo Hiraya on 2020/07/18.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import XCTest

@testable import LRUCache

class LRUCacheTests: XCTestCase {
    func testCache() {
        XCTContext.runActivity(named: "キャッシュに値が格納されていない場合") { _ in
            let cache = LRUCache<String, Int>()
            XCTAssertNil(cache[1], "キー1に対する値がnilになること")
        }

        XCTContext.runActivity(named: "キャッシュに値を格納されている場合") { _ in
            let cache = LRUCache<String, Int>()
            cache[1] = String(1)
            XCTAssertEqual(cache[1], String(1), "キー1に対する値をキャッシュから値を取得できること")
            XCTAssertEqual(cache.count, 1, "キャッシュのサイズが1になること")
        }

        XCTContext.runActivity(named: "キー1から11まで順番にキャッシュに値を格納し、キャッシュが満杯になる場合(途中でキー10に対する値を確認する)") { _ in
            let cache = LRUCache<String, Int>()

            // キー1から10に対する値をcacheに格納する
            for i in 1...10 {
                cache[i] = String(i)
            }

            XCTAssertEqual(cache.count, 10, "キャッシュのサイズが10になること")

            // キー10に対する値を確認する
            XCTAssertEqual(cache[10], String(10), "キー10に対する値をキャッシュから取得できること")

            // 追加で、キー11と値をcacheに格納する(最も昔にアクセスしたキー1に対する値がcacheから削除される)
            cache[11] = String(11)

            XCTAssertNil(cache[1], "キー1に対する値をキャッシュから取得できないこと")
            XCTAssertEqual(cache[2], String(2), "キー2に対する値をキャッシュから取得できること")
            XCTAssertEqual(cache[11], String(11), "キー11に対する値をキャッシュから取得できること")
            XCTAssertEqual(cache.count, 10, "キャッシュのサイズが10になること")
        }

        XCTContext.runActivity(named: "キー1から11まで順番にキャッシュに値を格納し、キャッシュが満杯になる場合(途中でキー1に対する値を確認する)") { _ in
            let cache = LRUCache<String, Int>()

            // キー1から10に対する値をcacheに格納する
            for i in 1...10 {
                cache[i] = String(i)
            }

            XCTAssertEqual(cache.count, 10, "キャッシュのサイズが10になること")

            // キー1に対する値を確認する
            XCTAssertEqual(cache[1], String(1), "キー1に対する値をキャッシュから取得できること")

            // 追加で、キー11と値をcacheに格納する(最も昔にアクセスしたキー2に対する値がcacheから削除される)
            cache[11] = String(11)

            XCTAssertNil(cache[2], "キー2に対する値をキャッシュから取得できないこと")
            XCTAssertEqual(cache[1], String(1), "キー1に対する値をキャッシュから取得できること")
            XCTAssertEqual(cache[11], String(11), "キー11に対する値をキャッシュから取得できること")
            XCTAssertEqual(cache.count, 10, "キャッシュのサイズが10になること")
        }
    }
}
