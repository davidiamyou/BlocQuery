//
//  ParseErrorHandler.m
//  BlocQuery
//
//  Created by Weinan Qiu on 2015-10-13.
//  Copyright © 2015 Kumiq. All rights reserved.
//

#import "ParseErrorHandler.h"
#import <GRMustache/GRMustache.h>

@interface ParseErrorHandler ()

@property (nonatomic, strong) NSDictionary *mapping;

@end

@implementation ParseErrorHandler

+ (instancetype) handler {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[ParseErrorHandler alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Error" ofType:@"plist"];
        NSDictionary *errorDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _mapping = errorDictionary[PFParseErrorDomain];
    }
    return self;
}

- (BOOL)handlesDomain:(NSString *)errorDomain {
    return [errorDomain isEqualToString:PFParseErrorDomain];
}

- (NSDictionary *)resolveUserInfoForError:(NSError *)parseError inContext:(NSString *)context withParams:(NSDictionary *)params {
    NSDictionary *errorDict = self.mapping[[NSString stringWithFormat:@"%d:%@", parseError.code, context ? context : @"*"]];
    if (errorDict) {
        NSString *recovery = [GRMustacheTemplate renderObject:params fromString:NSLocalizedString(errorDict[@"recovery"], nil) error:nil];
        return @{
                 NSLocalizedDescriptionKey: NSLocalizedString(errorDict[@"description"], nil),
                 NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorDict[@"reason"], nil),
                 NSLocalizedRecoverySuggestionErrorKey: recovery
                 };
    } else {
        return [NSError defaultErrorUserInfo];
    }
}

@end
