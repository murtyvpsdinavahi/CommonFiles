function [Sp,t,f] = rawspecgramc(Data,TimeVals,ParamsStructure,blRange,WinStep,Fs,plotHandle)

    if isempty(Data); error('No Data Available'); end
    if isempty(TimeVals); error('No Time Vals available'); end
    if isempty(ParamsStructure); ParamsStructure = defparams; end
    if isempty(blRange); blRange = [TimeVals(1) 0]; end
    if ~exist('Fs','var'); Fs=2000; end
    if ~exist('WinStep','var'); WinStep = 0.01; end
    
    for r=1:size(Data,1)
    
        N = round(Fs*diff(blRange)); 
        blPos= find(TimeVals>=blRange(1),1) + (1:N);
        movingwin = [diff(blRange) WinStep];

        [S,t,fTin] = mtspecgramc(Data(r,:)',movingwin,ParamsStructure);
%         [SBL] = mtspectrumc((Data(r,blPos))',ParamsStructure);
      
        SubTin=S;
        
        if (r==1)
            SubTsum=SubTin;
            fSum=fTin;
        else
            SubTsum=SubTsum+SubTin;
            fSum=fSum+fTin;
        end
    end
    
    SubT=SubTsum/size(Data,1);
    Sp = SubT';
    f=fSum/size(Data,1);
        
    if ~exist('plotHandle')
        figure; title('Raw power spectrum'); hold on;
        pcolor(t+TimeVals(1),f,log10(SubT')); shading interp;
        axis tight;
        ylim([0 100]);
        hold on; xlabel('Time(s)'); ylabel('Frequency(Hz)');
        hold off;
    else
        title(plotHandle,'Raw power spectrum'); 
        pcolor(plotHandle,t+TimeVals(1),f,log10(SubT')); shading (plotHandle,'interp');
        axis (plotHandle,'tight');
        ylim(plotHandle,ParamsStructure.fpass);
        xlabel(plotHandle,'Time(s)'); ylabel(plotHandle,'Frequency(Hz)');        
end