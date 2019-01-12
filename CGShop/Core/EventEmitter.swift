//
//  EventEmitter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

class EventEmitter {
    private var _events = Dictionary<String, Event>()
    private var eventsCount: Int = 0
    
    func on(eventName: String, fn: @escaping (() -> ())) -> Void {
        let eventFn = Event(fn: fn);
        
        addListener(eventName: eventName, event: eventFn)
    }
    
    private func addListener(eventName: String, event: Event) {
        _events[eventName] = event
    }
    
    func emit(eventName: String) -> Void {
        if let event = self._events[eventName] {
            if let methodToCall = event.fn {
                methodToCall();
            }
        }
    }
}

class Event {
    let fn: (() -> ())?
    
    init(fn: @escaping (() -> ())) {
        self.fn = fn
    }
}
