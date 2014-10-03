function pulses = parsePulses(dataMat)
%Currently written for 10 pulses/run. dataMat is 30000x8 matrix of squids as column
% vectors
pulse = zeros(3000,1);
pulses(:,1) = dataMat(1:3000,1);
for ii = 2:8
    for jj = 1:10
    pulse = pulse + dataMat((jj-1)*3000+1:jj*3000,ii);
    end
    pulses(:,ii) = pulse;
    pulse = zeros(3000,1);
end
pulses(:,2:8) = pulses(:,2:8) ./10;

st = 700;
maxDiff = 0;
for ii = 1:length(pulses(:,1))-1
    if pulses(ii+1,2)- pulses(ii,2) >maxDiff
        maxDiff = pulses(ii+1,2)- pulses(ii,2);
        st = ii;
    end
end