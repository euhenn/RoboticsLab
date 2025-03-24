function [s, s_dot] = time_law_fn(t,total_time,mode)
    s=zeros(1,length(t));
    s_dot=zeros(1,length(t));
    if mode==1%if mode =1 costasnt time law else trapezoidal
        s_dot = 1/total_time*ones(length(t));
        s=t./total_time;
    else
        Ta=0.1*total_time;% acceleration/dec time 10% of total
        Tc=total_time-2*Ta;%time of costant time
    
        Vc=1/(Ta+Tc);% velocità costante
        a=Vc/Ta;% acceleration
        
        % case t<Ta
        start_ind=1;
        end_ind=find(t>=Ta,1)-1;
        t_int=t(start_ind:end_ind);

        s_dot(start_ind:end_ind)=a*t_int;
        s(start_ind:end_ind)=(a*(t_int.^2))/2;
         
        % case (t>=Ta)&&(t<(Tc+Ta))
        start_ind=find(t>=Ta,1);
        end_ind=find(t>=(Ta+Tc),1)-1;
        t_int=t(start_ind:end_ind);

        s_dot(start_ind:end_ind)=Vc;
        s(start_ind:end_ind)=(a*(Ta^2))/2+Vc*(t_int-Ta);

        % case (t>=(Tc+Ta))&&(t<(Tc+2*Ta))
        start_ind=find(t>=(Ta+Tc),1);
        end_ind=find(t>=(Tc+2*Ta),1)-1;
        t_int=t(start_ind:end_ind);

        s_dot(start_ind:end_ind)=Vc-a*(t_int-Ta-Tc);
        s(start_ind:end_ind)=(a*(Ta^2))/2+Vc*Tc+Vc*(t_int-Ta-Tc)-a*(t_int-Ta-Tc).^2/2;
     
        % case t>=(Tc+2*Ta)
        start_ind=find(t>=(Tc+2*Ta),1);
        end_ind=length(t);
        
        
        s_dot(start_ind:end_ind)=0;
        s(start_ind:end_ind)=1;
        

    end
end