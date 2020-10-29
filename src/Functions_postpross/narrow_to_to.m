% function [one_third_freq,band] = one_third_octave(frequencies,measurements)
%
% Narrow bands to one-third octave bands representation.
%
% Example: [one_third_freq_preferred,band] = narrow_to_one_third_octave(frequencies,alpha_diffuse)
%
% The input parameters are:
% o frequencies: frequency values 
%   (with a fixed of variable frequency step),
% o measurements: acoustic absorption coefficent values
%   (corresponding to the frequency vector defined above). 
%
% The output parameters are:
% o one_third_freq: center frequencies of 1/3 octave bands,
% o bands: values of the acoustic absorption coefficent in 1/3 bands
%
% Copyleft 2007-2011 luc.jaouen@matelys.com
% cf. APMR on the web,
% Standards/OctaveBands.html
% for more information


function [one_third_freq_preferred,bands] = narrow_to_to(frequencies,measurements)

  one_third_freq_preferred = [16 20 25  31.5 40 50 63 80 100 125 160 200 250 ...
                    315 400 500 630 800 1000 1250 1600 2000 2500 ...
                    3150 4000 5000 6300 8000 10000 12500 16000 20000];

  % Determine lower and upper limits of each 1/3 octave band
  one_third_freq = zeros(1,length(one_third_freq_preferred));
  one_third_bands = zeros(2,length(one_third_freq_preferred));
  for a = 1:length(one_third_freq_preferred),
  	one_third_freq(a) = (1000*((2^(1/3)))^(a-19));
    one_third_bands(1,a) = one_third_freq(a)/2^(1/6); 
    one_third_bands(2,a) = one_third_freq(a)*2^(1/6);
  end

  % Compute the acoustic absorption coefficient per 1/3 octave band
  for a = 1:size(one_third_bands,2),
    bands(a) = 0;
    idx = find( frequencies >= one_third_bands(1,a) ...
		& frequencies < one_third_bands(2,a) );
    % If we have no 'measurement' point in this band:
    if ( length(idx) == 1 )
      bands(a) = measurements(idx);
    % If we have more than 1 'measurement' point in this band:
    elseif ( length(idx) > 1 )
      for b = 1:length(idx)-1,
	bands(a) = bands(a) + ...
		  ( frequencies(idx(1)+b)-frequencies(idx(1)+b-1) ) * ...
		  abs( measurements(idx(1)+b)+measurements(idx(1)+b-1) ) / 2;
      end
      bands(a) = bands(a) / ( frequencies(idx(length(idx)))-frequencies(idx(1)) );
    end
  end
end


