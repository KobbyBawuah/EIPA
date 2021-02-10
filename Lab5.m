set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth',2);

nx = 50;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx * ny,nx * ny);

Inclusion = 0;

for i = 1 : nx
   for j = 1:ny
        n = j+(i-1)*ny;
        
        if i == j%diagonal
            G(n,n) = 1;
        elseif i == 1%bottom boudary
            G(n,n) = 1;
        elseif j == 1%left boundary
            G(n,n) = 1;
        elseif i == nx%top boudary
            G(n,n) = 1;
        elseif j == ny%right boundary
            G(n,n) = 1;
             elseif (i>10 && i<20 && j>10 && j<20)
            nxm = j+(i-2)*ny;
            nxp = j+(i)*ny;
            nyp = j+1+(i-1)*ny;
            nym = j-1+(i-1)*ny;
            
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
            G(n,n) = -2;
        else %rest of matrix
            nxm = j+(i-2)*ny;
            nxp = j+(i)*ny;
            nyp = j+1+(i-1)*ny;
            nym = j-1+(i-1)*ny;
            
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
            G(n,n) = -4;
        end
   end
end

figure 
figure ('name','Matrix')

spy(G)

nmodes = 20;
[E,D] = eigs(G,nmodes, 'SM');

figure('name','EigenValues')
plot(diag(D),'*');

np = ceil(sqrt(nmodes))
figure('name','Modes')

for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i +(j-1) * nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V, 'linestyle','none')
        title(['EV = ' num2str(D(k,k))])
    end
end