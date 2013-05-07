function main()
global system
system='LINUX';
%read the initial.txt and constants.txt
[P0,R0,X0,V0]=initialisation();


%NT Number of steps of time
NT=1000;
%!!!!!Caution!!!!NT+ratio should be less than the maximum serial number of
%flow field frame,or there may be an INDEX OUT OF BOUNDS error.

%step length of time for computation
dt=0.0025;
%the safe distance for bubble.Keep aways from the wall in order to avoiding the Faxen correction
%and the boundary treatment for FDM(Finite Difference Method)
global dim
if dim==3;
    SafeDistance=[0.000000001,0.000000002,0.000000003];
else
    SafeDistance=[0.000000001,0.000000002];
end
    
%the assurance of creeping flow.The Reynolds number should be less than epsilon
epsilon=100000000000000;
%the step length of time between 2 frames of flow field which we read
global dtf 
%ratio is an useful integer during the calculation of temporal
%derivative.Because it is impossible to read a frame of flow field like the 2.5th frame.
%the serial number of frame should be an integer.
ratio=floor(dt./dtf);
%!!!!!Caution!!!!NT+ratio should be less than the maximum serial number of
%flow field frame,or there may be an INDEX OUT OF BOUNDS error.

%Realisation of temporal integration
TemporalIntegration(P0,R0,X0,V0,ratio,NT,SafeDistance,epsilon);
end
