% User Input
T_int       = 1200;   % Intrusion temperature
T_amb       = 500;    % Ambient temperature

D           = 1e-6;   % Diffusivity

i_width     = 20;     % Intrusion width
model_width	= 70;     % Model width
nx          = 1000;   % Number of points in x

nt          = 600000; % Number of timesteps
dt          = 60;     % Timestep

% Geomtery
x   = linspace(-model_width/2, model_width/2, nx);
dx  = x(2)-x(1);

% Initial Condition
T   = T_amb*ones(1,nx);
T(abs(x)<i_width/2)  = T_int;

% Plot Initial Conditions
figure(1)
clf;
plot(x, T, 'r-');
xlabel('Distance');
ylabel('Temperature');
hold on;
grid on;

% Time Loop
T_NEW   = T;
for t=1:nt
    for i=2:nx-1
        T_NEW(i)    = T(i) + dt*D/dx^2*(T(i+1)-2*T(i)+T(i-1));
    end
    
    % Occasionally plot progress
    if (mod(t,50000)==0)
        plot(x, T_NEW, '-b');
        title(['Time: ', num2str(t*dt/3600, '%5.2f'), ' [hours]']);
        drawnow; % Force drawing
    end

    T   = T_NEW;
end
