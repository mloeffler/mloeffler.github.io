*! version 0.1, 02oct2014, Max Löffler <loeffler@zew.de>
/**
 * CAPASS - WRAPPER FOR STATA'S ASSERT COMMAND, THROWS ERROR MESSAGES
 * 
 * Checks if assertion evaluates to false and, if so, throws an error message.
 * This is somehow related to common try-catch exception handling constructs.
 *
 * @author Max Löffler <loeffler@zew.de>
 * @param `0'     Pass thru for assertion to verify
 * @param `throw' Error message to be shown when assertion is false
 * @param `rc0'   Pass thru for assert's option `rc0'
 * @param `null'  Pass thru for assert's option `null'
 * @param `fast'  Pass thru for assert's option `fast'
 * 
 * 2014-10-02   Initial version (v0.1)
 * 
 *
 * Copyright (C) 2014 Max Löffler <loeffler@zew.de>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

program define capass, byable(onecall)
    syntax anything(name=0) [if] [in] [, Throw(string) Rc0 Null Fast] 
    
    // Maybe a normal assert would be alight?
    if ("`throw'" != "") {
        // Test assertion
        cap assert `0' `if' `in', fast
        
        // Let's call the police
        if (_rc != 0) {
            noi di as error "`throw'"
            assert `0' `if' `in', `rc0' `null' `fast'
        }
    }
    // Just assert and leave
    else assert `0' `if' `in', `rc0' `null' `fast'
end

***
