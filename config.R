# This file has all of the code needed for the font styling used on the 
# webpages for the various categories of "Required", "If Applicable", etc.

# Using colors from this wesbite:
# https://designsystem.digital.gov/design-tokens/color/state-tokens/
# This allows the colors to be coded as a variable and, thus, easily changed.

required_color <- "#b50909"        #'red-60v'
if_applicable_color <- "#947100"   # 'yellow-50v'
best_practice_color <- "#00687d"   # 'cyan-60v'
other_color <- "#00687d"           # 'gray-cool-70'
req_style <- paste0('{style="color:', required_color, ';font-weight:bold"}')
if_style <- paste0('{style="color:', if_applicable_color,';"}')
best_style <- paste0('{style="color:', best_practice_color, ';"}')
other_style <- paste0('{style="color:', best_practice_color, ';"}')