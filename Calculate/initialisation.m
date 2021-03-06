function [Pressure0,Radius0,Position0,Velocity0]=initialisation()
%Read physical constants
global MU %coefficient of dynamic viscosity of fluid
[MU]=textread('constants.txt','%f',1,'headerlines',1);
global RHOC %density of fluid
[RHOC]=textread('constants.txt','%f',1,'headerlines',3);
global RHOP %density of bubble
[RHOP]=textread('constants.txt','%f',1,'headerlines',5);
global GAMMA %isentropic index
[GAMMA]=textread('constants.txt','%f',1,'headerlines',7);
global G %gravity acceleration
[G]=textread('constants.txt','%f',1,'headerlines',9);


global system %WINDOWS or LINUX
sprintf('system=%s',system)

global dim %dimension of problem 3D or 2D
if strcmp(system,'WINDOWS');%if you are using Microsoft Windows
    [dim]=textread('..\Mesh\0_mesh.txt','%d',1,'headerlines',1);
elseif strcmp(system,'LINUX');%if you are using LINUX
    [dim]=textread('../Mesh/0_mesh.txt','%d',1,'headerlines',1);
end

%initial values
if dim==3;
    filename=['3D_initial.txt'];
else%dim=2
    filename=['2D_initial.txt'];
end
%read two parameter Pressure0,Radius0,which will be used during the
%calculation of radius of bubble
[Pressure0,Radius0]=textread(filename,'%f %f',1,'headerlines',3);

%read the initial position and velocity of bubble
if dim==3;
    [X0,Y0,Z0]=textread(filename,'%f %f %f',1,'headerlines',5);
    Position0=[X0,Y0,Z0];
    [Vx0,Vy0,Vz0]=textread(filename,'%f %f %f',1,'headerlines',7);
    Velocity0=[Vx0,Vy0,Vz0];
else %dim=2
    [X0,Y0]=textread(filename,'%f %f',1,'headerlines',5);
    Position0=[X0,Y0];
    [Vx0,Vy0]=textread(filename,'%f %f',1,'headerlines',7);
    Velocity0=[Vx0,Vy0];
end
sprintf('dim=%d',dim)
%{
if dim==3;
    global Nx Ny Nz 
    %Nx nodes between Xmin and Xmax,Ny nodes between Ymin and Ymax,Nz nodes between Zmin and Zmax
    if strcmp(system,'WINDOWS');
        [Nx,Ny,Nz]=textread('..\Mesh\0_mesh.txt','%d %d %d',1,'headerlines',3);
    elseif strcmp(system,'LINUX');
        [Nx,Ny,Nz]=textread('../Mesh/0_mesh.txt','%d %d %d',1,'headerlines',3);
    end
    
    global Xmin Xmax Ymin Ymax Zmin Zmax %Read intervals of mesh
    if strcmp(system,'WINDOWS');
        [Xmin,Xmax,Ymin,Ymax,Zmin,Zmax]=textread('..\Mesh\0_mesh.txt','%f %f %f %f %f %f',1,'headerlines',5);
    elseif strcmp(system,'LINUX');
        [Xmin,Xmax,Ymin,Ymax,Zmin,Zmax]=textread('../Mesh/0_mesh.txt','%f %f %f %f %f %f',1,'headerlines',5);
    end
    global dtf %Read the time step length between two neighbouring frames
    if strcmp(system,'WINDOWS');
        [dtf]=textread('..\Mesh\0_mesh.txt','%f',1,'headerlines',7);
    elseif strcmp(system,'LINUX');
        [dtf]=textread('../Mesh/0_mesh.txt','%f',1,'headerlines',7);
    end
   
    global a b c %distances between neighbouring frames
    a=double((Xmax-Xmin)/Nx);
    b=double((Ymax-Ymin)/Ny);
    c=double((Zmax-Zmin)/Nz);
elseif dim==2;    
    global Nx Ny %Nx nodes between Xmin and Xmax,Ny nodes between Ymin and Ymax
    if strcmp(system,'WINDOWS');
        [Nx,Ny]=textread('..\Mesh\0_mesh.txt','%d %d',1,'headerlines',3);
    elseif strcmp(system,'LINUX');
        [Nx,Ny]=textread('../Mesh/0_mesh.txt','%d %d',1,'headerlines',3);
    end
    sprintf('Nx=%d,Ny=%d',Nx,Ny)
    
    global Xmin Xmax Ymin Ymax %intervals of mesh
    if strcmp(system,'WINDOWS');
        [Xmin,Xmax,Ymin,Ymax]=textread('..\Mesh\0_mesh.txt','%f %f %f %f',1,'headerlines',5);
    elseif strcmp(system,'LINUX');
        [Xmin,Xmax,Ymin,Ymax]=textread('../Mesh/0_mesh.txt','%f %f %f %f',1,'headerlines',5);    
    end
    global dtf %Read the time step length between two neighbouring frames
    if strcmp(system,'WINDOWS');
        [dtf]=textread('..\Mesh\0_mesh.txt','%f',1,'headerlines',7);
    elseif strcmp(system,'LINUX');
        [dtf]=textread('../Mesh/0_mesh.txt','%f',1,'headerlines',7);
    end
    sprintf('dtf=%f',dtf)
    
    global a b %distances between neighbouring frames
    a=double((Xmax-Xmin)./Nx);
    b=double((Ymax-Ymin)./Ny);
    sprintf('a=%f,b=%f',a,b)
end
%}
if dim==2;    
    global Nx Ny %Nx nodes between Xmin and Xmax,Ny nodes between Ymin and Ymax
    if strcmp(system,'WINDOWS');
        [Nx,Ny]=textread('..\Mesh\0_mesh.txt','%d %d',1,'headerlines',3);
    elseif strcmp(system,'LINUX');
        [Nx,Ny]=textread('../Mesh/0_mesh.txt','%d %d',1,'headerlines',3);
    end
    sprintf('Nx=%d,Ny=%d',Nx,Ny)
    
    global Xmin Xmax Ymin Ymax %intervals of mesh
    if strcmp(system,'WINDOWS');
        [Xmin,Xmax,Ymin,Ymax]=textread('..\Mesh\0_mesh.txt','%f %f %f %f',1,'headerlines',5);
    elseif strcmp(system,'LINUX');
        [Xmin,Xmax,Ymin,Ymax]=textread('../Mesh/0_mesh.txt','%f %f %f %f',1,'headerlines',5);    
    end
    global dtf %Read the time step length between two neighbouring frames
    if strcmp(system,'WINDOWS');
        [dtf]=textread('..\Mesh\0_mesh.txt','%f',1,'headerlines',7);
    elseif strcmp(system,'LINUX');
        [dtf]=textread('../Mesh/0_mesh.txt','%f',1,'headerlines',7);
    end
    sprintf('dtf=%f',dtf)
    
    global a b %distances between neighbouring frames
    a=double((Xmax-Xmin)./Nx);
    b=double((Ymax-Ymin)./Ny);
    sprintf('a=%f,b=%f',a,b)
else
    global Nx Ny Nz 
    %Nx nodes between Xmin and Xmax,Ny nodes between Ymin and Ymax,Nz nodes between Zmin and Zmax
    if strcmp(system,'WINDOWS');
        [Nx,Ny,Nz]=textread('..\Mesh\0_mesh.txt','%d %d %d',1,'headerlines',3);
    elseif strcmp(system,'LINUX');
        [Nx,Ny,Nz]=textread('../Mesh/0_mesh.txt','%d %d %d',1,'headerlines',3);
    end
    
    global Xmin Xmax Ymin Ymax Zmin Zmax %Read intervals of mesh
    if strcmp(system,'WINDOWS');
        [Xmin,Xmax,Ymin,Ymax,Zmin,Zmax]=textread('..\Mesh\0_mesh.txt','%f %f %f %f %f %f',1,'headerlines',5);
    elseif strcmp(system,'LINUX');
        [Xmin,Xmax,Ymin,Ymax,Zmin,Zmax]=textread('../Mesh/0_mesh.txt','%f %f %f %f %f %f',1,'headerlines',5);
    end
    global dtf %Read the time step length between two neighbouring frames
    if strcmp(system,'WINDOWS');
        [dtf]=textread('..\Mesh\0_mesh.txt','%f',1,'headerlines',7);
    elseif strcmp(system,'LINUX');
        [dtf]=textread('../Mesh/0_mesh.txt','%f',1,'headerlines',7);
    end
   
    global a b c %distances between neighbouring frames
    a=double((Xmax-Xmin)/Nx);
    b=double((Ymax-Ymin)/Ny);
    c=double((Zmax-Zmin)/Nz);
end
    
    
end