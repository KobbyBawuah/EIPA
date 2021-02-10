set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaulttaxesfontsize',20)
set(0,'defaulttaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth',2);

nx = 50;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx * ny,nx * ny);

Inclusion = 0;

for i = 1 : nx
   for j = 1:ny
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