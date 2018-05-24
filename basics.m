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
        
           function tyr = tfromf(f)
           % Make observation time bins, coressponding to frequency bins
           c = constants;
           tyr = fliplr((1./f)/c.yr);
        end
        
    end
    
 end