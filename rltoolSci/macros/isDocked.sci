// SOFTWARE  : Scilab >= 5.4
// AUTHOR (c): Samuel Gougeon, Le Mans - France
// FUNCTION  : isDocked()
// VERSION   : 1.0
// RELEASE   : 2015-06-07
// LICENSE   : CeCILL-B => http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.html
// DISTRIB.  : http://fileexchange.scilab.org/toolboxes/360000
// HISTORY   :
//   2010-08-15: Creation
//   2013-04-27: +checking that handles are of Figure type. vectorization added.
//   2015-06-07: 
//      + documentation as heading comments. 
//      + the new f.dockable atribute is now tested
//      + vector or matrix of handles were not correctly handled.
//      + First release on FileExchange.
//
// DISCLAIMER: This toolbox is provided as is, with NO WARRANTY of any kind.
//   Use it to your own risks & responsability.

function yn = isDocked(fh)
//
// Tests whether a (set of) graphical figure is docked to Scilab desktop
//
// CALLING SEQUENCES
//      isDocked     // displays this help
// yn = isDocked(fh)
//
// PARAMETERS
// fh: figure's handle or matrix of figures handles
// yn: boolean or matrix of booleans, with the sizes of fh
//
// DESCRIPTION
// yn(i) is set to %T (true) if fh(i) is a figure docked to the Scilab IDE. 
//  It is set to %F otherwise.
// isDocked(..) allows avoiding to reset figures properties such that
//  .figure_position, .figure_size and .axes_size that all affect the
//  whole Scilab desktop when the related figure is docked.
//
// EXAMPLE
// clf
// plot2d()
// // Then please dock this figure by hand
// f = gcf();
// if ~isDocked(f), f.figure_size = [700,650], end
//
// // Now unexpectedly resizing the whole desktop:
// s = f.figure_size;
// f.figure_size = [900,800];  // :(
// // Restoring the desktop's size
// f.figure_size = s;
//
// // With a matrix of handles... Creating a new undocked figure:
// f2 = scf(); surf()
// isDocked([f f2 ; f2 f])
//
// SEE ALSO
// * http://bugzilla.scilab.org/11476
//
// HISTORY 
//   2010-08-15: Creation
//   2013-04-27: Checking that handles are of Figure type. vectorization added.
//   2015-06-07: Improvements. Bugs fixed. First release on FileExchange.
//
	fname = "isDocked"

    // DISPLAYING some inline HELP
    if argn(2)==0 then
        head_comments(fname)
        yn = []
        return
    end
    
    // CHECK INPUT PARAMETERS
	if argn(2)~=1
		msg = gettext("%s: Wrong number of input argument(s): %d expected.\n")
		error(msprintf(msg, fname, 1))
	elseif type(fh)~=9 | or(fh.type~="Figure")
		msg = gettext("%s: Input argument #%d must be a matrix of handles on figures.\n")
		error(msprintf(msg, fname, 1))
	end

    // PROCESSING
    sf = size(fh)
    fh = fh(:)
	fs = matrix(fh.figure_size,2,-1)'
    as = matrix(fh.axes_size,2,-1)'

    yn = (fh.dockable=="on" & ((fs(:,1)-as(:,1)) > 20)')
   // A test on vertical dimensions is more complicated (toolbar on/off,
   //  menubar deleted...)
    yn = matrix(yn, sf)
endfunction
