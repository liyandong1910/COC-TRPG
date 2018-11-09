

freq = 26.7e7;
%% Load model
M = all_Si_PTI_detour_2D_2;

%% Run COMSOL
M.param.set('Qfr', num2str(freq));
M.study('std1').run;
model = mpheval(M,'emw.Hz','solnum','all');
vertices = model.p;
triangles = model.t + 1;
Hz_mesh = model.d1;
F = scatteredInterpolant((vertices(1,:)).',(vertices(2,:)).',(Hz_mesh).');

n1 = 1500;
n2 = 840;
x = min(vertices(1,:)):(max(vertices(1,:))-min(vertices(1,:)))/(n1-1):max(vertices(1,:));
y = min(vertices(2,:)):(max(vertices(2,:))-min(vertices(2,:)))/(n2-1):max(vertices(2,:));
[cordx,cordy] = meshgrid(x,y);

Hz = F(cordx,cordy);
imagesc(x,y,real(Hz))
caxis([-0.008 0.008])

%save('D:\Gennady_Group\comsol_ift\vertices.mat','vertices')
%save('D:\Gennady_Group\comsol_ift\triangles.mat','triangles')
%save('D:\Gennady_Group\comsol_ift\Hz_mesh.mat','Hz_mesh')
fname = sprintf('Hz_%.4e.mat', freq);
save(fname,'Hz')
