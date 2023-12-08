//
//  KeepRunningThread.swift
//  KeepRunningThread
//
//  Created by 丁燕军 on 2023/12/8.
//

import Foundation

class KeepRunningThread: NSObject {
    
    typealias ThreadTask = @convention(block) () -> Void
    
    private var innerThread: Thread?
    private var shouldKeepRunning = false
    
    func start() {
        stop()
        innerThread = Thread(block: { [weak self] in
            RunLoop.current.add(Port(), forMode: .default)
            while((self?.shouldKeepRunning ?? false) && RunLoop.current.run(mode: .default, before: .distantFuture)) {}
        })
        shouldKeepRunning = true
        innerThread?.start()
    }
    
    func execute(_ task: @escaping ThreadTask) {
        guard let innerThread else { return }
        perform(#selector(_execute), on: innerThread, with: task, waitUntilDone: true)
    }
    
    func stop() {
        guard let innerThread else { return }
        perform(#selector(_stop), on: innerThread, with: nil, waitUntilDone: true)
    }
    
    deinit {
        stop()
        debugPrint("KeepRunningThread", #function)
    }
    
    @objc private func _execute(_ task: ThreadTask) {
        task()
    }
    
    @objc private func _stop() {
        shouldKeepRunning = false
        CFRunLoopStop(CFRunLoopGetCurrent())
        innerThread = nil
    }
}
