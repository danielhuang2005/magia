function magia_visualize_fit_patlak(Ki,intercept,x,Y,k,roi_labels,results_dir)

fit_dir = sprintf('%s/fits',results_dir);
if(~exist(fit_dir,'dir'))
    mkdir(fit_dir);
end

for i = 1:size(Y,1)
    y = Y(i,:);
    yy = intercept(i) + Ki(i)*x;
    
    fig = figure('Visible','Off','Position',[100 100 700 400]);
    
    plot(x,y,'ko'); hold on;
    plot(x(k),y(k),'ro');
    plot(x(k),yy(k),'r');
    
    xlabel('\int_0^t C_p(\tau) d\tau / C_p(t) (min)');
    ylabel('\int_0^t C_t(\tau) d\tau / C_t(t) (min)');
    title(roi_labels{i});
    a = annotation('textbox', [0.6 0.13 0.1 0.1], 'String',...
        sprintf('K_i = %.5f; intercept = %.2f',round(Ki(i),5),round(intercept(i),2)));
    set(a,'Color','k','LineStyle','none','FontSize',12);
    
    img_name = sprintf('%s/%s.png',fit_dir,roi_labels{i});
    print('-noui',img_name,'-dpng');
    close(fig);
end

end