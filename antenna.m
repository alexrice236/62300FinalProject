f = 2.4e9;
c = 3e8;
k = 2*pi*f/c;
eps_r = 4.4; % CHANGE IF DIFFERENT FROM MEASURED

fr1 = dielectric(Name="FR1", EpsilonR=eps_r, LossTangent=0.03);

% use theoretical calculations to find nominal values --> explore design space for optimal dimensions for two different types of patch antenna
% designed largely around equations from "A Design Rule for Inset-fed Rectangular Microstrip Patch Antenna" (M A MATIN, A. I. SAYEED)

% constraints: 50 [Ohm] matched impedance, center frequency 2.4 GHz

width = c/(2*f)*sqrt(2/(eps_r+1));
% substrate_height = 0.06*((c/f)/sqrt(eps_r)); % CHANGE if using fixed thickness (i.e. cannot mill thinner PCB)
substrate_height = 0.0016; 
eps_eff = (eps_r+1)/2 + ((eps_r+1)/2) * 1/sqrt(1+12*(substrate_height/width)); 
L_del = 0.412*substrate_height*((eps_eff+0.3)*(width/substrate_height+0.264))/((eps_eff-0.258)*(width/substrate_height+08));
length = c/(2*f*sqrt(eps_eff)) - 2*L_del;

% single_notch_width = (c/sqrt(2*eps_eff))*(4.65e-12/f); % IGNORE these two lines for now
% strip_line_width = 40 * single_notch_width; % CHANGE coeff to change bandwidth (10 --> 40 increases bandwidth 46 percent)

Z_0 = 50; % characteristic impedance of transmission line

% find mutual conductance and resonant input resistance 
syms x;
G1p = @(x) (1/(120*pi^2))*((sin((k*width/2)*cos(x))/cos(x)).^2)*sin(x).^3;
G12p = @(x) (1/(120*pi^2))*((sin((k*width/2)*cos(x))/cos(x)).^2).*besseli(0, k*length*sin(x)).*sin(x).^3;
G1 = integral(G1p,0,pi);
G12 = integral(G12p,0,pi);
R_in = 1/(2*(G1 +  G12));

% find inset distance to make Z_A = 50
syms d;
eqn = R_in * (cos((pi/length)*d)^2) == 50; 
sol = eval(solve(eqn, d));
inset_distance_1 = abs(sol(1));

% use two different methods
Z_p = 90*(eps_eff^2)/(eps_eff-1)*(length/width)^2;
inset_distance_2 = (length/pi)*acos((50/Z_p)^0.25);

% two methods gives us a good idea of the ranges to sweep for matching the
% impedance

% use SADEA optimizer --> very broad ranges (https://www.mathworks.com/help/antenna/ref/cavity.optimize.html)

designVariables = {'Length','Width', 'NotchLength'};
XVmin = [length*0.5, width*0.5, inset_distance_2];
XVmax = [length*1.5, width*1.5, inset_distance_1];

ant = design(patchMicrostripInsetfed, 2.4e9);
ant.Substrate = fr1;
ant.NotchLength = inset_distance_2;
ant.Length = length;
ant.Width = width;
ant.Height = substrate_height;
ant.GroundPlaneLength = 0.065;
ant.GroundPlaneWidth = 0.065;
ant.FeedOffset = [-optAnt.GroundPlaneLength/2, 0.0];

optAnt = optimize(ant, 2.4e9, "maximizeGain", designVariables, {XVmin;XVmax}, Iterations=200);

impedance(ant, 2.4e9)

pattern(ant, 2.4e9)

% optAnt.FeedOffset = [-optAnt.GroundPlaneLength/2, 0.0];




