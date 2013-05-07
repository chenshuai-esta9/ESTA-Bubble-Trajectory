function output(n,ratio,PositionP,VelocityP,R,Re,Nameless,Drag,Lift,AddedMass,Basset,BandG)
%Output bubble's data: position,velocity,radius,Reynolds number,Components
%of each force
global dtf %time step length between 2 mesh frames
dt=ratio*dtf; %time step length between 2 computational frames

global system
if strcmp(system,'WINDOWS');
    filename=[ '..\trajectory\trajectory.txt'];
elseif strcmp(system,'LINUX');
    filename=[ '../trajectory/trajectory.txt'];
end

if n~=0;%n>=1
    fid=fopen(filename,'at');
    if size(PositionP,2)==3;
        fprintf(fid,'%d %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f\n', ...
        n,PositionP(1),PositionP(2),PositionP(3), ...%the  n th time step, the velocity of bubble
        VelocityP(1),VelocityP(2),VelocityP(3), ...%the velocity of bubble
        R,Re,Nameless(1),Nameless(2),Nameless(3),Drag(1),Drag(2),Drag(3),Lift(1),Lift(2),Lift(3), ...%the Reynolds number, components of each force
        AddedMass(1),AddedMass(2),AddedMass(3),Basset(1),Basset(2),Basset(3), ...
        BandG(1),BandG(2),BandG(3));    
    else
        fprintf(fid,'%d %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f\n', ...
        n,PositionP(1),PositionP(2), ...%the  n th time step, the velocity of bubble
        VelocityP(1),VelocityP(2), ...%the velocity of bubble
        R,Re,Nameless(1),Nameless(2),Drag(1),Drag(2),Lift(1),Lift(2), ...%the Reynolds number, components of each force
        AddedMass(1),AddedMass(2),Basset(1),Basset(2), ...
        BandG(1),BandG(2)); 
    end
    fclose(fid);
else %n=0
    fid=fopen(filename,'wt');
    fprintf(fid,'%s\n','#dimension');
    global dim
    fprintf(fid,'%d\n',dim);
    fprintf(fid,'%s\n','#step of time \Delta t');    
    fprintf(fid,'%.15f\n',dt);
    if size(PositionP,2)==3;%dimension=3
        fprintf(fid,'%s\n','#Xmin,Xmax,Ymin,Ymax,Zmin,Zmax');
        global Xmin Xmax Ymin Ymax Zmin Zmax
        fprintf(fid,'%.15f %.15f %.15f %.15f %.15f %.15f\n',Xmin,Xmax,Ymin,Ymax,Zmin,Zmax); %Output intervals of mesh in different direction   
        fprintf(fid,'%s\n','#n,X,Y,Z,Vx,Vy,Vz,R,Re,Namelessx,Namelessy,Namelessz,Dragx,Dragy,Dragz,Liftx,Lifty,Liftz,AddedMassx,AddedMassy,AddedMassz,Bassetx,Bassety,Bassetz,BandGx,BandGy,BandGz');
        
        fprintf(fid,'%d %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f\n', ...
        n,PositionP(1),PositionP(2),PositionP(3), ...%the  n th time step, the velocity of bubble
        VelocityP(1),VelocityP(2),VelocityP(3), ... %the velocity of bubble
        R,Re,Nameless(1),Nameless(2),Nameless(3),Drag(1),Drag(2),Drag(3),Lift(1),Lift(2),Lift(3), ...%the Reynolds number, components of each force
        AddedMass(1),AddedMass(2),AddedMass(3),Basset(1),Basset(2),Basset(3), ...
        BandG(1),BandG(2),BandG(3));
    else %dimension=2
        fprintf(fid,'%s\n','#Xmin,Xmax,Ymin,Ymax');
        global Xmin Xmax Ymin Ymax
        fprintf(fid,'%.15f %.15f %.15f %.15f\n',Xmin,Xmax,Ymin,Ymax);   %Output intervals of mesh in different direction  
        fprintf(fid,'%s\n','#n,X,Y,Vx,Vy,R,Re,Namelessx,Namelessy,Dragx,Dragy,Liftx,Lifty,AddedMassx,AddedMassy,Bassetx,Bassety,BandGx,BandGy');
        
        fprintf(fid,'%d %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f\n', ...
        n,PositionP(1),PositionP(2), ...%the  n th time step, the velocity of bubble
        VelocityP(1),VelocityP(2), ... %the velocity of bubble
        R,Re,Nameless(1),Nameless(2),Drag(1),Drag(2),Lift(1),Lift(2), ... %the Reynolds number, components of each force
        AddedMass(1),AddedMass(2),Basset(1),Basset(2), ...
        BandG(1),BandG(2));
    end
    fclose(fid);
end

end
