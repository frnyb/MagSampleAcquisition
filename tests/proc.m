%% Load data
mag_data = importdata('lab3.txt');
mag_data = mag_data.data;

mag0_samples = mag_data(:,13:15);
mag0_ts = mag_data(:,1:3);
mag0_times = zeros(size(mag0_ts));

mag1_samples = mag_data(:,16:18);
mag1_ts = mag_data(:,4:6);
mag1_times = zeros(size(mag1_ts));

mag2_samples = mag_data(:,19:21);
mag2_ts = mag_data(:,7:9);
mag2_times = zeros(size(mag2_ts));

mag3_samples = mag_data(:,22:24);
mag3_ts = mag_data(:,10:12);
mag3_times = zeros(size(mag3_ts));

%% Compute time

for i=1:length(mag0_times(:,1))
    if (i == 1)
        mag0_times(i,1) = 0;
    else
        mag0_times(i,1) = mag0_times(i-1,1) + mag0_ts(i,1) * 10^(-8);
    end
    
    mag0_times(i,2) = mag0_times(i,1) + mag0_ts(i,2) * 10^(-8);
    mag0_times(i,3) = mag0_times(i,1) + mag0_ts(i,3) * 10^(-8);
    
    mag1_times(i,1) = mag0_times(i,1) + mag1_ts(i,1) * 10^(-8);
    mag1_times(i,2) = mag0_times(i,1) + mag1_ts(i,2) * 10^(-8);
    mag1_times(i,3) = mag0_times(i,1) + mag1_ts(i,3) * 10^(-8);
    
    mag2_times(i,1) = mag0_times(i,1) + mag2_ts(i,1) * 10^(-8);
    mag2_times(i,2) = mag0_times(i,1) + mag2_ts(i,2) * 10^(-8);
    mag2_times(i,3) = mag0_times(i,1) + mag2_ts(i,3) * 10^(-8);
    
    mag3_times(i,1) = mag0_times(i,1) + mag3_ts(i,1) * 10^(-8);
    mag3_times(i,2) = mag0_times(i,1) + mag3_ts(i,2) * 10^(-8);
    mag3_times(i,3) = mag0_times(i,1) + mag3_ts(i,3) * 10^(-8);
end

%% Concatenate data
mag_times = zeros(length(mag0_times(:,1)), 12);
mag_samples = zeros(length(mag0_times(:,1)), 12);

mag_times(:,1:3) = mag0_times;
mag_times(:,4:6) = mag1_times;
mag_times(:,7:9) = mag2_times;
mag_times(:,10:12) = mag3_times;

mag_samples(:,1:3) = mag0_samples;
mag_samples(:,4:6) = mag1_samples;
mag_samples(:,7:9) = mag2_samples;
mag_samples(:,10:12) = mag3_samples;

%% Find min-max-diff
max_vals = -inf*ones(12,1);
min_vals = inf*ones(12,1);

for i=1:12
    for j=1:length(mag_samples(:,i))
        if (mag_samples(j,i) > max_vals(i)) 
            max_vals(i) = mag_samples(j,i);
        end
        
        if (mag_samples(j,i) < min_vals(i))
            min_vals(i) = mag_samples(j,i);
        end
    end
end

diffs = max_vals - min_vals;

%% Find phase
[max_diff, phase_ref_idx] = max(diffs);

max_time = mag_times(end, phase_ref_idx);
min_time = mag_times(1, phase_ref_idx);

max_point_offsets = [];
idx = 1;

while true
    next_time = min_time + 1/50;
    
    if (next_time > max_time)
        break;
    end
    
    one_period_idx = find(mag_times(idx:end,phase_ref_idx) < next_time);
    
    last_idx = one_period_idx(end) + idx - 1;
    
    one_period = mag_samples(idx:last_idx, phase_ref_idx);
    one_period_times = mag_times(idx:last_idx, phase_ref_idx);
    
    [max_val, max_idx] = max(one_period);
    
    max_idx = max_idx + idx - 1;
    
    max_val_time = mag_times(max_idx, phase_ref_idx);
    
    max_time_offset = max_val_time - min_time + mag_times(1, phase_ref_idx);
    
    max_point_offsets = [max_point_offsets;max_time_offset];
    
    min_time = next_time;
    idx = last_idx + 1;    
end

avg_offset = mean(max_point_offsets);

phase = (avg_offset/(1/50)) * 2*pi;

%% LLS
n_samples = length(mag_samples(:,1));

A = zeros(n_samples*12, 12+12);
b = zeros(n_samples*12, 1);

for i=1:12
    offset_idx = i;
        
    for j=1:n_samples
        idx = (i-1)*n_samples+j;
        A(idx, offset_idx) = 1;
        
        A(idx,12+i) = sin(2*pi*50*mag_times(j,i)+phase);
        
        b(idx) = mag_samples(j,i);
    end
end

x = (A'*A)\A'*b;

est_offsets = x(1:12);
est_amplitudes = x(13:24);

%% Plot data
% subplot(4,1,1);
% hold on;
% plot(mag0_times(:,1), mag0_samples(:,1));
% plot(mag0_times(:,2), mag0_samples(:,2));
% plot(mag0_times(:,3), mag0_samples(:,3));
% legend('x','y','z');
% hold off;
% 
% subplot(4,1,2);
% hold on;
% plot(mag1_times(:,1), mag1_samples(:,1));
% plot(mag1_times(:,2), mag1_samples(:,2));
% plot(mag1_times(:,3), mag1_samples(:,3));
% legend('x','y','z');
% hold off;
% 
% subplot(4,1,3);
% hold on;
% plot(mag2_times(:,1), mag2_samples(:,1));
% plot(mag2_times(:,2), mag2_samples(:,2));
% plot(mag2_times(:,3), mag2_samples(:,3));
% legend('x','y','z');
% hold off;
% 
% subplot(4,1,4);
% hold on;
% plot(mag3_times(:,1), mag3_samples(:,1));
% plot(mag3_times(:,2), mag3_samples(:,2));
% plot(mag3_times(:,3), mag3_samples(:,3));
% legend('x','y','z');
% hold off;

for i=1:4
    subplot(4,1,i);
    hold on;
    
    for j=1:3
        plot_times = [mag_times(1,(i-1)*3+j):0.00001:mag_times(end,(i-1)*3+j)];
        plot(mag_times(:,(i-1)*3+j), mag_samples(:,(i-1)*3+j));
        plot(plot_times, est_offsets((i-1)*3+j)+est_amplitudes((i-1)*3+j).*sin(2*pi*50.*plot_times+phase));
    end
    
    legend("x","x est", "y","y est","z","z est");
    
    hold off;
end


