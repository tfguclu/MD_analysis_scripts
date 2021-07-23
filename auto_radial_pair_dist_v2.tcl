set filelist [glob *_eq.pdb]
set sortedfilelist [lsort -dictionary $filelist]
foreach file $sortedfilelist {
set filewhext [file rootname $file]
mol new $file

mol addfile "${filewhext}.dcd" type {dcd} waitfor all
set strmolid [molinfo top]
set sel1 [atomselect top "chain A and name CB"]
set sel2 [atomselect top "chain A and name CB"]
set outputname ${filewhext}_radial_dist_only_prot.dat
# hbonds calculation loop
#hbonds -sel1 $sel1 -sel2 $sel2 -plot "no" -writefile "yes" -outfile $outputname
#measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 0 selupdate 0 first 1 last -1 step 1


#calculate g(r)
set gr [measure gofr $sel1 $sel2 delta .1 rmax 10 usepbc 0 selupdate 0 first 1 last -1 step 1]

#set up the outfile and write out the data
set outfile [open $outputname w]

set r [lindex $gr 0]
set gr2 [lindex $gr 1]

set i 0
foreach k $gr2 {
   puts $outfile "$k"
}

close $outfile

mol delete all
}
