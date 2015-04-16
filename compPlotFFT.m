function compPlotFFT(component1,component2,NormFlag) 
    figure(200);
    subplot(211);
    plot(component1); hold on; plot(component2,'r--');
    legend('component1','component2');
    hold off;
    subplot(212);
    plot(component1 - component2,'k');

    comp1fft = (abs(fft(component1)))';
    comp2fft = (abs(fft(component2)))';
    if NormFlag==1
        comp1fft = comp1fft/max(comp1fft);
        comp2fft = comp2fft/max(comp2fft);
    end
    comp1fftIndex = find(comp1fft> 1e-5);
    comp2fftIndex = find(comp2fft> 1e-5);
    compDiff = setdiff(comp1fftIndex,comp2fftIndex);
    
    if ~isempty(compDiff), error('Unequal number of frequencies'); end
    
    for i=1:(length(comp1fftIndex)/2)
        figure(201);
        subplot(211);
        plot(comp1fft(comp1fftIndex(i,1),1),'b*'); hold on; plot(comp2fft((comp2fftIndex(i,1)),1),'r*');
        legend('component1','component2');
        hold off;
        subplot(212);
        plot((comp1fftIndex(i,1)),comp1fft((comp1fftIndex(i,1)),1) - comp2fft((comp2fftIndex(i,1)),1),'k*');
        pause
    end
end