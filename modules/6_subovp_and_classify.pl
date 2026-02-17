# Module: 6_subovp_and_classify.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 3567-5060, procedural code only)

merge_blocks_sep_by_smal(); #print WR "merge_blocks_sep_by_smal() done\n";
break_blocks_with_subovp();#print WR "break_blocks_with_subovp() done\n";
merge_nors(); #print WR "merge_nors() done\n";

%mark_hash=();






#######################end Break blocks with subovp blocks
merge_cons_blocks(); #print WR "merge_cons_blocks() done\n";
merge_cons_blocks(); #print WR "merge_cons_blocks() twice done\n";
merge_blocks_sep_by_singl(); #print WR "merge_blocks_sep_by_singl() thrice done\n";
################ Merge blocks separated by singletons
################################################################################
# Merge blocks with 2 marker singletons if they are separated by singletons
merge_blocks_with_sing_sep_by_singl(); #print WR "merge_blocks_with_sing_sep_by_singl() done\n";


#########Merge blocks sep by small blocks
merge_blocks_sep_by_smal(); #print WR "merge_blocks_sep_by_smal() twice done\n";
####### end
########Merge blocks smaller than $block_size with neighbouring blocks###################

$numelesSl = @ref; $wSl=0; $xSl=1; $ySl=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($xSl < $numelesSl)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Sl = $ref[$wSl]->[0]; $rchrms1Sl = $ref[$wSl]->[1]; $rnam1Sl = $ref[$wSl]->[2];
 $rcoords2Sl = $ref[$xSl]->[0]; $rchrms2Sl = $ref[$xSl]->[1]; $rnam2Sl = $ref[$xSl]->[2];
 $rcoords3Sl = $ref[$ySl]->[0]; $rchrms3Sl = $ref[$ySl]->[1]; $rnam3Sl = $ref[$ySl]->[2];

 @coords1Sl =@$rcoords1Sl; @coords2Sl = @$rcoords2Sl; @coords3Sl = @$rcoords3Sl;

 @coords1Sl_srt = sort{$a <=> $b}(@coords1Sl); @coords2Sl_srt = sort{$a <=> $b}(@coords2Sl); @coords3Sl_srt = sort{$a <=> $b}(@coords3Sl);

 @chrs1Sl = @$rchrms1Sl; @chrs2Sl = @$rchrms2Sl;  @chrs3Sl = @$rchrms3Sl;

 $len_bl1 = abs($coords1Sl_srt[0]- $coords1Sl_srt[-1]);
 $len_bl2 = abs($coords2Sl_srt[0]- $coords2Sl_srt[-1]);
 $len_bl3 = abs($coords3Sl_srt[0]- $coords3Sl_srt[-1]);

 # get the orientations of the 3 blocks
 $orA = getOrien(@coords1Sl); $orB = getOrien(@coords2Sl); $orC = getOrien(@coords3Sl);

 #sort blocks 1 and 3 depending on its orientations
 if($orA eq "Up"){ @coords1Sl_srt = sort{$a <=> $b}(@coords1Sl);}
 elsif($orA eq "Down"){@coords1Sl_srt = sort{$b <=> $a}(@coords1Sl);}
 else{@coords1Sl_srt = @coords1Sl;}

 if($orB eq "Up"){ @coords2Sl_srt = sort{$a <=> $b}(@coords2Sl);}
 elsif($orB eq "Down"){@coords2Sl_srt = sort{$b <=> $a}(@coords2Sl);}
 else{@coords2Sl_srt = @coords2Sl;}

 if($orC eq "Up"){ @coords3Sl_srt = sort{$a <=> $b}(@coords3Sl);}
 elsif($orC eq "Down"){@coords3Sl_srt = sort{$b <=> $a}(@coords3Sl);}
 else{@coords3Sl_srt = @coords3Sl;}

 #get start and end of blocks 1 and 3
 $startASl = $coords1Sl_srt[0]; $endASl = $coords1Sl_srt[-1];
 $startBSl = $coords2Sl_srt[0]; $endBSl = $coords2Sl_srt[-1];
 $startCSl = $coords3Sl_srt[0]; $endCSl = $coords3Sl_srt[-1];

 #print WR2 "Data is being analyzed19\n";
 #print "c1: $coords1Nr[0] c2: $coords2Nr[0] c3: $coords3Nr[0] \n";
 #print "small blocks: crds1:@coords1Sl\ncrds2:@coords2Sl\ncrds3:@coords3Sl\n";
 #print "@$rnam1Nr\n c1: @coords1Nr \nc2: $coords2Nr[0] c3: $coords3Nr[0] \n";



 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 my $subovpFound12 = subovp_blocksM_found2(\@coords1Sl,\@coords2Sl,$chrs1Sl[0],$chrs1Sl[1]); 
 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 my $subovpFound23 = subovp_blocksM_found2(\@coords2Sl,\@coords3Sl,$chrs2Sl[0],$chrs2Sl[1]); 

 my $isSmallA = isSmall(@coords1Sl); my $isSmallB = isSmall(@coords2Sl); my $isSmallC = isSmall(@coords3Sl); 
  
 $tmp_nor= closerBl($startASl,$endASl,$startBSl,$endBSl,$startCSl,$endCSl,$chrs1Sl[0],$chrs2Sl[0],$chrs3Sl[0],$chrs1Sl[1],$chrs2Sl[1],$chrs3Sl[1]);
 # print "merge bl_size: @$rnam1Sl\n@$rnam2Sl\n@$rnam3Sl\nc1: @coords1Sl\nc2: @coords2Sl\nc3: @coords3Sl\n$orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\n\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   #($orB eq "Nor")&&($orA eq "Nor") 
       ($isSmallB)
    && ((closerBl($startASl,$endASl,$startBSl,$endBSl,$startCSl,$endCSl,$chrs1Sl[0],$chrs2Sl[0],$chrs3Sl[0],$chrs1Sl[1],$chrs2Sl[1],$chrs3Sl[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
    && (abs($startBSl-$endASl)<abs($startBSl-$startASl)) #means nearest end of block1 is closest
    && ($chrs1Sl[0] eq $chrs2Sl[0])&&($chrs1Sl[1] eq $chrs2Sl[1]))
 { 
  @temp =();push(@temp,@coords1Sl,@coords2Sl);  my @coordsUSl=@temp; my @chrsUSl = @chrs1Sl; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Sl,@$rnam2Sl);  my @namesUSl=@tempnm;
  my @srefUSl = (); $srefUSl[0]=\@coordsUSl; $srefUSl[1]=\@chrsUSl; $srefUSl[2]= \@namesUSl; # make new small reference for the merged coords
  my $rsrefUSl= \@srefUSl; # make new reference    
  splice(@ref,$xSl,1,$rsrefUSl); # Replace contents at position xA1
  splice(@ref,$wSl,1); # Delete contents at position wAl
  $numelesSl--; $wSl--; $xSl--; $ySl--; # replace and update 

 # splice(@ref,$wSl,2,$rsrefUSl); $numelesSl--; $wSl--; $xSl--; $ySl--; # replace and update  
 } #if nors 
   # conditions b/n B and C starts here
 elsif( #($orB eq "Nor")&&($orC eq "Nor") 
       ($isSmallB)
   &&  ((closerBl($startASl,$endASl,$startBSl,$endBSl,$startCSl,$endCSl,$chrs1Sl[0],$chrs2Sl[0],$chrs3Sl[0],$chrs1Sl[1],$chrs2Sl[1],$chrs3Sl[1]))==23)
   &&  ( !($subovpFound23) )   # if no sub blocks in between
   &&  (abs($endBSl-$startCSl)<abs($endBSl-$endCSl)) #means nearest end of block2 is closest
   &&  ($chrs3Sl[0] eq $chrs2Sl[0])&&($chrs3Sl[1] eq $chrs2Sl[1])
      )
 {
  @temp =();push(@temp,@coords2Sl,@coords3Sl);  my @coordsUSl=@temp; my @chrsUSl = @chrs3Sl; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Sl,@$rnam3Sl);  my @namesUSl=@tempnm;
  my @srefUSl = (); $srefUSl[0]=\@coordsUSl; $srefUSl[1]=\@chrsUSl; $srefUSl[2]= \@namesUSl; # make new small reference for the merged coords
  my $rsrefUSl= \@srefUSl; # make new reference    
  splice(@ref,$ySl,1,$rsrefUSl); # Replace contents at position yS1
  splice(@ref,$xSl,1); # Delete contents at position xSl
 # splice(@ref,$xSl,2,$rsrefUSl); $numelesSl--; $wSl--; $xSl--; $ySl--; # replace and update  
 }

if(($xSl != $ySl-1) ||($wSl != $xSl-1))
 {
  $xSl= $ySl-1;
  $wSl= $xSl-1;  
 }
 else
 {$wSl +=1; $xSl +=1; $ySl +=1;}
 ($wSl,$xSl,$ySl)=iterate2($wSl,$xSl,$ySl,$numelesSl);

} #while
#print WR "end of Merge blocks smaller than $block_size with neighbouring blocks\n";                                                                                       

########### end of Merge blocks smaller than $block_size with neighbouring blocks ######

#########Merge blocks smaller than $block_size separated by singletons with neighbouring blocks###################

$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($xNr < $numelesNr)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Nr = $ref[$wNr]->[0]; $rchrms1Nr = $ref[$wNr]->[1];  $rnam1Nr = $ref[$wNr]->[2];
 $rcoords2Nr = $ref[$xNr]->[0]; $rchrms2Nr = $ref[$xNr]->[1];  $rnam2Nr = $ref[$xNr]->[2];
 $rcoords3Nr = $ref[$yNr]->[0]; $rchrms3Nr = $ref[$yNr]->[1];  $rnam3Nr = $ref[$yNr]->[2];

 @coords1Nr =@$rcoords1Nr; @coords2Nr = @$rcoords2Nr; @coords3Nr = @$rcoords3Nr;
 @chrs1Nr = @$rchrms1Nr; @chrs2Nr = @$rchrms2Nr;  @chrs3Nr = @$rchrms3Nr;

 # get the orientations of the 3 blocks
 $orA = getOrien(@coords1Nr); $orB = getOrien(@coords2Nr); $orC = getOrien(@coords3Nr);

 #sort blocks 1 and 3 depending on its orientations
 if($orA eq "Up"){ @coords1Nr_srt = sort{$a <=> $b}(@coords1Nr);}
 elsif($orA eq "Down"){@coords1Nr_srt = sort{$b <=> $a}(@coords1Nr);}
 else{@coords1Nr_srt = @coords1Nr;}
 if($orC eq "Up"){ @coords3Nr_srt = sort{$a <=> $b}(@coords3Nr);}
 elsif($orC eq "Down"){@coords3Nr_srt = sort{$b <=> $a}(@coords3Nr);}
 else{@coords3Nr_srt = @coords3Nr;}

 #get start and end of blocks 1 and 3
 $startANr = $coords1Nr_srt[0]; $endANr = $coords1Nr_srt[-1];
 $startBNr = $coords2Nr[0];     $endBNr = $coords2Nr[-1];
 $startCNr = $coords3Nr_srt[0]; $endCNr = $coords3Nr_srt[-1];

 my $isSmallA = isSmall(@coords1Nr); my $isSmallB = isSmall(@coords2Nr); my $isSmallC = isSmall(@coords3Nr); 

 my $startANr = $coords1Nr_srt[0]; my $endANr = $coords1Nr_srt[-1];
 my $startBNr = $coords2Nr[0];     my $endBNr = $coords2Nr[-1];
 my $startCNr = $coords3Nr_srt[0]; my $endCNr = $coords3Nr_srt[-1];

 #print "@$rnam1Nr\n c1: @coords1Nr \nc2: $coords2Nr[0] c3: $coords3Nr[0] \n\n";
 #print "begin\n";
 #print WR2 "Data is being analyzed20\n";
 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 
 #print "end\n"; 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it
if(   #($orB eq "Nor")&&($orA eq "Nor") 
       ($isSmallB)
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
    && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1])
  )
 {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update     
 
 } #if nors 

   # conditions b/n B and C starts here
 elsif( #($orB eq "Nor")&&($orC eq "Nor") 
       ($isSmallB)
   &&  ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&  ( !($subovpFound23) )   # if no sub blocks in between
   &&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&  ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1])
      )
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }

  $wNr= $xNr;  
  $xNr= $yNr;
  $yNr= $xNr+1;

  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  while($numCNr==1 and $yNr<$numelesNr)
  {
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }

} #while

###########end 
#print WR "End of Merge blocks smaller than $block_size separated by singletons with neighbouring blocks\n";

  ###### Classify Singletons############

#Algorithm:

# Take a singleton and see if this can become part of atleast one block with atleast 2 markers in it.
# Becoming part means: The singleton can be jumped into the block.
# If yes then delete it from the @ref. 
# By deleting it i am marking it to be labelled as "out-of-place" during the "assign numbers to @info" part.

$numelesCy = @ref; $wCy=0; 
while($wCy < $numelesCy)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoordsCy = $ref[$wCy]->[0]; $rchrmsCy = $ref[$wCy]->[1]; 
 @coordsCy =@$rcoordsCy; @chrsCy = @$rchrmsCy; 
 
 $numMrkrsCy = @coordsCy; # number of markers in the block 
 #print "Classify: @coordsCy\n\n";
 #print WR2 "Data is being analyzed21\n";
 if($numMrkrsCy==1) # to see if this is a single marker block
 {
  
   #print "@coordsCy\n";
  if(part_of_diffBlock(@coordsCy,@chrsCy))
  {  
   
   splice(@ref,$wCy,1); #delete the singleton(unwanted) at position wCy
          $numelesCy--; $wCy--; # update
   } # inner if
  
 } #if
 $wCy +=1; #increments the index of the array @ref
} #while
#print WR "classify singletons done \n";
# Takes singleton as input and checks if that belongs to any other block




  ##### end classifying singletons##############################################
#empty numbers column in @info
$len = @info;
$i_num=5; $i_newnm = 7;
while($i_newnm < $len)
{
 
 $info[$i_num] = 0; #assign 0 to all 
  
 $i_num+= 8; $i_newnm+=8;

} #while

#assign numbers to @info with information in @ref

$numeles = @ref; $w=0; $y=0; %coords_hash=(); %labeled=(); my $ins_check=0;
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrmsZ = $ref[$w]->[1];  $rnam = $ref[$w]->[2];
 @coords =@$rcoords;  @chrs = @$rchrmsZ; #print "$w.@chrs\n";
 $nm_coords = @coords;  my $check_sg=0; my $check_sg2=0;
 $y++; 
 #print "assign nums:$y. chrs=@chrs coords=@coords\n @$rnam\n\n";
 #print WR2 "Data is being analyzed22\n";
 #put the above coords in a hashmap
 foreach $el(@$rnam){

 $coords_hash{$el}=1; #print WR2 "Data is being analyzed22a\n";
 }
 #print "y=$y\n";
 $len = @info;
 $q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7;
 while($i_newnm < $len)
 {
  $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
  $cstart = $info[$m_st]; $cnum = $info[$i_num];
  #print "$cb_chr=$chrs[0] $ch_chr=$chrs[1]\t";  print "$coords_hash{$cstart}\t"; 
  #print WR2 "Data is being analyzed23\n";

  if((($coords_hash{$info[$q_bchr-1]}==1)||($cstart=~/\s+/))&&($cb_chr eq $chrs[0])&&($ch_chr eq $chrs[1])&&($coords[0]=~/^\d\d*/))
  {  $check_sg2=1; #if($info[$q_bchr-1] eq "CL330446" ) {print "out $cstart\t$ch_chr\t$y\n";}       #print "out $info[$q_bchr-1]\t$cstart\t$ch_chr\t$y\n";	#print "@coords\n\n";
    if($nm_coords == 1) {   $info[$i_num] = "Singleton"; $y--;    } 
	#elsif(($nm_coords == 2)&&(abs($coords[0]-$coords[1])<$distBnMrks)) {  $info[$i_num] = "Singleton";    } 
	#if 2 marker block with less than threshold distance in between
		#if it is part of different block
			#it is out-of-place marker
		#elseif it is a independent block
			# define it as HSB. In other words don't delete.
		#elseif it is present inside another foreign HSB and it can exit out according to the thresholds
			# define it as HSB
		#elsif it cannot exit out, define it as singletons.
	elsif(($nm_coords == 2)&&(abs($coords[0]-$coords[1])<$distBnMrks)) 
	{	#print WR2 "coords: @coords\n\n"; open(WR2,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/logfile');
		$ins_check = indp(@$rnam); #if($$rnam[0] eq "CT154272") {print "@coords indp: $ins_check\n";}
		if(part_of_diffBlock($coords[0],@chrs) and part_of_diffBlock($coords[1],@chrs) ) {   $info[$i_num] = "out-of-place";  $check_sg=1;    }  
		elsif($ins_check==1) {$info[$i_num] = $y; } #if it is a indp block
		elsif($ins_check==2){$info[$i_num] = $y; } #it is present inside another foreign HSB and it CAN exit out according to the thresholds
		elsif($ins_check==0){$info[$i_num] = "Singleton";$check_sg=1; } #it is present inside another foreign HSB and it CANNOT exit out according to the thresholds
	}

	else{$info[$i_num] = $y;      } #print "$info[$i_num] = $y\n\n";
  }
  
  $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

 } #while

 %coords_hash=(); # make hashmap available for next set of coords
 if($check_sg==1){$y--;}
 if($check_sg2==0){$y--;}
 $w+=1;
} #outer while


# change numbers of microsatellites
$len = @info;
$q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7; $pnum=1;
while($i_newnm < $len)
{
 $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
 $cstart = $info[$m_st]; $cnum = $info[$i_num]; #print WR2 "Data is being analyzed24\n";
 if($cstart =~ /\s+/)
 {
  $info[$i_num] = $pnum; $cnum=$pnum;#print "here\t";
 }
 elsif($info[$i_num]==0 and $info[$i_num] ne "Singleton") # this means it is an unwanted singleton
 {
  $info[$i_num]="out-of-place"; #if($cstart==82524445){print "marker deleted\n";}
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

} #while
#print WR "change numbers done \n";


# This doesn't remove singletons from the subblocks list. This is the difference.
# The above said difference doesn't exist anymore.













################ end merging blocks separated by singletons
close WR;

1;
