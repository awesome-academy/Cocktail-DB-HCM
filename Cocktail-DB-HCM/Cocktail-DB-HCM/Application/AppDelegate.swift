//
//  AppDelegate.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 12/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assembler: Assembler = DefaultAssembler()
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        bindViewModel(window: window)
        return true
    }
}

extension AppDelegate {
    func bindViewModel(window: UIWindow) {
        let viewModel: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        _ = viewModel.transform(input: input, disposeBag: disposeBag)
    }
}
