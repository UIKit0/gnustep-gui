/** <title>NSFontDescriptor</title>

   <abstract>The font descriptor class</abstract>

   Copyright (C) 2007 Free Software Foundation, Inc.

   Author: H. Nikolaus Schaller <hns@computer.org>
   Date: 2006
   Extracted from NSFont: Fred Kiefer <fredkiefer@gmx.de>
   Date August 2007

   This file is part of the GNUstep GUI Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; see the file COPYING.LIB.
   If not, write to the Free Software Foundation,
   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
*/ 
#include "config.h"
#include <Foundation/NSArray.h>
#include <Foundation/NSCoder.h>
#include <Foundation/NSDictionary.h>
#include <Foundation/NSEnumerator.h>
#include <Foundation/NSString.h>
#include <Foundation/NSValue.h>

#include "AppKit/NSAffineTransform.h"
#include "AppKit/NSFontDescriptor.h"

@implementation NSFontDescriptor

+ (id) fontDescriptorWithFontAttributes: (NSDictionary *)attributes
{
  return AUTORELEASE([[self alloc] initWithFontAttributes: attributes]);
}

+ (id) fontDescriptorWithName: (NSString *)name
		       matrix: (NSAffineTransform *)matrix
{
  return [self fontDescriptorWithFontAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
      name, NSFontNameAttribute,
      matrix, NSFontMatrixAttribute,
      nil]];
}

+ (id) fontDescriptorWithName: (NSString *)name size: (float)size
{
  return [self fontDescriptorWithFontAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
      name, NSFontNameAttribute,
      [NSString stringWithFormat: @"%f", size], NSFontSizeAttribute,
      nil]];
}

- (NSDictionary *) fontAttributes
{
  return _attributes;
}

- (NSFontDescriptor *) fontDescriptorByAddingAttributes:
  (NSDictionary *)attributes
{
  NSMutableDictionary	*m = [_attributes mutableCopy];

  [m addEntriesFromDictionary: attributes];

  return [isa fontDescriptorWithFontAttributes: m] ;
}

- (NSFontDescriptor *) fontDescriptorWithFace: (NSString *)face
{
  return [self fontDescriptorByAddingAttributes:
    [NSDictionary dictionaryWithObject: face forKey: NSFontFaceAttribute]];
}

- (NSFontDescriptor *) fontDescriptorWithFamily: (NSString *)family
{
  return [self fontDescriptorByAddingAttributes:
    [NSDictionary dictionaryWithObject: family forKey: NSFontFamilyAttribute]];
}

- (NSFontDescriptor *) fontDescriptorWithMatrix: (NSAffineTransform *)matrix
{
  return [self fontDescriptorByAddingAttributes:
    [NSDictionary dictionaryWithObject: matrix forKey: NSFontMatrixAttribute]];
}

- (NSFontDescriptor *) fontDescriptorWithSize: (float)size
{
  return [self fontDescriptorByAddingAttributes:
    [NSDictionary dictionaryWithObject: [NSNumber numberWithFloat: size]
				forKey: NSFontSizeAttribute]];
}

- (NSFontDescriptor *) fontDescriptorWithSymbolicTraits:
  (NSFontSymbolicTraits)traits
{
  return [self fontDescriptorByAddingAttributes:
    [NSDictionary dictionaryWithObject: [NSNumber numberWithUnsignedInt: traits]
				forKey: NSFontSymbolicTrait]];
}

- (id) initWithFontAttributes: (NSDictionary *) attributes
{
  if ((self = [super init]) != nil)
    {
      if (attributes)
        _attributes = [attributes copy];
      else
        _attributes = [NSDictionary new];
    }
  return self;
}

- (void) encodeWithCoder: (NSCoder *)aCoder
{
  if ([aCoder allowsKeyedCoding])
    {
      [aCoder encodeObject: _attributes forKey: @"NSAttributes"];
    }
  else
    {
      // FIXME
    }
}

- (id) initWithCoder: (NSCoder *)aDecoder
{
  if ([aDecoder allowsKeyedCoding])
    {
      _attributes = RETAIN([aDecoder decodeObjectForKey: @"NSAttributes"]);
    }
  else
    {
      // FIXME
    }
  return self;
}
	
- (void) dealloc;
{
  RELEASE(_attributes);
  [super dealloc];
}

- (id) copyWithZone: (NSZone *)z
{
  NSFontDescriptor *f = [isa allocWithZone: z];

  if (f != nil)
    {
      f->_attributes = [_attributes copyWithZone: z];
    }
  return f;
}

// this is the core font search engine that knows about font directories
- (NSArray *) matchingFontDescriptorsWithMandatoryKeys: (NSSet *)keys
{
  NSMutableArray *found;
  NSEnumerator *fdEnumerator;
  NSFontDescriptor *fd;

  found = [NSMutableArray arrayWithCapacity: 3];
  // FIXME: Get an enumerator for all available font descriptors
  fdEnumerator = nil;
  while ((fd = [fdEnumerator nextObject]) != nil)
    {
        NSEnumerator *keyEnumerator;
        NSString *key;
        BOOL match = YES;

        keyEnumerator = [keys objectEnumerator];
        while ((key = [keyEnumerator nextObject]) != nil)
          {
            id value = [self objectForKey: key];

            if (value != nil)
              {
                if (![value isEqual: [fd objectForKey: key]])
                  {
                    match = NO;
                    break;
                  }
              }
          }

        if (match)
          {
            [found addObject: fd];
          }
    }

  return found;
}


- (NSAffineTransform *) matrix
{
  return [_attributes objectForKey: NSFontMatrixAttribute];
}

- (id) objectForKey: (NSString *)attribute
{
  return [_attributes objectForKey: attribute];
}

- (float) pointSize
{
  id size = [_attributes objectForKey: NSFontSizeAttribute];

  if (size)
    {
      return [size floatValue];
    }
  else
    {
      return 0.0;
    }
}

- (NSFontSymbolicTraits) symbolicTraits
{
  return [[_attributes objectForKey: NSFontSymbolicTrait] unsignedIntValue];
}

- (NSString *) postscriptName
{
  NSMutableString	*family;
  NSString *face;

  family = AUTORELEASE([[self objectForKey: NSFontFamilyAttribute] mutableCopy]);
  face = [self objectForKey: NSFontFaceAttribute];
  [family replaceOccurrencesOfString: @" "
          withString: @""
          options: 0
          range: NSMakeRange(0, [family length])];
  if ([face isEqualToString: @"Regular"])
    return family;
  return [NSString stringWithFormat: @"%@-%@", family, face];
}

@end