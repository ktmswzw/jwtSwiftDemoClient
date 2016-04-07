//
//  TempTests.swift
//  TempTests
//
//  Created by vincent on 7/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//
import JWT
import XCTest
class TempTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let jwt = JWT.encode(.HS256("secret")) { builder in
            builder.issuer = "fuller.li"
            builder.audience = "123123"
            builder["custom"] = "Hi"
        }
        print("\(jwt)")
    }
    
    func testDecode() {
        do {
            let payload = try JWT.decode("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJmdWxsZXIubGkiLCJhdWQiOiIxMjMxMjMiLCJvb29vb28iOiIxMTExMTExMTExMTExIn0.K00sztVpajtv3rKBr-4uJzTnG2RHLeM0vkpI7RKBblg", algorithm: .HS256("secret"))
            print(payload)
        } catch {
            print("Failed to decode JWT: \(error)")
        }
    }
    
    
}
