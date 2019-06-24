//
//  GFunctionalGuidanceViewUITests.m
//  GFunctionalGuidanceViewUITests
//
//  Created by Caoguo on 2018/6/11.
//  Copyright © 2018年 Caoguo. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GFunctionalGuidanceViewUITests : XCTestCase

@end

@implementation GFunctionalGuidanceViewUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    XCUIElementQuery *tablesQuery = [[XCUIApplication alloc] init].tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Follow slide"]/*[[".cells.staticTexts[@\"Follow slide\"]",".staticTexts[@\"Follow slide\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *leftButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons[@"Left"]/*[[".cells.buttons[@\"Left\"]",".buttons[@\"Left\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [leftButton tap];
    [leftButton tap];
    [leftButton tap];
    [leftButton tap];
    
    XCUIElement *bottomButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons[@"Bottom"]/*[[".cells.buttons[@\"Bottom\"]",".buttons[@\"Bottom\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [bottomButton tap];
    [bottomButton tap];
    [bottomButton swipeUp];
    [tablesQuery/*@START_MENU_TOKEN@*/.buttons[@"Right"]/*[[".cells.buttons[@\"Right\"]",".buttons[@\"Right\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    [self testGuideVC];
}

- (void)testGuideVC {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"Next ViewController"]/*[[".cells.staticTexts[@\"Next ViewController\"]",".staticTexts[@\"Next ViewController\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [app.buttons[@"Show Guide"] tap];
    [app.buttons[@"SKIP"] tap];
    
}




@end
