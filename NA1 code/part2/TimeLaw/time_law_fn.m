function [s, s_dot] = time_law_fn(t,total_time,mode)
s=0;
s_dot=0;
if mode==1%if mode =1 costasnt time law else trapezoidal
    s_dot = 1/total_time;
    s=t/total_time;
else
    Ta=0.1*total_time;% acceleration/dec time 10% of total
    Tc=total_time-2*Ta;%time of costant time

    Vc=1/(Ta+Tc);% velocità costante
    a=Vc/Ta;% acceleration
    switch 1 %formula on the slide
        case t<Ta
            s_dot=a*t;
            s=(a*(t^2))/2;

        case (t>=Ta)&&(t<(Tc+Ta))
            s_dot=Vc;
            s=(a*(Ta^2))/2+Vc*(t-Ta);

        case (t>=(Tc+Ta))&&(t<(Tc+2*Ta))
            s_dot=Vc-a*(t-Ta-Tc);
            s=(a*(Ta^2))/2+Vc*Tc+Vc*(t-Ta-Tc)-a*(t-Ta-Tc)^2/2;

        case t>=(Tc+2*Ta)
            s_dot=0;
            s=1;
    end

end