function rad = dmsToRad(dms)
% Angle convertion from degrees, minutes, seconds; to radians (-pi to pi)
% dms can be multiple rows, where each row has 3 columns: dd, mm, ss.
% [!!!] Assuming 1 minute = 1/60 of a degree, not of an hour.

szdms = size(dms);
if szdms(2)~=3
  ermsg = 'Error: input angle should have length of 3: hours, minutes, seconds \n';
  error(ermsg);
end

rad = sign(dms(1)) * (abs(dms(1)) + dms(2)/60 + dms(3)/3600)/90*pi;

end

