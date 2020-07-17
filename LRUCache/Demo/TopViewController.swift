//
//  ViewController.swift
//  LRUCache
//
//  Created by Shingo Hiraya on 2020/07/16.
//  Copyright © 2020 Shingo Hiraya. All rights reserved.
//

import UIKit

class TopViewController: UITableViewController {
    let cache = LRUCache<UIImage, Int>()
    let dataList = Array(1...11)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Cache Count: \(cache.count)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let controller = segue.destination as? DetailViewController {
            print("indexPath.row:\(indexPath.row)")
            controller.data = dataList[indexPath.row]
            controller.cache = cache
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(dataList[indexPath.row])
        return cell
    }
}
