//
//  PosterOperations.swift
//  OMDb-client
//
//  Created by Robin Douglas on 15/05/2019.
//  Copyright © 2019 Robin Douglas. All rights reserved.
//

import UIKit

enum PosterCache {

    static let main = NSCache<NSString, PosterRecord>()

    static func getRecord(for address: String) -> PosterRecord {
        if let record = main.object(forKey: address as NSString) {
            return record
        }
        let record = PosterRecord(address: address)
        addRecord(record)
        return record
    }

    static func addRecord(_ record: PosterRecord) {
        main.setObject(record, forKey: record.address as NSString)
    }

}

class PosterRecord {

    enum DownloadState {
        case start
        case done
        case error
    }

    var image: UIImage?
    var address: String
    var downloadState: DownloadState = .start

    init(address: String) {
        self.address = address
    }

}

class PendingOperations {

    lazy var downloadsInProgress: [IndexPath: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageDownloads"
        return queue
    }()

}

class PosterDownloadOperation: Operation {

    let record: PosterRecord

    init(_ record: PosterRecord) {
        self.record = record
    }

    override func main() {
        if isCancelled { return }
        guard let url = URL(string: record.address), !isCancelled else { return }
        do {
            let imageData = try Data(contentsOf: url)
            guard !imageData.isEmpty && !isCancelled else { return }
            record.image = UIImage(data: imageData)
            if isCancelled { return }
            record.downloadState = .done
        } catch {
            record.downloadState = .error
        }
    }

}
