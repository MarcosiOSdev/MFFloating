//Copyright (c) 2022 Marcos Felipe Souza
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
//  MovingView.swift
//
//  Created by marcos.felipe.souza on 09/05/22.
//

import UIKit

/// MFFloatingView é a classe que irá ter o controle sobre o Floating View.
public class MFFloatingView {
    
    // MARK: - Storage Properties
    private(set) var floatingWindow: MFFloatingWindow = MFFloatingWindow(frame: UIScreen.main.bounds)
    private(set) var containerView: UIView
    private(set) var containerController: MFFloatingViewContainerController
    private(set) var rootViewController: UIViewController
    
    //MARK: - Configs Var.
    private(set) var wasConfigure = false
    private(set) var isShowing = false
    
    //MARK: - Inits
    
    /// MFFloatingView é a classe que irá ter o controle sobre o Floating View.
    /// - Parameters:
    ///     - rootViewController: `ViewController` que terá como sessão. Aconselhavel colocar a root do projeto.
    ///     - containerView: O contéudo que irá ficar realizando o floating view.
    ///     - appWindow: (Opcional) Para o Moving View ficar com a mesma config da UIWindows da app, como, StatusBar e etc.
    ///
    public init(
        rootViewController: UIViewController,
        containerView: UIView,
        appWindow: UIWindow? = nil
    ) {
        self.containerView = containerView
        self.rootViewController = rootViewController
        containerController = MFFloatingViewContainerController(containerView: containerView, appWindow: appWindow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Publics Funcs
    public func show() {
        setupWindows()
        if self.isShowing { return }
        floatingWindow.addSubview(containerView)
        self.isShowing = true
        floatingWindow.isHidden = false
    }
    
    public func hide() {        
        self.isShowing = false
        floatingWindow.isHidden = true
    }
    
    public func changeView(for newContainer: UIView) {
        containerView = newContainer
        containerController.changeContainer(newContainer)
    }
    
    // MARK: - Setups    
    private func setupWindows() {
        guard !wasConfigure else { return }
        floatingWindow.rootViewController = containerController
        floatingWindow.makeKeyAndVisible()
        wasConfigure = true
    }
}
