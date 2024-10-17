//
//  SwiftData.swift
//  Basics
//
//  Created by Roman Golub on 17.10.2024.
//

import Foundation
import SwiftData

// Для SwiftData обозначаем макросом модель, создаем класс с данными которые нужно
@Model
final class Student {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

// В корневом файле import SwiftData, и после WindowGroup сообщаем где хранится модель данных, чтоб мы могли где угодно иметь доступ к данным..
/*
    WindowGroyp {
         ContentView()
      }
      .modelContainer(for: Student.self)
 */

// вызываем модель данных где нам нужно
// @Query var students: [Student] - запрашиваем модель в SwiftData, работает на подобе @State
// имеет разные функции по сортировке, фильтрации, анимации
// так же вызовем контекст модели в структуре которую будем использовать
// @Environment(\.modelContext) var modelContext
// modelContext.insert() - добавляем в модель что нужно
