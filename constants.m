classdef constants
    % Usage: c = constants; year = c.yr; etc.
    % Properties: general constants
    
    properties( Constant = true )
         yr = 31536000 % year in seconds (365*24*60*60)
         day = 86400 % day in seconds (24*60*60)
         sday = 86164.0916 % sidereal day in seconds
         c = 299792458 % speed of light, m/s (source: wikipedia)
    end
    
 end