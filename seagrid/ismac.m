function theResult = ismac

% ismac -- is this computer a Macintosh?
%  ismac (no argument) returns TRUE if
%   the present computer is a Macintosh.
 
% svn $Id$
%=======================================================================
% Copyright (C) 1999 Dr. Charles R. Denham, ZYDECO.
%  All Rights Reserved.
%   Disclosure without explicit written consent from the
%    copyright owner does not constitute publication.
%=======================================================================
 
% Version of 21-May-1999 14:46:29.

c = computer;

result = all(c(1:2) == 'MA');

if nargout > 0
	theResult = result;
else
	disp(result)
end
