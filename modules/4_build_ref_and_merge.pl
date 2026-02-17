# Module: 4_build_ref_and_merge.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 1600-2550, procedural code only)

#######make ref array
make_ref_array();

# this subroutine removes crds2 from crds1

# this subroutine removes names2 from names1


$numeles = @ref; $w=0; 
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrmsZ = $ref[$w]->[1]; $rnam = $ref[$w]->[2];
 
 #print "chrs=@$rchrmsZ coords=@$rcoords\n @$rnam\n\n";
 
 $w+=1;
}

######end making
#assign_numbers();
#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut2b');
my $testOut2b_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut2b" : "testOut2b";
open(WR,">$testOut2b_file");

$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;

$numeles = @ref; $w=0; $x=0; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($x < $numeles)
{ 
 $rcoords1 = $ref[$x]->[0]; 
 $rmn = $ref[$x]->[2]; 
 
 @coords1 =@$rcoords1; 
 @mn = @$rmn;
 $len = @coords1;
 for(my $i=0; $i<$len; $i++)
 {
  # $xl=$x+1;
  # print "$xl\t$mn[$i]\t$coords1[$i]\n"; #print "coords2=@coords2\n\n";
 }
 $x+=1;
} #while


################# Merge Nors("3-marker inversion rule") with blocks closer than the distant######
merge_nors();
merge_nors_sep_by_sing();

















################ end merging consc Nors

###############Unite blocks############
merge_cons_blocks();
merge_blocks_sep_by_singl();


# This checks if this is a two marker singleton and if either block 1 or the next block <=2mbp. if yes returns 1 else returns 0
# if it is not a two marker singleton, it returns 1


#assign numbers to @info with information in @ref
assign_numbers();

#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut3');
my $testOut3_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut3" : "testOut3";
open(WR,">$testOut3_file");

$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;


################################ 4th Step begins here##########################

break_big_blocks();

1;
