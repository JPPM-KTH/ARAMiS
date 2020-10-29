function [f_dBA]=dB_to_dBA(freq,f_dB)



for ii=1:length(freq)
    R(ii)=(12200^2 * freq(ii)^4)/( (freq(ii)^2 + 20.6^2) * (freq(ii)^2 + 12200^2) *sqrt( (freq(ii)^2 + 107.7^2)*(freq(ii)^2 + 737.9^2) ) );
    A(ii)=2+20*log10(R(ii));
    f_dBA(ii)=f_dB(ii)+A(ii)
end

