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
//  MFFloatingViewContainerController.swift
//
//  Created by marcos.felipe.souza on 09/05/22.
//

import UIKit

final class MFFloatingViewContainerController: UIViewController {

    // MARK: - Orientação do cliente.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let appTopViewController = UIApplication.topViewController(base: appWindow?.rootViewController)
        return appTopViewController?.supportedInterfaceOrientations ?? .all
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        let appTopViewController = UIApplication.topViewController(base: appWindow?.rootViewController)
        return appTopViewController?.prefersHomeIndicatorAutoHidden ?? false
    }

    override var prefersStatusBarHidden: Bool {
        let appTopViewController = UIApplication.topViewController(base: appWindow?.rootViewController)
        return appTopViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let appTopViewController = UIApplication.topViewController(base: appWindow?.rootViewController)
        return appTopViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    // MARK: - Storage Properties
    private var appWindow: UIWindow?
    private var containerView: UIView
    
    //MARK: - Create UIs
    private var containerStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 8
        stackview.distribution = .fill
        stackview.isUserInteractionEnabled = true
        return stackview
    }()
    
    //MARK: - Init
    init(
        containerView: UIView,
        appWindow: UIWindow? = nil
    ) {
        self.containerView = containerView
        self.appWindow = appWindow
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()

        let untouchbaleView = UntouchableView()
        untouchbaleView.backgroundColor = .clear

        view = untouchbaleView
        view.addSubview(containerStackview)
        setupContainer()
    }
    
    //MARK: - Events
    @objc
    private func didMovingView(_ gesture: UIPanGestureRecognizer) {
        guard let moveView = gesture.view else { return }
        let point = gesture.translation(in: view)
        moveView.center = CGPoint(x: moveView.center.x + point.x, y: moveView.center.y + point.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    // MARK: -  Seutps
    private func setupContainer() {
        containerStackview.addSubview(containerView)
        containerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didMovingView(_:))))
    }
    
    // MARK: - Publics funcs
    func changeContainer(_ newContainer: UIView) {
        containerStackview.removeArrangedSubview(containerView)
        containerView.removeFromSuperview()
        containerView = newContainer
        setupContainer()
        view.layoutIfNeeded()
    }
}
