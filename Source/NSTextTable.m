/* NSTextTable.m

   Copyright (C) 2008 Free Software Foundation, Inc.

   Author:  H. Nikolaus Schaller
   Date: 2007
   Author:  Fred Kiefer <fredkiefer@gmx.de>
   Date: January 2008
   
   This file is part of the GNUstep GUI Library.

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 3 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; see the file COPYING.LIB.
   If not, see <http://www.gnu.org/licenses/> or write to the 
   Free Software Foundation, 51 Franklin Street, Fifth Floor, 
   Boston, MA 02110-1301, USA.
*/

#include <Foundation/NSCoder.h>
#include <Foundation/NSString.h>

#include "AppKit/NSTextTable.h"

@implementation NSTextTable

- (BOOL) collapsesBorders
{
  return _collapsesBorders;
}

- (void) setCollapsesBorders: (BOOL)flag
{
  _collapsesBorders = flag;
}

- (BOOL) hidesEmptyCells
{
  return _hidesEmptyCells;
}

- (void) setHidesEmptyCells: (BOOL)flag
{
  _hidesEmptyCells = flag;
}

- (NSTextTableLayoutAlgorithm) layoutAlgorithm
{
  return _layoutAlgorithm;
}

- (void) setLayoutAlgorithm: (NSTextTableLayoutAlgorithm)algorithm
{
  _layoutAlgorithm = algorithm;
}

- (unsigned int) numberOfColumns
{
  return _numberOfColumns;
}

- (void) setNumberOfColumns: (unsigned int)numCols
{
  _numberOfColumns = numCols;
}

- (NSRect) boundsRectForBlock: (NSTextTableBlock *)block
                  contentRect: (NSRect)content
                       inRect: (NSRect)rect
                textContainer: (NSTextContainer *)container
               characterRange: (NSRange)range
{
  // FIXME
  return NSZeroRect;
}

- (NSRect) rectForBlock: (NSTextTableBlock *)block
          layoutAtPoint: (NSPoint)start
                 inRect: (NSRect)rect
          textContainer: (NSTextContainer *)container
         characterRange: (NSRange)range
{
  // FIXME
  return NSZeroRect;
}

- (void) drawBackgroundForBlock: (NSTextTableBlock *)block
                      withFrame: (NSRect)frame
                         inView: (NSView *)controlView
                 characterRange: (NSRange)range
                  layoutManager: (NSLayoutManager *)manager
{
  // FIXME
}

@end
