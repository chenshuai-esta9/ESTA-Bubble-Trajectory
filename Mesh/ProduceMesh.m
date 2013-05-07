function ProduceMesh(s)%s='Test'
dim=2;%dimension of the mesh
dtf=0.001;%time step length between 2 neighbouring frames
nframe=500;%Number of frames
Nx=50;%Nx nodes between Xmin and Xmax
Ny=600;%Ny nodes between Ymin and Ymax
if dim==3;%dimension=3
    Nz=100;%Nz nodes between Zmin and Zmax
end
%interval of length in directions X-axis,Y-axis,(Z-axis)
Xmin=0;Xmax=5.0;
Ymin=0;Ymax=5.0;
if dim==3;%dimension=3
    Zmin=0;Zmax=10;
end
%distances between neighbouring frames
a=double((Xmax-Xmin)/Nx);
b=double((Ymax-Ymin)/Ny);
if dim==3;%dimension=3
    c=double((Zmax-Zmin)/Nz);
end

if dim==3;%dimension=3
    for n=0:nframe;
        %Output some essential parameters of 3D mesh
        filename=[ num2str(n) '_mesh.txt'];
        fid=fopen(filename,'wt');
        fprintf(fid,'%s\n','#dimension');
        fprintf(fid,'%d\n',dim);
        fprintf(fid,'%s\n','#Nx,Ny,Nz');
        fprintf(fid,'%d %d %d\n',Nx,Ny,Nz);
        fprintf(fid,'%s\n','#Xmin,Xmax,Ymin,Ymax,Zmin,Zmax');
        fprintf(fid,'%f %f %f %f %f %f\n',Xmin,Xmax,Ymin,Ymax,Zmin,Zmax);
        fprintf(fid,'%s\n','#\Delta t_fperiod between neighoring frames');
        fprintf(fid,'%f\n',dtf);
        fprintf(fid,'%s\n','#frame number n (t=n\Delta t)');
        fprintf(fid,'%d\n',n);
        fclose(fid);
        %Output informations at each nodes in 3D flow field:
        %position(3D index),pressure,velocity
        filename=[ num2str(n) '_mesh.txt'];
        fid=fopen(filename,'at');
        fprintf(fid,'%s\n','#I,J,K,P,Ux,Uy,Uz');
        for i=0:Nx;
            for j=0:Ny;
                for k=0:Nz;
                    %position and time
                    x=Xmin+i*a;
                    y=Ymin+j*b;
                    z=Zmin+k*c;
                    t=n*dtf;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %Here we have 2 example in 3D flow field ,remove '%{' before the example
                    %you want to generate.
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %{
                    %3D Poiseuille flow (laminar)
                    Lx=1.3*(Xmax-Xmin);
                    Lz=1.3*(Zmax-Zmin);
                    CenterX=(Xmax-Xmin)./2+Xmin;
                    CenterZ=(Zmax-Zmin)./2+Zmin;
                    R2=(Lx.^2+Lz.^2)./4;
                    r2=(x-CenterX).^2+(z-CenterZ).^2;
                    mu=25000;
                    gradpx=-20;
                    P=12340+gradpx*y;%Initial pressure can not be null or negative!
                    Ux=0;
                    Uy=-gradpx*(R2-r2)./(4*mu);
                    Uz=0;
                    %}
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %{
                    %%3D Water at rest
                    rho=1000;
                    g=9.8;
                    P=101325+rho*g*(Zmax-z);%Initial pressure can not be null or negative!
                    Ux=0;
                    Uy=0;
                    Uz=0;
                    %}
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    fprintf(fid,'%d %d %d %f %f %f %f\n',i,j,k,P,Ux,Uy,Uz);
                end
            end
        end
        fclose(fid);
    end
else %dimension==2
    for n=0:nframe;
        %Output some essential parameters of 2D  mesh
        filename=[num2str(n) '_mesh.txt'];
        fid=fopen(filename,'wt');
        fprintf(fid,'%s\n','#dimension');
        fprintf(fid,'%d\n',dim);
        fprintf(fid,'%s\n','#Nx,Ny');
        fprintf(fid,'%d %d\n',Nx,Ny);
        fprintf(fid,'%s\n','#Xmin,Xmax,Ymin,Ymax');
        fprintf(fid,'%f %f %f %f\n',Xmin,Xmax,Ymin,Ymax);
        fprintf(fid,'%s\n','#\Delta t_fperiod between neighoring frames');
        fprintf(fid,'%f\n',dtf);
        fprintf(fid,'%s\n','#frame number n (t=n\Delta t)');
        fprintf(fid,'%d\n',n);
        fclose(fid);
        %Output informations at each nodes in 2D flow field:
        %position(2D index),pressure,velocity
        filename=[num2str(n) '_mesh.txt'];
        fid=fopen(filename,'at');
        fprintf(fid,'%s\n','#I,J,P,Ux,Uy');
        for i=0:Nx;
            for j=0:Ny;
                x=Xmin+i*a;
                y=Ymin+j*b;                
                t=n*dtf;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %Here we have 4 example in 2D flow field ,remove '%{' before the example
                %you want to generate.
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %{
                %2D Taylor-Green Vortex
                X1=double(x./(Xmax-Xmin));
                Y1=double(y./(Ymax-Ymin));
                X=2*pi*X1;
                Y=2*pi*Y1;
                nu=2;
                rho=400;
                F=exp(-2*nu*t);
                P=(rho/4)*F^2*(cos(2*X)+cos(2*Y))+1234;%Initial pressure can not be null or negative!
                Ux=sin(X)*cos(Y)*F;
                Uy=-cos(X)*sin(Y)*F;
                %}
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %{
                %2D Couette flow (laminar)
                H=Ymax-Ymin;
                gradpx=-20;
                mu=12000;
                u0=5;
                P=101325+gradpx*x;%Initial pressure can not be null or negative!
                Ux=u0*y./H+gradpx*(y.^2-H*y)./(2*mu);
                Uy=0;
                %}
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %{
                %2D Poiseuille (laminar)
                Ly=Ymax-Ymin;                
                CenterY=(Ymax-Ymin)./2+Ymin;               
                R2=Ly.^2./4;
                r2=(y-CenterY).^2;
                mu=0.001308;
                gradpx=-0.101325;
                P=101325+gradpx*x;%Initial pressure can not be null or negative!
                Ux=-gradpx*(R2-r2)./(4*mu);
                Uy=0;
                %}
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %{
                %%2D Water at rest
                rho=1000;
                g=9.8;
                P=101325+rho*g*(Ymax-y);%Initial pressure can not be null or negative!
                Ux=0;
                Uy=0;
                %}
                
                %%2D Water uniform gradient
                rho=1000;
                g=9.8;
                P=101325+rho*g*(Ymax-y);%Initial pressure can not be null or negative!
                Ux=0;
                Uy=1.05-1.05.*(x-Xmin)./(Xmax-Xmin);
                %}
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                fprintf(fid,'%d %d %f %f %f\n',i,j,P,Ux,Uy);
            end
        end
        fclose(fid);
    end
end

if  nargin==1;  
    if s=='Test';
        Total=nframe+1;%Total numbers of frames from 0_mesh.txt to num2str(nframe)_mesh.txt.
        TestFlowField(Total);%Virtualize and verify the mesh generated
    end
end

end
