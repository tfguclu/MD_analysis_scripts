set filelist [glob *.pdb]
set sortedfilelist [lsort -dictionary $filelist]
foreach file $sortedfilelist {
set filewhext [file rootname $file]
mol new $file

mol addfile "${filewhext}.dcd" type {dcd} waitfor all
set strmolid [molinfo top]
set sel1 [atomselect top "chain A"]
set sel2 [atomselect top "chain B or chain P"]
set outputname ${filewhext}_hbonds.dat
# hbonds calculation loop
hbonds -sel1 $sel1 -sel2 $sel2 -plot "no" -writefile "yes" -outfile $outputname

mol delete all
}
