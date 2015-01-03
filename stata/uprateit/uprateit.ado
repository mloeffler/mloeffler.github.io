*! version 0.2, 03jan2015, Max Loeffler <loeffler@zew.de>
/**
 * UPRATEIT - UPRATE MONETARY VARIABLES ACCORDING TO INFLATION INDICIES
 * 
 * Uprates monetary variables from different source years to a common target
 * base or target year. Can easily be extended to different countries and/or
 * accounting methods. By now it includes:
 *
 * de / cpi     Germany, Consumer Price Index (Federal Statistical Office)
 *              Verbraucherpreisindex für Deutschland - Lange Reihen ab 1948 -
 *                  September 2014 (only West Germany until 1991)
 * 
 * 2014-10-16   Initial version (v0.1)
 * 2015-01-03   Extend time series for Germany (CPI) until 1949 (v0.2)
 * 
 *
 * Copyright (C) 2014-2015 Max Löffler <loeffler@zew.de>
 *                         Sebastian Siegloch <siegloch@uni-mannheim.de>
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


/**
 * Uprate set of variables by merging uprating data set and applying crosswalk
 * 
 * @package uprateit
 * @param `varlist' Monetary variables that need to be uprated
 * @param `using'   Path to relevant uprating table (see uprateit_create_table)
 * @param `from'    Base year or variable containing the base year
 * @param `to'      Target year for variable uprating
 */
program define uprateit
    version 13
    syntax varlist(numeric) using [if] [in], From(string) To(string)
    tempvar bak_year bak_uprate
    
    // Check options
    local from = trim("`from'")
    if (regexm("`from'", "^[0-9][0-9][0-9][0-9]$")) {
        cap rename year `bak_year'
        gen year = `from'
    }
    else {
        cap isvar `from'
        if (_rc != 0 | "`r(varlist)'" == "" | wordcount("`from'") > 1) {
            di in r "Option from has to be (a) numeric (variable)."
            exit 198
        }
        if ("`from'" != "year") {
            cap rename year `bak_year'
            gen year = `from'
        }
        else gen `bak_year' = year
    }
    local to = trim("`to'")
    if (!regexm("`to'", "^[0-9][0-9][0-9][0-9]$")) {
        di in r "Option to has to be numeric."
        exit 198
    }
    
    // Merge uprating table
    cap rename y`to' `bak_uprate'
    qui merge m:1 year `using', keep(1 3) nogen keepus(y`to')
    
    // Uprate monetary variables
    foreach var of local varlist {
        qui replace `var' = `var' * y`to' `if' `in'
    }
    
    // Restore old variables
    cap drop y`to' year
    cap rename `bak_uprate' y`to'
    cap rename `bak_year' year
end

***
