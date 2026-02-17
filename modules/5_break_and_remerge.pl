# Module: 5_break_and_remerge.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 2548-3570, procedural code only)

################################ 4th Step begins here##########################

break_big_blocks();



# This subroutines checks whether the input marker belongs to any block








#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut4');
my $testOut4_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut4" : "testOut4";
open(WR,">$testOut4_file");

$len = @new_info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$new_info[$p_mname]\t$new_info[$q_bchr]\t$new_info[$r_hchr]\t$new_info[$m_st]\t$new_info[$n_ed]\t$new_info[$i_num]\t$new_info[$j_fl]\t$new_info[$i_newnm]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;

##############Merge Nors separated by singletons
merge_nors_sep_by_sing(); #print WR2 "Data is being analyzed4\n";
#######################  end of Merge Nors separated by singletons

############# Merge Nors separated by small blocks
# This section is executed only if $block_size !=0
if ($block_size!=0){merge_nors_sep_small_blocks();}
#print WR2 "Data is being analyzed6\n";







# checks whether the input block is smaller than the block size. If yes returns 1 else returns 0



#######################  end of Merge Nors separated by small blocks

merge_blocks_sep_by_singl(); #print WR2 "Data is being analyzed8\n";
################## Merge consecutive overlapping blocks#########

$numeles = @ref; $w=0; $x=1; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($x < $numeles)
{ 
 $rcoords1 = $ref[$w]->[0]; $rchrms1 = $ref[$w]->[1]; $rnam1 = $ref[$w]->[2];
 $rcoords2 = $ref[$x]->[0]; $rchrms2 = $ref[$x]->[1]; $rnam2 = $ref[$x]->[2];
 
 @coords1 =@$rcoords1; @coords2 = @$rcoords2; 
 @chrs1 = @$rchrms1; @chrs2 = @$rchrms2;  #print "unitepart:@chrs1\n";
 @coords1_srt=sort{$a<=>$b}(@coords1);  @coords2_srt=sort{$a<=>$b}(@coords2);
 $num1_Unite = @coords1; $num2_Unite = @coords2;
 
 @out1 = find_coords2(\@coords1,\@coords2); $numc1=@coords1; $numc2=@coords2;
 $bchrA1 = $chrs1[0]; $bchrB1 = $chrs2[0]; 
 $hchrA1 = $chrs1[1]; $hchrB1 = $chrs2[1];

# $startA1 = $out1[0] ; $startB1 = $out1[0+5]; 
# $endA1 = $out1[1]; $endB1 =$out1[1+5];
# $startA21 = $out1[3] ; $startB21 = $out1[3+5]; 
# $endA21 = $out1[4]; $endB21 =$out1[4+5]; 
 $segA1 = $w+1 ; $segB1 = $x+1; 
# $dirA1 = $out1[2] ;$dirB1 = $out1[2+5]; 
 $dirA1 = getOrien(@coords1); $dirB1 = getOrien(@coords2); 

  if($dirA1 eq "Up" )
 {
	$startA1 = $coords1_srt[0] ;  	$endA1 = $coords1_srt[-1]; 
	$startA21 = $coords1_srt[1] ;	$endA21 = $coords1_srt[-2];  
 }
 elsif($dirA1 eq "Down")
 {
	$startA1 = $coords1_srt[-1] ;  	$endA1 = $coords1_srt[0]; 
	$startA21 = $coords1_srt[-2] ;	$endA21 = $coords1_srt[1];  
 }
 else
 {
	$startA1 = $coords1_srt[0] ;  	$endA1 = $coords1_srt[-1]; 
	$startA21 = $coords1_srt[1] ;	$endA21 = $coords1_srt[-2];  
 }


if($dirB1 eq "Up")
 {
	$startB1 = $coords2_srt[0] ;  	$endB1 = $coords2_srt[-1]; 
	$startB21 = $coords2_srt[1] ;	$endB21 = $coords2_srt[-2];  
 }
 elsif($dirB1 eq "Down")
 {
	$startB1 = $coords2_srt[-1] ;  	$endB1 = $coords2_srt[0]; 
	$startB21 = $coords2_srt[-2] ;	$endB21 = $coords2_srt[1];  
 }
 else
 {
	$startB1 = $coords2_srt[0] ;  	$endB1 = $coords2_srt[-1]; 
	$startB21 = $coords2_srt[1] ;	$endB21 = $coords2_srt[-2];  
 }



 #print "cons ovp bl:@$rnam1\n@$rnam2\ncoords1:@coords1\ncoords2:@coords2\ndirs: $dirA1 $dirB1 ends: $endA1  $endA21 starts: $startB1 $startB21\n\n";
# print WR2 "Data is being analyzed9\n";
 
   
 if(($bchrA1 eq $bchrB1)&&($hchrA1 eq $hchrB1)&&($dirA1 ne "None")&&($dirB1 ne "None") ) # &&(!(isSg(@coords1)))&&(!(isSg(@coords2))))
{

   if(($dirA1 eq "Up")&&($dirB1 eq "Up")&&($endA1 >= $startB1)&&($endA1<=$endB1)) # merge consc overlapping blocks
   { #print "$endA1 > $startB1 $endA1<$endB1\n";
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU;# make new small reference
    $num_t = @ref; #print "Before $num_t\n";
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update            
    $num_t = @ref; #print "After $num_t\n";
   }
   elsif(($dirA1 eq "Down")&&($dirB1 eq "Down")&&($endA1 <= $startB1)&&($endA1>=$endB1)) # merge consc overlapping blocks
   {
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU;# make new small reference 
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update            
   
   }
   elsif( (($startA1 <= $startB1)&&($startA1<=$endB1)&&($endA1 >= $startB1)&&($endA1>=$endB1)) ||
	  (($endA1 <= $startB1)&&($endA1<=$endB1)&&($startA1 >= $startB1)&&($startA1>=$endB1)) )# merge consc full block and its sub block
   {
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU;# make new small reference 
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update            
   }
   elsif( (($startB1 <= $startA1)&&($startB1<=$endA1)&&($endB1 >= $startA1)&&($endB1>=$endA1)) ||
          (($endB1 <= $startA1)&&($endB1<=$endA1)&&($startB1 >= $startA1)&&($startB1>=$endA1)) )# merge consc sub block and the full block
   {
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU;# make new small reference 
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update            
   }
   
 } #1st if   
 
 
     $w+=1; $x +=1;
 } #while

#print WR2 "Data is being analyzed10 \n";
#assign numbers to @info with information in @ref

$numeles = @ref; $w=0; $y=0; %coords_hash=(); my %labeled=(); #print "Begin $numeles\n";
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrmsZ = $ref[$w]->[1]; $rnam = $ref[$w]->[2]; 
 @coords =@$rcoords;  @chrs = @$rchrmsZ; #print "$w.@chrs\n";
 $y++; 
# print "$y. chrs=@chrs coords=@coords\n @$rnam\n\n";
 #print WR2 "Data is being analyzed11\n";
 #put the above coords in a hashmap
 foreach $el(@$rnam){
 # if($coords[0]==17362979){print "$el  ";}
 $coords_hash{$el}=1;
 }
 #print "y=$y\n";
 $len = @info;
 $q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7;
 while($i_newnm < $len)
 {
  $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
  $cstart = $info[$m_st]; $cnum = $info[$i_num];
  #print "$cb_chr=$chrs[0] $ch_chr=$chrs[1]\t";  print "$coords_hash{$cstart}\t";
 if((($coords_hash{$info[$q_bchr-1]}==1)||($cstart=~/\s+/))&&($cb_chr eq $chrs[0])&&($ch_chr eq $chrs[1]))
  {
   $info[$i_num] = $y; #print "$info[$i_num] = $y\n\n";
  }
  
  $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

 } #while

 %coords_hash=(); # make hashmap available for next set of coords
 $w+=1;
} #outer while


# change numbers of microsatellites
$len = @info;
$q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7; $pnum=1;
while($i_newnm < $len)
{
 $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
 $cstart = $info[$m_st]; $cnum = $info[$i_num];
 #print "$cb_chr=$chrs[0] $ch_chr=$chrs[1]\t";  print "$coords_hash{$cstart}\t";
 #print WR2 "Data is being analyzed12\n";
 if($cstart =~ /\s+/)
 {
  $info[$i_num] = $pnum; $cnum=$pnum; #print "cstart=$cstart\t";
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

} #while




#################### end merging consc overlp blocks

merge_blocks_sep_by_singl(); #print WR2 "Data is being analyzed13\n";

#$numeles = @ref; $w=0; 
#while($w < $numeles)
#{ 
 #Take coords of a segment/block
# $rcoords = $ref[$w]->[0]; $rchrmsZ = $ref[$w]->[1]; $rnam = $ref[$w]->[2];
# $num_Brt=@$rcoords;
 
# print "After bls sep Singls before break bl: chrs=@$rchrmsZ $num_Brt coords=@$rcoords\n @$rnam\n\n";
 
# $w+=1;
#}

######################Break blocks with subovp blocks
merge_blocks_sep_by_smal(); #print WR "merge_blocks_sep_by_smal() done\n";
break_blocks_with_subovp();#print WR "break_blocks_with_subovp() done\n";
merge_nors(); #print WR "merge_nors() done\n";


1;
