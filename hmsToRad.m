function rad = hmsToRad(hms)
% Angle convertion from hours, minutes, seconds; to radians
% hms can be multiple rows, where each row has 3 columns: hh, mm, ss.

szhms = size(hms);
if szhms(2)~=3
  ermsg = 'Error: input angle should have length of 3: hours, minutes, seconds \n';
  error(ermsg);
end

rad = (hms(1)*60*60+hms(2)*60+hms(3))/(24*3600)*2*pi;

end

