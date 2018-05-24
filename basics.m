classdef basics
    % Basic relations for pulsar timing
    
    methods (Static)
        
        function f = ftso(tsam,tobs)
           % Make frequency bins from observation and sampling time
           % tsam in seconds, tobs in years
           c = constants;
           hfb = floor(tobs*c.yr/(2*tsam));
           f = linspace(1/(tobs*c.yr),hfb/(tobs*c.yr),hfb);
        end
        
    end
    
 end