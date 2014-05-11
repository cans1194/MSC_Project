%function for modulation of ook
function [xn_noise_if, sigpow] = ook_modulate(n, fs, sps, fif, sd)
	%random binary sequence
	data = randi([0 1], n, 1);
	
	xn = rectpulse(data, sps);
	
	%build time sequence
	t = 0:1/fs:(length(xn)/fs-1/fs);
	%transpose time sequence to obtain column vector
	t = t';
	
	%mix to low intermediate frequency, fif
	xn = real(xn.*exp(i*2*pi*fif*t));

	%generate noise sequence
	nn = sd*randn(length(xn),1);
	%add noise to received signal
	xn_noise_if = xn + nn;
	%calculate signal power for this sample
	sigpow = mean((xn).^2);
end
	
	
	