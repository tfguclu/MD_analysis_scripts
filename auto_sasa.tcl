package require autopsf

set filelist [glob *.pdb]
set sortedfilelist [lsort -dictionary $filelist]
foreach file $sortedfilelist {
set filewhext [file rootname $file]
mol new $file

mol addfile "${filewhext}.dcd" type {dcd} waitfor all
set strmolid [molinfo top]
set sel [atomselect top "chain A"]
set protein [atomselect top "all"]
set n [molinfo top get numframes]
set output [open "${filewhext}_sasa_whole_prot.dat" w]
# sasa calculation loop
for {set i 0} {$i < $n} {incr i} {
	molinfo top set frame $i
	set sasa [measure sasa 1.4 $protein -restrict $sel]
	puts "\t \t progress: $i/$n"
	puts $output "$sasa"
}
puts "\t \t progress: $n/$n"
puts "Done."	
puts "output file: ${filewhext}_sasa.dat"
close $output
mol delete all
}
