vertices = load('vertices.mat','vertices');
vertices = vertices.vertices;
n1 = 1500;
n2 = 840;
x = min(vertices(1,:)):(max(vertices(1,:))-min(vertices(1,:)))/(n1-1):max(vertices(1,:));
% why the sign of y is reversed???
y = -(min(vertices(2,:)):(max(vertices(2,:))-min(vertices(2,:)))/(n2-1):max(vertices(2,:)));
[cordx,cordy] = meshgrid(x,y);

for i = 1:1:20
    freq = (0.42+i*0.003) * 3e8;
    fname = sprintf('Hz_%.4e.mat', freq);
    Hzfield(i) = load(fname,'Hz');
end

dt = 2/(0.015*3e8);
midfreq = 0.45*3e8;
dfreq = 0.015*3e8;


for j = 1:1:50
    fieldt1 = 0;
for i = 1:1:20
    t = (j-1)*1e-7;
    freq = (0.42+i*0.003) * 3e8;
    fieldt1 = fieldt1 + exp(1i * 2*pi/20 * t * freq) * Hzfield(i).Hz * exp(-(freq-midfreq)^2/dfreq^2);
end
%fieldt1 = fieldt1 * exp(-t^2/dt^2 - 1i*midfreq*t);

        
        
%field1(1) = load('Hz_9.3450e+07.mat','Hz');
%field1(2) = load('Hz_9.3450e+07.mat','Hz');
%field1 = field1.Hz;
IMA = figure(2)
imagesc(x,y,real(fieldt1))
title(['Time = ',num2str(t*1e9),' ns'])
colormap('jet')
caxis([-0.05 0.05])
fname2 = sprintf('t=%dns.png', t*1e9);
saveas(IMA,fname2)
end