% generateXYDataObstacles_TS_v3.m

% --- Time vector (more points)
numPts_sq = 100;
numPts_line = 100;
numPts_circ = 100;

time_sq = 0:(numPts_sq-1);
time_line = 0:(numPts_line-1);
time_circ = 0:(numPts_circ-1);

% --- Square 1 Obstacle ---
x0_sq1 = -1.19;  y0_sq1 = -0.34;  side_sq1 = 0.9;
x_sq1_v = [x0_sq1 - side_sq1/2, x0_sq1 + side_sq1/2, x0_sq1 + side_sq1/2, x0_sq1 - side_sq1/2, x0_sq1 - side_sq1/2];
y_sq1_v = [y0_sq1 - side_sq1/2, y0_sq1 - side_sq1/2, y0_sq1 + side_sq1/2, y0_sq1 + side_sq1/2, y0_sq1 - side_sq1/2];
t_sq1_v = linspace(0,1,numel(x_sq1_v));
t_sq1_i = linspace(0,1,numPts_sq);
x_sq1 = interp1(t_sq1_v, x_sq1_v, t_sq1_i);
y_sq1 = interp1(t_sq1_v, y_sq1_v, t_sq1_i);
xSq1TS = timeseries(x_sq1', time_sq, "Name", "Square1_X");
ySq1TS = timeseries(y_sq1', time_sq, "Name", "Square1_Y");

% --- Square 2 Obstacle ---
x0_sq2 = 0.6;  y0_sq2 = -1.2;  side_sq2 = 0.9;
x_sq2_v = [x0_sq2 - side_sq2/2, x0_sq2 + side_sq2/2, x0_sq2 + side_sq2/2, x0_sq2 - side_sq2/2, x0_sq2 - side_sq2/2];
y_sq2_v = [y0_sq2 - side_sq2/2, y0_sq2 - side_sq2/2, y0_sq2 + side_sq2/2, y0_sq2 + side_sq2/2, y0_sq2 - side_sq2/2];
t_sq2_v = linspace(0,1,numel(x_sq2_v));
t_sq2_i = linspace(0,1,numPts_sq);
x_sq2 = interp1(t_sq2_v, x_sq2_v, t_sq2_i);
y_sq2 = interp1(t_sq2_v, y_sq2_v, t_sq2_i);
xSq2TS = timeseries(x_sq2', time_sq, "Name", "Square2_X");
ySq2TS = timeseries(y_sq2', time_sq, "Name", "Square2_Y");

% --- Square 3 Obstacle ---
x0_sq3 = 2.29;  y0_sq3 = 0.10;  side_sq3 = 0.5;
x_sq3_v = [x0_sq3 - side_sq3/2, x0_sq3 + side_sq3/2, x0_sq3 + side_sq3/2, x0_sq3 - side_sq3/2, x0_sq3 - side_sq3/2];
y_sq3_v = [y0_sq3 - side_sq3/2, y0_sq3 - side_sq3/2, y0_sq3 + side_sq3/2, y0_sq3 + side_sq3/2, y0_sq3 - side_sq3/2];
t_sq3_v = linspace(0,1,numel(x_sq3_v));
t_sq3_i = linspace(0,1,numPts_sq);
x_sq3 = interp1(t_sq3_v, x_sq3_v, t_sq3_i);
y_sq3 = interp1(t_sq3_v, y_sq3_v, t_sq3_i);
xSq3TS = timeseries(x_sq3', time_sq, "Name", "Square3_X");
ySq3TS = timeseries(y_sq3', time_sq, "Name", "Square3_Y");

% --- Line 1 Obstacle ---
x_line1_v = [-1.64, 1.02];
y_line1_v = [0.11, 0.11];
t_line1_v = linspace(0,1,numel(x_line1_v));
t_line1_i = linspace(0,1,numPts_line);
x_line1 = interp1(t_line1_v, x_line1_v, t_line1_i);
y_line1 = interp1(t_line1_v, y_line1_v, t_line1_i);
xLine1TS = timeseries(x_line1', time_line, "Name", "Line1_X");
yLine1TS = timeseries(y_line1', time_line, "Name", "Line1_Y");

% --- Line 2 Obstacle ---
x_line2_v = [-1.64, 1.02];
y_line2_v = [-1.65, -1.65];
t_line2_v = linspace(0,1,numel(x_line2_v));
t_line2_i = linspace(0,1,numPts_line);
x_line2 = interp1(t_line2_v, x_line2_v, t_line2_i);
y_line2 = interp1(t_line2_v, y_line2_v, t_line2_i);
xLine2TS = timeseries(x_line2', time_line, "Name", "Line2_X");
yLine2TS = timeseries(y_line2', time_line, "Name", "Line2_Y");

% --- Circle Obstacle ---
x0_circ = 2.29;  y0_circ = 0.10;  r_circ = 0.8;
theta = linspace(0, 2*pi, numPts_circ);
x_circ = x0_circ + r_circ * cos(theta);
y_circ = y0_circ + r_circ * sin(theta);
xCircTS = timeseries(x_circ', time_circ, "Name", "Circle_X");
yCircTS = timeseries(y_circ', time_circ, "Name", "Circle_Y");

% --- Save all to MAT file
save('XYDataObstacles.mat', ...
    'xSq1TS', 'ySq1TS', ...
    'xSq2TS', 'ySq2TS', ...
    'xSq3TS', 'ySq3TS', ...
    'xLine1TS', 'yLine1TS', ...
    'xLine2TS', 'yLine2TS', ...
    'xCircTS', 'yCircTS');

disp('Interpolated obstacle timeseries data saved to XYDataObstacles.mat');
