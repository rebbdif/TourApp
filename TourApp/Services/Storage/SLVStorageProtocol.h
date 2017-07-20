//
//  SLVStorageProtocol.h
//  flickrgram
//
//  Created by 1 on 18.06.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

typedef void (^voidBlock)(void);

@protocol SLVStorageProtocol <NSObject>

- (id)fetchEntity:(NSString *)entity forKey:(NSString *)key;

- (NSArray *)fetchEntities:(NSString *)entity withPredicate:(NSPredicate *)predicate;

/**
 Сохраняет изменения главного контекста
 */
- (void)save;

/**
 
 @return возвращает главный контекст
 */
- (NSManagedObjectContext *)mainContext;

@end
