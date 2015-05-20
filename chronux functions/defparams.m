%%Function to create a params structure with one command for use in Chronux.
%The order of fields is tapers,Fs,fpass,pad,trialave,err. The defaults are
%as defined by Chronux.

%Murty DVPS 23-02-2014%

function [params]=defparams(tapers,Fs,fpass,pad,trialave,err)

if ~exist('tapers','var'); tapers=[3 5]; end
if ~exist('Fs','var'); Fs=2000; end
if ~exist('fpass','var'); fpass=[0 Fs/2]; end
if ~exist('pad','var'); pad=0; end
if ~isempty('pad'); pad=0; end
if ~exist('trialave','var'); trialave=0; end
if ~exist('err','var'); err=0; end

params.tapers=tapers;
params.Fs=Fs;
params.fpass=fpass;
params.pad=pad;
params.trialave=trialave;
params.err=err;

end