// Copyright (c) 2022 Marcos Felipe Souza
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
//  MFFloatingViewTests.swift
//  
//
//  Created by marcos.felipe.souza on 10/05/22.
//

import XCTest
@testable import MFFloating

class MFFloatingViewTests: XCTestCase {

    func test_init_default() throws {
        let sut = makeSut()
        XCTAssertNotNil(sut.containerView)
        XCTAssertNotNil(sut.rootViewController)
        XCTAssertNotNil(sut.floatingWindow)
        XCTAssertNotNil(sut.containerController)
    }
    
    func test_hide_floating_view() throws {
        let sut = makeSut()
        sut.hide()
        XCTAssertFalse(sut.isShowing)
        XCTAssertTrue(sut.floatingWindow.isHidden)
    }
    
    func test_show_floating_view() throws {
        let sut = makeSut()
        
        sut.show()
        
        XCTAssertTrue(sut.isShowing)
        XCTAssertTrue(sut.wasConfigure)
    }
    
    func test_change_view() throws {
        let sut = makeSut()
        let view = UIView(frame: .zero)
        view.accessibilityIdentifier = "test"
        
        sut.show()
        sut.changeView(for: view)
        
        XCTAssertEqual(sut.containerView.accessibilityIdentifier, "test")
    }
}

extension MFFloatingViewTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> MFFloatingView {
        let sut = MFFloatingView(rootViewController: UIViewController(), containerView: UIView())
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject,
                         file: StaticString = #filePath,
                         line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
