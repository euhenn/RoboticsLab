function [hat]=id_cal(q_m,w_m,Ts,t,unwarp,calibration)
    N_samples = size(q4id, 1) - 1;

    if unwarp==1
        q_m(:,3)=unwarp(q_m(:,3));
    end

    if calibration==0

        [PHI, Y] = get_phi_reg(q_m, w_m, T_s);
        delta_X = Y(1:N_samples);
        delta_Y = Y(N_samples+1:2*N_samples);
        delta_theta = Y(2*N_samples+1:3*N_samples);
        % compute unconstrained solution
        w_unconstrained_hat = (PHI'*PHI)\PHI'*Y;
        r_unconstrained_hat = w_unconstrained_hat(1);
        d_unconstrained_hat = w_unconstrained_hat(1)/w_unconstrained_hat(2);
        % compute constrained solution
        w_constr_hat = lsqlin(PHI,Y,[],[],[],[],[0,0]);
        r_constr_hat = w_unconstrained_hat(1);
        d_constr_hat = w_unconstrained_hat(1)/w_unconstrained_hat(2);
        % compute estimate
        Y_unconstrained_hat = PHI*w_unconstrained_hat;
        delta_X_unconstrained_hat = Y_unconstrained_hat(1:N_samples);
        delta_Y_unconstrained_hat = Y_unconstrained_hat(N_samples+1:2*N_samples);
        delta_theta_unconstrained_hat = Y_unconstrained_hat(2*N_samples+1:3*N_samples);

    else

        % set initial value
        offset_0 = 0;
        % setup objective function (function of orientation offset)
        f_SE = @(w) get_SE_id_and_calibration(q_m, w_m, T_s, w);
        % optimize the offset with nonlinear opt
        offset_hat = fminsearch(f_SE,offset_0);
        % compute [r, r/d, x_off*r/d, y_off*r/d] estimates
        [PHI_cal, Y] = get_phi_reg_calibration(q_m, w_m, T_s, offset_hat);
        w_cal_hat = lsqlin(PHI_cal,Y,[],[],[],[],[0,0, -inf, -inf]);
        r_cal_hat = w_cal_hat(1);
        d_cal_hat = w_cal_hat(1)/w_cal_hat(2);
        x_off_cal_hat = w_cal_hat(3)/w_cal_hat(2);
        y_off_cal_hat = w_cal_hat(4)/w_cal_hat(2);
        % compute estimates
        Y_cal_hat = PHI_cal*w_cal_hat;
        delta_X_cal_hat = Y_cal_hat(1:N_samples);
        delta_Y_cal_hat = Y_cal_hat(N_samples+1:2*N_samples);
        delta_theta_cal_hat = Y_cal_hat(2*N_samples+1:3*N_samples);

    end
%da finire

    %plot meausre
    figure()
    subplot(2,1,1)
    plot(q_m(:,2), q_m(:,1), 'LineWidth', 3, 'Color','k')
    grid on;
    subplot(2,1,2)
    plot(t(2:end), w_m(2:end,1), 'LineWidth', 3, 'Color','b')
    hold on
    plot(t(2:end), w_m(2:end,2), 'LineWidth', 3, 'Color','r')
    grid on;
end