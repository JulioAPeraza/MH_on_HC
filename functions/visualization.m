function visualization(temperature, m_mean, sus, sus_max, T_C)

    %% Magnetization vs Temperature
    figure;
    plot(temperature, m_mean);
    
    %% Susceptibility vs Temperature 
    figure;
    tick1 = round(sus_max,-1)/10;
    tick2 = round(max(temperature),1)/10;
    plot(temperature,sus,'b',T_C,sus_max,'ro',[T_C T_C],[0 sus_max],'k--',...
        'MarkerEdgeColor','none',...
        'MarkerFaceColor','r');
        %legpos = 'SE';
        axis([min(temperature) max(temperature) 0 sus_max])
        set(gca,'FontSize',12,'YLim',[0 sus_max],'YTick',[0:tick1:sus_max sus_max],...
        'XLim',[min(temperature) max(temperature)],'XTick',(0:tick2:max(temperature)), 'DataAspectRatio',[1,1,1]);
        xlabel('Control Parameter (T)','fontweight','bold','FontSize',12);
        ylabel('Susceptibility','fontweight','bold','FontSize',12);    
        daspect([max(temperature) sus_max 1])

end
