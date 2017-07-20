//
//  SLVNetworkDelegate.h
//  Bolt
//
//  Created by 1 on 13.06.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLVNetworkProtocol <NSObject>

/**
 Загружает json с URL сайта и парсит его

 @param url url, с которого идет загрузка
 @param completionBlock замыкание с полученным словарем в качестве параметра
 */
- (void)getDictionaryFromURL:(NSURL *)url withCompletionBlock:(void (^)(NSDictionary * data))completionBlock;

@end
