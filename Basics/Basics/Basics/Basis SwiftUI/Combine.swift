//
//  Combine.swift
//  Basics
//
//  Created by Roman Golub on 14.10.2024.
//

import Foundation
import Combine
/*
 Максимально реализовываеться в MVVM
 */

class TimeCounter: ObservableObject {
    var objectWillChange = PassthroughSubject<TimeCounter, Never>()
    // objectWillChange так называемый Publisher, издатель, может уведомлять своих подписчиков, экземпляоов класса с оберткой StateObject об измененниях состояния PassthroughSubject - универсальный паблишер
    var counter = 3
    var timer: Timer?
    
    func starTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func updateCounter() {
        if counter > 0 {
            counter -= 1
        } else {
            killTimer()
        }
        
        objectWillChange.send(self)
        // Отправляет обновленное состояния таймера свои экземплярам, подписчикам
    }
    
    private func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
