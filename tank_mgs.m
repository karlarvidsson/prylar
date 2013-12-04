clear all; close all; clc

PLOT_END = 100;


% HMG
hmg_maxdamage = 50;
hmg_mindamage = 38;
hmg_dropoff_start = 15;
hmg_dropoff_end = 75;
hmg_x = (1:hmg_dropoff_end - hmg_dropoff_start-1);
hmg_dropoff = hmg_maxdamage - (hmg_maxdamage - hmg_mindamage) / (hmg_dropoff_end - hmg_dropoff_start) .* hmg_x;
hmg_x1 = [0 hmg_dropoff_start]';
hmg_y1 = [hmg_maxdamage hmg_maxdamage]';
hmg_x2 = [hmg_dropoff_end PLOT_END]';
hmg_y2 = [hmg_mindamage hmg_mindamage]';

hmg_X = [hmg_x1; (hmg_x+hmg_dropoff_start)'; hmg_x2];
hmg_Y = [hmg_y1; hmg_dropoff'; hmg_y2];

subplot(4,1,1);
plot(hmg_X, hmg_Y);
ylim([hmg_mindamage-1; hmg_maxdamage+1]);
set(gca,'YTick', (hmg_mindamage-1:2:hmg_maxdamage+1));
set(gca,'XTick', (0:5:PLOT_END));



% LMG
lmg_maxdamage = 20;
lmg_mindamage = 15.9;
lmg_dropoff_start = 8;
lmg_dropoff_end = 50;

lmg_x = (1:lmg_dropoff_end - lmg_dropoff_start-1);
lmg_dropoff = lmg_maxdamage - (lmg_maxdamage - lmg_mindamage) / (lmg_dropoff_end - lmg_dropoff_start) .* lmg_x;
lmg_x1 = [0 lmg_dropoff_start]';
lmg_y1 = [lmg_maxdamage lmg_maxdamage]';
lmg_x2 = [lmg_dropoff_end PLOT_END]';
lmg_y2 = [lmg_mindamage lmg_mindamage]';

lmg_X = [lmg_x1; (lmg_x+lmg_dropoff_start)'; lmg_x2];
lmg_Y = [lmg_y1; lmg_dropoff'; lmg_y2];


subplot(4,1,2);
plot(lmg_X, lmg_Y);
ylim([lmg_mindamage-1; lmg_maxdamage+1]);
set(gca,'YTick', (lmg_mindamage-1:1:lmg_maxdamage+1));
set(gca,'XTick', (0:5:PLOT_END));
%grid on;


% TTK HMG

hmg_velocity = 500;
hmg_time_per_meter = 1/hmg_velocity;
hmg_rof = 300;
hmg_btk = ceil(100 ./ hmg_Y);
hmg_time_per_round = 1/(hmg_rof/60);

hmg_ttk = (hmg_btk-1) .* hmg_time_per_round + (hmg_X * hmg_time_per_meter);

subplot(4,1,3);
plot(hmg_X, hmg_ttk);
set(gca,'YTick', (0:0.2:hmg_ttk(length(hmg_ttk))));
set(gca,'XTick', (0:5:PLOT_END));


% TTK HMG

lmg_velocity = 610;
lmg_time_per_meter = 1/lmg_velocity;
lmg_rof = 650;
lmg_btk = ceil(100 ./ lmg_Y);
lmg_time_per_round = 1/(lmg_rof/60);

lmg_ttk = (lmg_btk-1) .* lmg_time_per_round + (lmg_X * lmg_time_per_meter);

subplot(4,1,4);
plot(lmg_X, lmg_ttk);
set(gca,'YTick', (0:0.2:lmg_ttk(length(lmg_ttk))));
set(gca,'XTick', (0:5:PLOT_END));

subplot(4,1,1);
title('HMG damage'), xlabel('range'), ylabel('damage');
subplot(4,1,2)
title('LMG damage'), xlabel('range'), ylabel('damage');
subplot(4,1,3);
title('HMG TTK'), xlabel('range'), ylabel('ms');
subplot(4,1,4);
title('LMG TTK'), xlabel('range'), ylabel('ms');



% Data table

disp('HMG');
disp('     range    damage     ttk     btk');
for i=1:length(hmg_X)
    disp([hmg_X(i) hmg_Y(i) hmg_ttk(i) hmg_btk(i)])
end
disp('LMG');
disp('     range    damage     ttk     btk');
for i=1:length(lmg_X)
    disp([lmg_X(i) lmg_Y(i) lmg_ttk(i) lmg_btk(i)])
end

disp('Total damage in one burst');
disp('HMG (6 sec mag size)');
disp('    range   damage');
disp([hmg_X hmg_rof/60 * 6 * hmg_Y]);
disp('LMG (6 sec mag size)');
disp('    range   damage');
disp([lmg_X lmg_rof/60 * 3.5 * lmg_Y]);