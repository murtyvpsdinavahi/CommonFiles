%%Function to plot the change in power of a raw spectrum from that of a specified baseline period.
%This function uses the mtspecgramc and mtspectrumc of Chronux toolbox.
%
%'Data' is the data for which the spectrum is to be plotted.
%
%'TimeVals' is the Time period of the data observed.
%
%'ParamsStructure' is the params structure required by the Chronux
%toolbox. the parameters of the params structure have to be defined
%seperately before running this function.
%
%'blRange' is the range of the baseline period in seconds.
%
%'WinStep' is the step size of the moving window as defined by the second
%element in the movingwin parameter in Chronux. This is input optional. Default
%is 0.01.
%
%'Fs' is the sampling frequency. This input is optional. Default is taken
%to be 2000 Hz.
%
%plotHandle is an optional input argument to pass on axis_handles for display of
%the colour plot. If this parameter is not passed, the plot will be created
%in a new figure.

%% Revision history
%Created by Murty V P S Dinavahi 23-02-2014
%Modified by Murty V P S Dinavahi on 15-09-2014 to add averaging of power
%spectra across trials
%Modified by Murty V P S Dinavahi on 18-10-2014 to add plotHandle option
%%

function pchangespecgramc(Data,TimeVals,ParamsStructure,blRange,WinStep,Fs,plotHandle)

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
        [SBL] = mtspectrumc((Data(r,blPos))',ParamsStructure);
      
        SubTin=bsxfun(@rdivide,S,SBL');
        
        if (r==1)
            SubTsum=SubTin;
            fSum=fTin;
        else
            SubTsum=SubTsum+SubTin;
            fSum=fSum+fTin;
        end
    end
    
    SubT=SubTsum/size(Data,1);
    f=fSum/size(Data,1);
        
    if ~exist('plotHandle')
        figure; title('Change in power spectrum from baseline power'); hold on;
        pcolor(t+TimeVals(1),f,log10(SubT')); shading interp;
        axis tight;
        ylim([0 100]);
        hold on; xlabel('Time(s)'); ylabel('Frequency(Hz)');
        hold off;
    else
        title(plotHandle,'Change in power spectrum from baseline power'); 
        pcolor(plotHandle,t+TimeVals(1),f,log10(SubT')); shading (plotHandle,'interp');
        axis (plotHandle,'tight');
        ylim(plotHandle,ParamsStructure.fpass);
        xlabel(plotHandle,'Time(s)'); ylabel(plotHandle,'Frequency(Hz)');        
end