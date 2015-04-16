function compPlot(component1,component2,NormFlag) 
    figure(100);
    subplot(321);
    plot(component1); hold on; plot(component2,'r--');
    legend('component1','component2');
    hold off;
    subplot(323);
    plot(component1 - component2,'k');
    
    coR = xcorr(component1,component2);
    xAx=(1:(length(coR))) - ceil(length(coR)/2);
    subplot(325);
    plot(xAx,coR);

    comp1fft = abs(fft(component1));
    comp2fft = abs(fft(component2));
    if NormFlag==1
        comp1fft = comp1fft/max(comp1fft);
        comp2fft = comp2fft/max(comp2fft);
    end
    subplot(322);
    plot(comp1fft); hold on; plot(comp2fft,'r--');
    legend('component1','component2');
    hold off;
    subplot(324);
    plot(comp1fft - comp2fft,'k');
end