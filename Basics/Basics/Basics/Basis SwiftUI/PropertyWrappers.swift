//
//  PropertyWrappers.swift
//  Basics
//
//  Created by Roman Golub on 14.10.2024.
//

import SwiftUI

/*
 для struct
 @State -  используется при взаимодействии с интерфейсом, должно быть приватным
 $ - binding - связь в 2 стороны
 @Binding - данное свойство должно зависит от родительского представления, является ссылкой на другую переменную
 */

    /*
    
   для class
     @EnvironmentObject - можно сравнить с Binding свойством, определяет зависимость от свойст с оберткой StateObject, можно передавать на прямую без посредников
     
     
     @StateObject - обладают постоянством, когда обьект перерисовывается, остается постоянным
     определеят зависимость от class которые подписаны под @ObservableObject протокол
     по сути сингелтон от класса
     @ObservedObject - cоздается вместе с видом, не обладает постоянством, когда обьект перерисовывается, он тоже обновляется..
     
     Создаем @StateObject с инициализацией, в последующих дочерних View создаем @ObservedObject без инициализации
     
     
     @ObservableObject -
     @Published -
     */


/*
 Создаем класс и подписываем под протокол @ObservableObject
 class DataModel: ObservableObject {
 
 }
 
 В главном представлении создаем @StateObject
 @StateObject private var model = DataModel() с инициализацией
 
            SomeView()
                .enviromentObject(model) - передаем экземпляр в то место куда нужно..
 
 в SomeView() обьявляем @EnvironmentObject var model: DataModel - уже без инициализации, так как мы сделали это в главном представлении..
 */
