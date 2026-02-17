# 0_subs.pl - All subroutine definitions
# Auto-generated from synteny_assign_v3_80_genes.pl
# Contains 106 subroutine definitions

# --- sub check_gapbnmrkers (original lines 181-198) ---
sub check_gapbnmrkers {

my(@cds3) = @_;
my(@sort_cds3) = sort{$a <=> $b}(@cds3);

$pcd = ""; $c3 =1;
foreach $cd(@sort_cds3){

 if($pcd ne "")
 {
  $c3 = 0 if ( ($pcd-$cd) >= 1000000 );
 }
 $pcd = $cd;
} #foreach

if($c3==1){return(1);}elsif($c3==0){return(0);}

}

# --- sub mrkConsis (original lines 200-209) ---
sub mrkConsis {

@o1 = find_coords(@coords1);@o3 = find_coords(@coords3);

if( ($coords2[0]>min_num($o1[1],$o3[0]))&&($coords[0]<max_num($o1[1],$o3[0]))
&& ($coords2[1]>min_num($o1[1],$o3[0]))&&($coords[1]<max_num($o1[1],$o3[0]))  )
{ return(1);}
else{ return(0);}

} #sub

# --- sub mrkConsisInv (original lines 211-222) ---
sub mrkConsisInv {

@o1 = find_coords(@coords1);@o3 = find_coords(@coords3);

# check if all the coords of middle block falls b/n top and bottom blocks
if( ($coords2[0]>min_num($o1[1],$o3[0]))&&($coords[0]<max_num($o1[1],$o3[0]))
&& ($coords2[1]>min_num($o1[1],$o3[0]))&&($coords[1]<max_num($o1[1],$o3[0]))
&& ($coords2[2]>min_num($o1[1],$o3[0]))&&($coords[2]<max_num($o1[1],$o3[0]))  )
{ return(1);}
else{ return(0);}

} #sub

# --- sub mrkConsis12 (original lines 225-239) ---
sub mrkConsis12 {

my(@srt_coords2)=();
@o1 = find_coords(@coords1);

# sort coords2 depending on the orientation of coords1
if($o1[2] eq "Up"){@srt_coords2 = sort{$a <=> $b}(@coords2);}
if($o1[2] eq "Down"){@srt_coords2 = sort{$b <=> $a}(@coords2);}
elsif($o1[2] eq "None"){@srt_coords2=@coords2;}

if( ($srt_coords2[0]>min_num($o1[1],$srt_coords2[1]))&&($srt_coords2[0]<max_num($o1[1],$srt_coords2[1])) )
{ return(1);}
else{ return(0);}

} #sub

# --- sub mrkConsis23 (original lines 241-254) ---
sub mrkConsis23 {

my(@srt_coords2)=();
@o3 = find_coords(@coords3);

if($o3[2] eq "Up"){@srt_coords2 = sort{$a <=> $b}(@coords2);}
if($o3[2] eq "Down"){@srt_coords2 = sort{$b <=> $a}(@coords2);}
elsif($o3[2] eq "None"){@srt_coords2=@coords2;}

if( ($srt_coords2[-1]>min_num($o1[0],$srt_coords2[-2]))&&($srt_coords2[-1]<max_num($o1[0],$srt_coords2[-2])) )
{ return(1);}
else{ return(0);}

} #sub

# --- sub check_chrSeq123 (original lines 257-263) ---
sub check_chrSeq123{

if(($chrms1[0] eq $chrms2[0])&&($chrms2[0] eq $chrms3[0])&&($chrms1[1] eq $chrms2[1])&&($chrms2[1] eq $chrms3[1]))
{return(1);}
else {return(0);}

}

# --- sub check_chrSeq12 (original lines 265-271) ---
sub check_chrSeq12{

if(($chrms1[0] eq $chrms2[0])&&($chrms1[1] eq $chrms2[1]))
{return(1);}
else {return(0);}

}

# --- sub check_chrSeq23 (original lines 273-279) ---
sub check_chrSeq23{

if(($chrms2[0] eq $chrms3[0])&&($chrms2[1] eq $chrms3[1]))
{return(1);}
else {return(0);}

}

# --- sub check_bldir (original lines 282-303) ---
sub check_bldir{

@ot1 = find_coords(@coords1);@ot3 = find_coords(@coords3);

$dir1=$ot1[2];    $dir3 = $ot3[2];
$start11=$ot1[0]; $start13=$ot3[0];
$start21=$ot1[3]; $start23=$ot3[3];

$end11=$ot1[1];   $end13=$ot3[1];
$end21=$ot1[4];     $end23=$ot3[4];

if( (($dir1 eq "Down")&&($dir3 eq "Down")&&(($end11 > $start13)||($end21 > $start23))) ||

 (($dir1 eq "Up")&&($dir3 eq "Up")&&(($end11 < $start13)||($end21 < $start23))) )
{
  #if($index==24){print "dir1=$dir1 dir3=$dir3\n";}
 return(1);}
else{
      #if($index==24){print "dir1=$dir1 dir3=$dir3\n";}
return(0);};

}

# --- sub find_coords2 (original lines 320-421) ---
sub find_coords2{
#my(@crdsA,@crdsB) = @_;
my($rcrdsA,$rcrdsB)=@_;
@crdsA=@$rcrdsA; @crdsB=@$rcrdsB;
#print "coords1=@crdsA\ncoords2=@crdsB\n";
@rep_crdsA = repair_crds(@crdsA); $num_crdsA = @rep_crdsA;
@crds_copyA = @rep_crdsA; $firstA = $crds_copyA[0]; $lastA = pop(@crds_copyA);

@rep_crdsB = repair_crds(@crdsB); $num_crdsB = @rep_crdsB;
@crds_copyB = @rep_crdsB; $firstB = $crds_copyB[0]; $lastB = pop(@crds_copyB);

my(@sorted_crdsA) = sort{$a <=> $b}(@rep_crdsA); #print "s crds1 = @sorted_crds\n";
$mnA = $sorted_crdsA[0]; $mn2A = $sorted_crdsA[1];
$mxA = pop(@sorted_crdsA); $mx2A = pop(@sorted_crdsA);

my(@sorted_crdsB) = sort{$a <=> $b}(@rep_crdsB); #print "s crds2 = @sorted_crds\n";
$mnB = $sorted_crdsB[0]; $mn2B = $sorted_crdsB[1];
$mxB = pop(@sorted_crdsB); $mx2B = pop(@sorted_crdsB);

# find how many ups and downs are there using Denis's procedure
 $upsA1 = 0; $downsA1 =0; $num_ds=@rep_crdsA;$i_d=0; $j_d = ($num_ds-1)-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 {  
  if($rep_crdsA[$i_d]<$rep_crdsA[$j_d]) {$upsA1++;}
  elsif($rep_crdsA[$i_d]>$rep_crdsA[$j_d]) {$downsA1++;}  
  $i_d++; $j_d=($num_ds-1)-$i_d; #updation  
 } #while

# find how many ups and downs are there using Denis's procedure
 $upsB1 = 0; $downsB1 =0; $num_ds=@rep_crdsB;$i_d=0; $j_d = ($num_ds-1)-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 { #if($rep_crdsB[0]==138135625){print "$rep_crdsB[$i_d] <> $rep_crdsB[$j_d] $upsB1 $downsB1\n"; }
  if($rep_crdsB[$i_d]<$rep_crdsB[$j_d]) {$upsB1++;}
  elsif($rep_crdsB[$i_d]>$rep_crdsB[$j_d]) {$downsB1++;}  
  $i_d++; $j_d=($num_ds-1)-$i_d; #updation  
 } #while
#if($rep_crdsB[0]==86879601){print"$upsB1 $downsB1\n";}
$upsA = 0; $downsA =0; $peleA=""; 
foreach $eleA(@rep_crdsA)
{
 if($peleA ne "")
 {
  if($peleA<$eleA) {$upsA++;}
  elsif($peleA>$eleA){$downsA++;}
 }
$peleA=$eleA;
}

$upsB = 0; $downsB =0; $peleB=""; 
foreach $eleB(@rep_crdsB)
{
 if($peleB ne "")
 {
  if($peleB<$eleB) {$upsB++;}
  elsif($peleB>$eleB){$downsB++;}
 }
$peleB=$eleB;
}

#Assign dirs using D's proc
$dirA ="N/A"; $dirB="N/A";
if($upsA1>$downsA1){$dirA = "Up";}
elsif($upsA1<$downsA1){$dirA = "Down";}
elsif(($upsA1==$downsA1)&&($upsA>$downsA)){$dirA = "Up";}
elsif(($upsA1==$downsA1)&&($upsA<$downsA)){$dirA = "Down";}

if($upsB1>$downsB1){$dirB = "Up";}
elsif($upsB1<$downsB1){$dirB = "Down";}
elsif(($upsB1==$downsB1)&&($upsB>$downsB)){$dirB = "Up";}
elsif(($upsB1==$downsB1)&&($upsB<$downsB)){$dirB = "Down";}

# Take the dir of the other block if ups and downs(not D's proc) of the block are same
if($upsA==$downsA){ $dirA=$dirB;} 
if($upsB==$downsB){ $dirB=$dirA;}

if($rep_crdsB[0]==31527597){ #print "A:$upsA $downsA dirA=$dirA B:$upsB $downsB dirB=$dirB\n";
#print "A1:$upsA1 $downsA1 B1:$upsB1 $downsB1\n";
#print "coordsA:@rep_crdsA\ncoordsB:@rep_crdsB\n"
}

if(($upsA==$downsA)&&($upsB==$downsB))
{
 if($firstA<$firstB) {$dirA="Up"; $dirB="Up";}
elsif($firstA>$firstB) {$dirA="Down"; $dirB="Down";}
}

#if($rep_crdsA[0]==45129102){print "A:$upsA $downsA dirA=$dirA B:$upsB $downsB dirB=$dirB\n";}
if($num_crdsA==1){$dirA="NoneA";}
if($num_crdsB==1){$dirB="NoneB";}

if($dirA eq "Up"){$stA = $mnA; $edA = $mxA; $st2A=$mn2A; $ed2A=$mx2A;}
elsif($dirA eq "Down"){$stA = $mxA; $edA = $mnA; $st2A = $mx2A; $ed2A = $mn2A;}
elsif($dirA eq "NoneA"){$stA = $mxA; $edA = $mnA; $st2A = $mx2A; $ed2A = $mn2A;}

if($dirB eq "Up"){$stB = $mnB; $edB = $mxB; $st2B=$mn2B; $ed2B=$mx2B;}
elsif($dirB eq "Down") {$stB = $mxB; $edB = $mnB; $st2B = $mx2B; $ed2B = $mn2B;}
elsif($dirB eq "NoneB"){$stB = $mxB; $edB = $mnB; $st2B = $mx2B; $ed2B = $mn2B;}

@ot = ($stA,$edA,$dirA,$st2A,$ed2A,$stB,$edB,$dirB,$st2B,$ed2B);

return (@ot);
}

# --- sub change_numbers2 (original lines 752-777) ---
sub change_numbers2 {

my($cr3,$cr,$chrr,$id)= @_;
@c3 = @$cr3; @crd = @$cr; 
if($id==1)
{push(@c3,@crd);}
else
{push(@crd,@c3);} #if ($c3[0]==30543455){print "@crd\n";}
$index +=4; # used in the prev part
my(%crdhash)=();

foreach $el(@c3){ $crdhash{$el}=1;} #make hashmap of coords
foreach $el(@crd){ $crdhash{$el}=1;}

$len = @info;
$q=1; $r=2; $m=3; $i =7;
while($i < $len)
{
 $bos_chr = $info[$q]; $hs_chr = $info[$r];
 $markcrd = $info[$m]; 

 if(($crdhash{$markcrd}==1)&&(($chrr->[0]) eq $bos_chr)&&(($chrr->[1]) eq $hs_chr)){  $info[$i-2]=$index; }

 $q += 8; $r+= 8; $m+=8; $i +=8;
}
} #sub

# --- sub jplocwnAll (original lines 796-986) ---
sub jplocwnAll{

my($cr1,$cr2,$cr3,$cr4,$cr5)=@_;
my(@crd3,@crd1,@crd2,@crd4,@crd5) = ();  my (@crd1_srt,@crd2_srt,@crd4_srt,@crd5_srt,@subBls)=(); my @condPos=();
@crd1 = @$cr1; @crd2 = @$cr2; @crd3 = @$cr3; @crd4 = @$cr4; @crd5 = @$cr5; $lensubBls=0;
@crd1cpy = @crd1; @crd2cpy = @crd2; @crd3cpy = @crd3; @crd4cpy = @crd4; @crd5cpy = @crd5;
my @jump_locs=(); #to save jumping locations

 # gets the direction of the block#print "$dircrd\n";
$dircrd1=(find_coords(@crd1))[2]; $dircrd2=(find_coords(@crd2))[2];
$dircrd4=(find_coords(@crd4))[2]; $dircrd5=(find_coords(@crd5))[2];


#sort blocks(main) depending on their direction
if($dircrd1 eq "Up"){@crd_srt1 = sort{$a <=> $b}(@crd1); } elsif($dircrd1 eq "Down"){@crd_srt1 = sort{$b <=> $a}(@crd1); }
elsif($dircrd1 eq "None"){@crd_srt1 = sort{$b <=> $a}(@crd1); }

if($dircrd2 eq "Up"){@crd_srt2 = sort{$a <=> $b}(@crd2); } elsif($dircrd2 eq "Down"){@crd_srt2 = sort{$b <=> $a}(@crd2); }
elsif($dircrd2 eq "None"){@crd_srt2 = sort{$b <=> $a}(@crd2); }

if($dircrd4 eq "Up"){@crd_srt4 = sort{$a <=> $b}(@crd4); } elsif($dircrd4 eq "Down"){@crd_srt4 = sort{$b <=> $a}(@crd4); }
elsif($dircrd4 eq "None"){@crd_srt4 = sort{$b <=> $a}(@crd4); }

if($dircrd5 eq "Up"){@crd_srt5 = sort{$a <=> $b}(@crd5); } elsif($dircrd5 eq "Down"){@crd_srt5 = sort{$b <=> $a}(@crd5); }
elsif($dircrd5 eq "None"){@crd_srt5 = sort{$b <=> $a}(@crd5); }

if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #checks chr sequence
{ 
 #add marker to the top of first block
 unshift(@crd1cpy,$crd3[0]);

 @subBls =find_sub_blocks2($chrms1[0],$chrms1[1],$crd1cpy[0],$crd1cpy[1]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd1cpy); @subBls = removeSingletons(@subBls); @subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; #if ($coords3[0]==29660153){print "TOP num of sub blocks =$lensubBls\n";} 
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; $condPos[0]=0;}else{@subBls=(); $lensubBls=0; 
 $condPos[0]=1; $jpdist=(blockDist(@crd1))+(blockDist(@crd2)); #print "jumpdist = $jpdist\n";
 if (($jpdist<=$jumping_dist)&&(special_condition_top(@crd1cpy)==1)) 
  {return(131);}
 }

 #remove the added marker
 shift(@crd1cpy);


 #add marker to the bottom of first block
 push(@crd1cpy,$crd3[0]);

 # check if there are any blocks breaking this position
 @subBls =find_sub_blocks2($chrms1[0],$chrms1[1],$crd1cpy[-1],$crd1cpy[-2]); 
 @subBls = filter_subBlsJ(\@subBls,\@crd1cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls;  
 if($lensubBls>1) # >1 means there are sub blocks
 {@subBls=(); $lensubBls=0; $condPos[1]=0;}else{@subBls=(); $lensubBls=0; $condPos[1]=1; $jpdist=(blockDist(@crd2));

 if(($jpdist<=$jumping_dist)&&(special_condition_bottom(@crd1cpy)==1))

 {return(132);}
 }

 #remove the added marker
 pop(@crd1cpy);

} #if chr seq

if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1]))
{
 #add marker to the top of second block
 unshift(@crd2cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms2[0],$chrms2[1],$crd2cpy[0],$crd2cpy[1]);
 @subBls = filter_subBlsJ(\@subBls,\@crd2cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1)
 {@subBls=(); $lensubBls=0;$condPos[2]=0;}else{@subBls=(); $lensubBls=0;$condPos[2]=1;$jpdist=(blockDist(@crd2));
 if(($jpdist<=$jumping_dist)&&(special_condition_top(@crd2cpy)==1))
 {return(231);}
 }

 #remove the added marker
 shift(@crd2cpy);


 #add marker to the bottom of second block
 push(@crd2cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms2[0],$chrms2[1],$crd2cpy[-1],$crd2cpy[-2]);
 @subBls = filter_subBlsJ(\@subBls,\@crd2cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1)
 {@subBls=(); $lensubBls=0;$condPos[3]=0;}else{@subBls=(); $lensubBls=0;$condPos[3]=1; 
  if(special_condition_bottom(@crd2cpy)==1)
  {return(232);}
 }

 #remove the added marker
 pop(@crd2cpy);

}

if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1]))
{
 #top of fourth block
 unshift(@crd4cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms4[0],$chrms4[1],$crd4cpy[0],$crd4cpy[1]);
 @subBls = filter_subBlsJ(\@subBls,\@crd4cpy);                            
 @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1){@subBls=(); $lensubBls=0;$condPos[4]=0;}
 else{ 
 @subBls=(); $lensubBls=0;$condPos[4]=1;
 if(special_condition_top(@crd4cpy)==1)
 {return(431);}
 } # else

 #remove the added marker
 shift(@crd4cpy);


 #bottom of fourth block
 push(@crd4cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms4[0],$chrms4[1],$crd4cpy[-1],$crd4cpy[-2]);
 @subBls = filter_subBlsJ(\@subBls,\@crd4cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1){@subBls=(); $lensubBls=0;$condPos[5]=0;}else{@subBls=(); $lensubBls=0;
 $condPos[5]=1;$jpdist=(blockDist(@crd4));
 if(($jpdist<=$jumping_dist)&&(special_condition_bottom(@crd4cpy)==1))
  { 
  return(432);}
 }

 #remove the added marker
 pop(@crd4cpy);

}

if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1]))
{

 #top of fifth block
 unshift(@crd5cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms5[0],$chrms5[1],$crd5cpy[0],$crd5cpy[1]);
 @subBls = filter_subBlsJ(\@subBls,\@crd5cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1){@subBls=(); $lensubBls=0;$condPos[6]=0;}else{@subBls=(); $lensubBls=0;
 $condPos[6]=1;$jpdist=(blockDist(@crd4));
 if(($jpdist<=$jumping_dist)&&(special_condition_top(@crd5cpy)==1))
 {return(531);}
 }

 #remove the added marker
 shift(@crd5cpy);


 #bottom of fifth block
 push(@crd5cpy,$crd3[0]);

 # check if there are any blocks(2,4,5) breaking this position
 @subBls =find_sub_blocks2($chrms5[0],$chrms5[1],$crd5cpy[-1],$crd5cpy[-2]);
 @subBls = filter_subBlsJ(\@subBls,\@crd5cpy); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 $lensubBls=@subBls; 
 if($lensubBls>1){@subBls=(); $lensubBls=0;$condPos[7]=0;}else{@subBls=(); $lensubBls=0;
 $condPos[7]=1;$jpdist=((blockDist(@crd4))+(blockDist(@crd5)));
 if(($jpdist<=$jumping_dist)&&(special_condition_bottom(@crd5cpy)==1))
 {return(532);}
 }

 #remove the added marker
 pop(@crd5cpy);
} #if chr seq

return(0); # Comes here when none of the above conditions are true
           # This means the single marker block cant be merged with the neigbouring blocks  

} #sub

# --- sub special_condition_bottom (original lines 993-1016) ---
sub special_condition_bottom
{
 my(@crd_spl) =@_;
 $tmp_spl = pop(@crd_spl); @crd_spl_srt = sort{$a<=>$b}(@crd_spl);
 $dist_spl = abs($crd_spl_srt[0]-$crd_spl_srt[-1]); $num_spl = @crd_spl;
 $or_spl = getOrien(@crd_spl); #if ($tmp_spl==70697411){print "$tmp_spl @crd_spl $or_spl\n";}
 
 if(($num_spl>=3)&&($dist_spl>=1000000))
 {
  # this checks whether markers falls in between
  if($or_spl eq "Up")
  {
   if(($crd_spl[-2]<$crd_spl[-1])&&($crd_spl[-1]<$tmp_spl)) { return(1);} else{ return(0);}  
  }
  elsif($or_spl eq "Down")
  {
   if(($crd_spl[-2]>$crd_spl[-1])&&($crd_spl[-1]>$tmp_spl)) { return(1);} else{ return(0);}  
  } # elsif
  else{ return(0);}  
 } # outer if
 else
 { 
  return(1);} # return 1 because we dont want to check whether the markers falls in between or not for smaller blocks
}

# --- sub special_condition_top (original lines 1018-1041) ---
sub special_condition_top
{
 my(@crd_spl) =@_;
 $tmp_spl = shift(@crd_spl); @crd_spl_srt = sort{$a<=>$b}(@crd_spl);
 $dist_spl = abs($crd_spl_srt[0]-$crd_spl_srt[-1]); $num_spl = @crd_spl;
 $or_spl = getOrien(@crd_spl); 
 
 if(($num_spl>=3)&&($dist_spl>=1000000))
 {
  # this checks whether markers falls in between
  if($or_spl eq "Up")
  {
   if(($tmp_spl<$crd_spl[0])&&($crd_spl[0]<$crd_spl[1])) { return(1);} else{ return(0);}  
  }
  elsif($or_spl eq "Down")
  {
   if(($tmp_spl>$crd_spl[0])&&($crd_spl[0]>$crd_spl[1])) { return(1);} else{ return(0);}  
  } # elsif
  else{ return(0);}  
 } # outer if
 else
 { 
  return(1);} # return 1 because we dont want to check whether the markers falls in between or not for smaller blocks
}

# --- sub remove2mrkerSingls (original lines 1043-1060) ---
sub remove2mrkerSingls {
my(@subBls_sb)=@_; 
$len_sb = @subBls_sb;
for($c_sb=2;$c_sb<$len_sb;$c_sb += 4)
{ 
 @coords_2mrk = get_coords($subBls[2]); # gets coords of a sub block
 $num_2mrk = @coords_2mrk; #gets num of markers
 if($num_2mrk == 2) # if it is a 2 marker block
 {
  if(abs($coords_2mrk[0]-$coords_2mrk[1])<1000000) # check if the dist b/n is <1Mbp
  {
   # delete that info from the @subBls_sb
   splice(@subBls_sb,($c_sb - 2),4); # removes 4 elements starting at index $c_sb-3
  } #inner if
 } #if
} #for
return(@subBls_sb);
} #sub

# --- sub removeSingletons (original lines 1062-1074) ---
sub removeSingletons {
my(@subBls_sb)=@_; my(@subBls_sb2)=();
$len_sb = @subBls_sb; #print "$len_sb\t";
for($c_sb=3;$c_sb<$len_sb;$c_sb += 4)
{ 
 if($subBls_sb[$c_sb] eq "None") # this means it is singleton subblock
 { 
 } #if
 # add only the blocks which are not singletons
 else{push(@subBls_sb2,$subBls_sb[$c_sb-3],$subBls_sb[$c_sb-2],$subBls_sb[$c_sb-1],$subBls_sb[$c_sb],)}
} #for
return(@subBls_sb2);
} #sub

# --- sub filter_subBlsJ (original lines 1076-1092) ---
sub filter_subBlsJ {
my ($rsubblcrdsJ,$rmainBlJ) = @_; my %tmpHashJ=(); my @subcrds_fltJ=(); my (@subblcrdsJ,@mainBlJ)=();

@subblcrdsJ=@$rsubblcrdsJ; @mainBlJ = @$rmainBlJ;

# put array mainBlJ into hash map
foreach $tmpelJ(@mainBlJ){ $tmpHashJ{$tmpelJ}=1; } 

$numsubblcrdsJ=@subblcrdsJ; $xsubJ=0;
while($xsubJ < $numsubblcrdsJ)
{
 if( $tmpHashJ{$subblcrdsJ[$xsubJ]}!=1 ) # if sub block coords does n't belongs to the original big block
 {push(@subcrds_fltJ,$subblcrdsJ[$xsubJ],$subblcrdsJ[$xsubJ+1],$subblcrdsJ[$xsubJ+2],$subblcrdsJ[$xsubJ+3]); }
 $xsubJ +=4;
} #while
return(@subcrds_fltJ);
} #sub

# --- sub check_breakage (original lines 1095-1107) ---
sub check_breakage{

my ($fi,$la,$bp1,$bp2)= @_;

if(($fi>min_num($bp1,$bp2))&&($fi<max_num($bp1,$bp2))&&($la>min_num($bp1,$bp2))&&($la<max_num($bp1,$bp2)))
{return(1);}
elsif(($fi>min_num($bp1,$bp2))&&($fi<max_num($bp1,$bp2)))
{return(1);}
elsif(($la>min_num($bp1,$bp2))&&($la<max_num($bp1,$bp2)))
{return(1);}
else {return(0);}

} #sub

# --- sub jplocwn (original lines 1109-1136) ---
sub jplocwn{
my($cr3,$cr1,$cr2,$jdist)=@_;
my(@c3,@crd1,@crd2) = ();  my (@crd1_srt,@crd2_srt)=();
@c3 = @$cr3; @crd1 = @$cr1; @crd2 = @$cr2; 

$dircrd1=(find_coords(@crd1))[2]; # gets the direction of the block#print "$dircrd\n";
$dircrd2=(find_coords(@crd2))[2];

#sort blocks(main) depending on their direction
if($dircrd1 eq "Up"){@crd_srt1 = sort{$a <=> $b}(@crd1); } 
elsif($dircrd1 eq "Down"){@crd_srt1 = sort{$b <=> $a}(@crd1); }
elsif($dircrd1 eq "None"){@crd_srt1 = sort{$b <=> $a}(@crd1); }

if($dircrd2 eq "Up"){@crd_srt2 = sort{$a <=> $b}(@crd2); } 
elsif($dircrd2 eq "Down"){@crd_srt2 = sort{$b <=> $a}(@crd2); }
elsif($dircrd2 eq "None"){@crd_srt2 = sort{$b <=> $a}(@crd2); }

$val1=$crd_srt1[-1]; $val2=$c3[0]; $val3=$crd_srt2[0];
$diff12 = abs($val1-$val2); $diff23 = abs($val2-$val3);

if(($c3[0]>min_num($crd_srt1[-1],$crd_srt2[0]))&&($c3[0]<max_num($crd_srt1[-1],$crd_srt2[0]))) # the marker is b/n the two blocks
{
 if($diff12<$diff23){return(23);}
 elsif($diff12>$diff23){return(34);}
}
else {return(0);}

} #sub

# --- sub jplocIns (original lines 1138-1172) ---
sub jplocIns {

my($cr3,$cr,$jdist)=@_;
my(@c3,@crd,@elejp) = (); $ele0 = 0;  $diffele=1;my @crd_srt=();
@c3 = @$cr3; @crd = @$cr;

$dircrd=(find_coords(@crd))[2]; # gets the direction of the block#print "$dircrd\n";

#sort block(main) depending on the block direction
if($dircrd eq "Up"){@crd_srt = sort{$a <=> $b}(@crd); } 
elsif($dircrd eq "Down"){@crd_srt = sort{$b <=> $a}(@crd); }
else{@crd_srt = sort{$b <=> $a}(@crd); }

@crdsrtrev = reverse(@crd_srt); #if ($coords3[0]==13863096){print "crd_srt=@crd_srt\n";}

$marker=$c3[0];  
my($el,$pel)= "";
foreach $el(@crdsrtrev)
{
 if($pel ne "")
 {    
  if( ( $marker>min_num($pel,$el) )&&( $marker<max_num($pel,$el) ) &&($jdist<=$jumping_dist))
  {
    $ele0 = 1; #print "$marker $pel $el \n";
  }
  $jdist += (max_num($pel,$el)-min_num($pel,$el));
 }
 $pel = $el;
}

if($ele0==1){return(1);} 
else{return(0);}


} #sub

# --- sub jplocBn (original lines 1174-1204) ---
sub jplocBn {

my($cr3,$cr1,$cr2,$jdist)=@_;
my(@c3,@crd1,@crd2) = ();  my (@crd1_srt,@crd2_srt)=();
@c3 = @$cr3; @crd1 = @$cr1; @crd2 = @$cr2;

$dircrd1=(find_coords(@crd1))[2]; # gets the direction of the block#print "$dircrd\n";
$dircrd2=(find_coords(@crd2))[2]; 

#sort blocks(main) depending on their direction
if($dircrd1 eq "Up"){@crd_srt1 = sort{$a <=> $b}(@crd1); } 
elsif($dircrd1 eq "Down"){@crd_srt1 = sort{$b <=> $a}(@crd1); }
elsif($dircrd1 eq "None"){@crd_srt1 = sort{$b <=> $a}(@crd1); }

if($dircrd2 eq "Up"){@crd_srt2 = sort{$a <=> $b}(@crd2); } 
elsif($dircrd2 eq "Down"){ @crd_srt2 = sort{$b <=> $a}(@crd2); }
elsif($dircrd2 eq "None"){@crd_srt2 = sort{$b <=> $a}(@crd2); }

$val1=$crd_srt1[-1]; $val2=$c3[0]; $val3=$crd_srt2[0];
$diff12 = abs($val1-$val2); $diff23 = abs($val2-$val3);

#if ($coords3[0]==30543455){print "@crd1\n@c3\n@crd2\n\n";print "$crd_srt1[-1] $crd_srt2[0] $jdist\n";}
if( ($c3[0]>min_num($crd_srt1[-1],$crd_srt2[0])) && ($c3[0]<max_num($crd_srt1[-1],$crd_srt2[0])) && ($jdist<=2000000) )
#if($jdist<=2000000)
{
 if($diff12<$diff23){return(12);}
elsif($diff12>$diff23){return(23);}
}
else {return(0);}

} #sub

# --- sub find_jumplocwithin (original lines 1206-1223) ---
sub find_jumplocwithin {
my($cr3,$cr)=@_;
my(@c3,@crd) = (); $ele0=0; $ele1=0; $diffele=0;$nummks=0; $mrkcheck=1;
my($dircrd) = "";
@c3 = @$cr3; @crd = @$cr; $nummks=@c3;

$dircrd=(find_coords(@crd))[2]; # gets the direction of the block

#sort both blocks depending on the above block direction
if($dircrd eq "Up"){@crd_srt = sort{$a <=> $b}(@crd); @c3_srt = sort{$a <=> $b}(@c3);} 
elsif($dircrd eq "Down"){@crd_srt = sort{$b <=> $a}(@crd); @c3_srt = sort{$b <=> $a}(@c3);}
elsif($dircrd eq "None"){@crd_srt = sort{$b <=> $a}(@crd); @c3_srt = sort{$b <=> $a}(@c3);}

#compare
if( ( $c3_srt[0] > min_num($c3_srt[1],$crd_srt[-1]) ) && ( $c3_srt[1]<max_num($c3_srt[0],$crd_srt[-1]) )&&($mrkcheck==1))
{return(1);} else{return(0);}

}

# --- sub distbn (original lines 1225-1228) ---
sub distbn{
my($fir,$sec)=@_;
return((abs($fir-$sec)));
} #sub

# --- sub find_jumplocwithin2 (original lines 1230-1476) ---
sub find_jumplocwithin2 {
my($cr1,$cr2,$cr3,$cr4,$cr5)=@_;
my(@crd3,@crd1,@crd2,@crd4,@crd5) = ();  my (@crd_srt1,@crd_srt2,@crd4_srt,@crd_srt5,@subBls)=(); my @condPos=();
@crd1 = @$cr1; @crd2 = @$cr2; @crd3 = @$cr3; @crd4 = @$cr4; @crd5 = @$cr5; $lensubBls=0;
@crd1cpy = @crd1; @crd2cpy = @crd2; @crd3cpy = @crd3; @crd4cpy = @crd4; @crd5cpy = @crd5;
$mrkcheck=1;

$dircrd1=(find_coords(@crd1))[2]; $dircrd2=(find_coords(@crd2))[2];
$dircrd4=(find_coords(@crd4))[2]; $dircrd5=(find_coords(@crd5))[2];

#sort blocks(main) depending on their direction
if($dircrd1 eq "Up"){@crd_srt1 = sort{$a <=> $b}(@crd1); } elsif($dircrd1 eq "Down"){@crd_srt1 = sort{$b <=> $a}(@crd1); }
elsif($dircrd1 eq "None"){@crd_srt1 = sort{$b <=> $a}(@crd1); }

if($dircrd2 eq "Up"){@crd_srt2 = sort{$a <=> $b}(@crd2); } elsif($dircrd2 eq "Down"){@crd_srt2 = sort{$b <=> $a}(@crd2); }
elsif($dircrd2 eq "None"){@crd_srt2 = sort{$b <=> $a}(@crd2); }

if($dircrd4 eq "Up"){@crd_srt4 = sort{$a <=> $b}(@crd4); } elsif($dircrd4 eq "Down"){@crd_srt4 = sort{$b <=> $a}(@crd4); }
elsif($dircrd4 eq "None"){@crd_srt4 = sort{$b <=> $a}(@crd4); }

if($dircrd5 eq "Up"){@crd_srt5 = sort{$a <=> $b}(@crd5); } elsif($dircrd5 eq "Down"){@crd_srt5 = sort{$b <=> $a}(@crd5); }
elsif($dircrd5 eq "None"){@crd_srt5 = sort{$b <=> $a}(@crd5); }

#make a copy of rev order
@rev_crd_srt1= reverse(@crd_srt1);@rev_crd_srt2= reverse(@crd_srt2);
@rev_crd_srt4= reverse(@crd_srt4);@rev_crd_srt5= reverse(@crd_srt5);

if(abs($crd_srt3[0]-$crd_srt3[1])>2000000){$mrkcheck=0;} #checks whether the dist b/n markers is less than 2mbp


if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])&&($mrkcheck==1)) #checks chr sequence
{
 #to the top of first block
 my(@crd1_2mrk)=(); unshift(@crd1_2mrk,@crd_srt1,@crd3);
 @subBls =find_sub_blocks2($chrms1[0],$chrms1[1],$crd3[1],$crd_srt1[0]); $lensubBls=@subBls; 
 @subBls = filter_subBlsJ(\@subBls,\@crd1_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);

 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd3, @crd_srt1);
 #@subBls = filter_subBlsJ(\@subBls,\@tmpcrdsmrg);
 $lensubBls=@subBls; #if ($coords3[0]==96505883){print "TOP num of sub blocks =$lensubBls\n";} 
 #print "coords1:@crd1\ncoords2:@crd2\ncoords3:@crd3\ncoords4:@crd4\ncoords5:@crd5\n";
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd1))+(blockDist(@crd2)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[-1] > min_num($crd3[0],$crd_srt1[0])) && ($crd3[-1]<max_num($crd3[0],$crd_srt1[0]))) ||
        (($crd3[0] > min_num($crd3[-1],$crd_srt1[0])) && ($crd3[0]<max_num($crd3[-1],$crd_srt1[0])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and TOP of 1st block is SMALLER than the dist b/n 3rd block and BOTTOM of 1st block
      && ( (distbn($crd3[-1],$crd_srt1[0]))<(distbn($crd3[0],$crd_srt1[-1])) )
    )
  {return(131); } 
 }

 #To the bottom of first block
 my(@crd1_2mrk)=(); push(@crd1_2mrk,@crd_srt1,@crd3);
 # check if there are any blocks breaking this position
 @subBls =find_sub_blocks2($chrms1[0],$chrms1[1],$crd_srt1[-1],$crd3[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd1_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd_srt1, @crd3);
 #@subBls = filter_subBlsJ(\@subBls,\@tmpcrdsmrg);
 $lensubBls=@subBls; #if ($coords3[0]==67731678){print "@subBls 1 TOP num of sub blocks =$lensubBls\n";} 
 #print "coords1:@crd1\ncoords2:@crd2\ncoords3:@crd3\ncoords4:@crd4\ncoords5:@crd5\n";
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd2)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[0] > min_num($crd3[1],$crd_srt1[-1])) && ($crd3[0]<max_num($crd3[1],$crd_srt1[-1]))) ||
        (($crd3[1] > min_num($crd3[0],$crd_srt1[-1])) && ($crd3[1]<max_num($crd3[0],$crd_srt1[-1])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and BOTTOM of 1st block is SMALLER than the dist b/n 3rd block and TOP of 1st block
      && ( (distbn($crd3[0],$crd_srt1[-1]))<(distbn($crd3[-1],$crd_srt1[0])) )
    )
    {return(132); } 
 } 

} #if chr seq

if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])&&($mrkcheck==1)) #checks chr sequence
{
 #to the top of second block
 my(@crd2_2mrk)=(); unshift(@crd2_2mrk,@crd_srt2,@crd3);
 @subBls =find_sub_blocks2($chrms2[0],$chrms2[1],$crd3[1],$crd_srt2[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd2_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);

 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd3, @crd_srt2); 
 $lensubBls=@subBls; 
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd2)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[-1] > min_num($crd3[0],$crd_srt2[0])) && ($crd3[-1]<max_num($crd3[0],$crd_srt2[0]))) ||
        (($crd3[0] > min_num($crd3[-1],$crd_srt2[0])) && ($crd3[0]<max_num($crd3[-1],$crd_srt2[0])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and TOP of 2nd block is SMALLER than the dist b/n 3rd block and BOTTOM of 2nd block
      && ( (distbn($crd3[-1],$crd_srt2[0]))<(distbn($crd3[0],$crd_srt2[-1])) )
    )
   {return(231); } 
 }

 #To the bottom of second block
 my(@crd2_2mrk)=(); push(@crd2_2mrk,@crd_srt2,@crd3);
 # check if there are any blocks breaking this position
 @subBls =find_sub_blocks2($chrms2[0],$chrms2[1],$crd_srt2[-1],$crd3[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd2_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd_srt2, @crd3);
 $lensubBls=@subBls; 
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=0; 
  # checks if the markers can fall in b/n
  if( ( (($crd3[0] > min_num($crd3[1],$crd_srt2[-1])) && ($crd3[0]<max_num($crd3[1],$crd_srt2[-1]))) ||
        (($crd3[1] > min_num($crd3[0],$crd_srt2[-1])) && ($crd3[1]<max_num($crd3[0],$crd_srt2[-1])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and BOTTOM of 2nd block is SMALLER than the dist b/n 3rd block and TOP of 2nd block
      && ( (distbn($crd3[0],$crd_srt2[-1]))<(distbn($crd3[-1],$crd_srt2[0])) )
    )
  {return(232); } 
 } 

} #if chr seq


if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])&&($mrkcheck==1)) #checks chr sequence
{
 #to the top of fourth block
 my(@crd4_2mrk)=(); unshift(@crd4_2mrk,@crd_srt4,@crd3);
 @subBls =find_sub_blocks2($chrms4[0],$chrms4[1],$crd3[1],$crd_srt4[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd4_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd3, @crd_srt4);
 $lensubBls=@subBls;
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=0; 
  # checks if the markers can fall in b/n
  if( ( (($crd3[-1] > min_num($crd3[0],$crd_srt4[0])) && ($crd3[-1]<max_num($crd3[0],$crd_srt4[0]))) ||
        (($crd3[0] > min_num($crd3[-1],$crd_srt4[0])) && ($crd3[0]<max_num($crd3[-1],$crd_srt4[0])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and TOP of 4th block is SMALLER than the dist b/n 3rd block and BOTTOM of 4th block
      && ( (distbn($crd3[-1],$crd_srt4[0]))<(distbn($crd3[0],$crd_srt4[-1])) )
    )
    {return(431); } 
 }

 #To the bottom of fourth block
 my(@crd4_2mrk)=(); push(@crd4_2mrk,@crd_srt4,@crd3);
 # check if there are any blocks breaking this position
 @subBls =find_sub_blocks2($chrms4[0],$chrms4[1],$crd_srt4[-1],$crd3[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd4_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd_srt4, @crd3);

 $lensubBls=@subBls;
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd4)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[0] > min_num($crd3[1],$crd_srt4[-1])) && ($crd3[0]<max_num($crd3[1],$crd_srt4[-1]))) ||
        (($crd3[1] > min_num($crd3[0],$crd_srt4[-1])) && ($crd3[1]<max_num($crd3[0],$crd_srt4[-1])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and BOTTOM of 4th block is SMALLER than the dist b/n 3rd block and TOP of 4th block
      && ( (distbn($crd3[0],$crd_srt4[-1]))<(distbn($crd3[-1],$crd_srt4[0])) )
    )
    {return(432); } 
 } 

} #if chr seq


if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])&&($mrkcheck==1)) #checks chr sequence
{
 #to the top of fifth block
 my(@crd5_2mrk)=(); unshift(@crd5_2mrk,@crd_srt5,@crd3);
 @subBls =find_sub_blocks2($chrms5[0],$chrms5[1],$crd3[1],$crd_srt5[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd5_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 my @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd3, @crd_srt5);
 $lensubBls=@subBls; 
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd4)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[-1] > min_num($crd3[0],$crd_srt5[0])) && ($crd3[-1]<max_num($crd3[0],$crd_srt5[0]))) ||
        (($crd3[0] > min_num($crd3[-1],$crd_srt5[0])) && ($crd3[0]<max_num($crd3[-1],$crd_srt5[0])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and TOP of 5th block is SMALLER than the dist b/n 3rd block and BOTTOM of 5th block
      && ( (distbn($crd3[-1],$crd_srt5[0]))<(distbn($crd3[0],$crd_srt5[-1])) )
    )
    {return(531); } 
 }

 #To the bottom of fifth block
 my(@crd5_2mrk)=(); push(@crd5_2mrk,@crd_srt5,@crd3);
 # check if there are any blocks breaking this position
 @subBls =find_sub_blocks2($chrms5[0],$chrms5[1],$crd_srt5[-1],$crd3[0]); $lensubBls=@subBls;
 @subBls = filter_subBlsJ(\@subBls,\@crd5_2mrk); @subBls = removeSingletons(@subBls);@subBls = remove2mrkerSingls(@subBls);
 @subBls = removeSensBlock2(@subBls);
 @tmpcrdsmrg = (); push(@tmpcrdsmrg,@crd_srt5, @crd3);
 $lensubBls=@subBls; 
 if($lensubBls>1)  
 {@subBls=(); $lensubBls=0; }
 else{
  @subBls=(); $lensubBls=0; 
  $jpdist=(blockDist(@crd4))+(blockDist(@crd5)); 
  # checks if the markers can fall in b/n
  if( ( (($crd3[0] > min_num($crd3[1],$crd_srt5[-1])) && ($crd3[0]<max_num($crd3[1],$crd_srt5[-1]))) ||
        (($crd3[1] > min_num($crd3[0],$crd_srt5[-1])) && ($crd3[1]<max_num($crd3[0],$crd_srt5[-1])))  
      )
      && ($jpdist<=$jumping_dist)
      # dist b/n 3rd block and BOTTOM of 5th block is SMALLER than the dist b/n 3rd block and TOP of 5th block
      && ( (distbn($crd3[0],$crd_srt5[-1]))<(distbn($crd3[-1],$crd_srt5[0])) )
    )
    {return(532); } 
 } 

} #if chr seq




} #sub

# --- sub find_jumploc (original lines 1481-1520) ---
sub find_jumploc {

my($cr3,$cr,$jdist)=@_;
my(@c3,@crd,@elejp) = ();   $diffele=1;my @crd_srt=();
@c3 = @$cr3; @crd = @$cr;
$jdist_cpy =$jdist; $nummks=@c3;

$dircrd=(find_coords(@crd))[2]; # gets the direction of the block#print "$dircrd\n";

#sort both blocks depending on the above block direction
if($dircrd eq "Up"){@crd_srt = sort{$a <=> $b}(@crd); @c3_srt = sort{$a <=> $b}(@c3);} 
elsif($dircrd eq "Down"){@crd_srt = sort{$b <=> $a}(@crd); @c3_srt = sort{$b <=> $a}(@c3);}
elsif($dircrd eq "None"){@crd_srt = sort{$b <=> $a}(@crd); @c3_srt = sort{$b <=> $a}(@c3);}

@crdsrtrev = reverse(@crd_srt);

$i_ele=-1;
foreach $marker(@c3)  
{
 $jdist=$jdist_cpy; $i_ele++; #print "$marker\n";
 my($el,$pel)= "";
 foreach $el(@crdsrtrev)
 {
  if($pel ne "")
  { 
   if( ( $marker>min_num($pel,$el) )&&( $marker<max_num($pel,$el) ) &&($jdist<=$jumping_dist))
   {
     $elejp[$i_ele] = 1; #print "here\t";
   }
   $jdist += (max_num($pel,$el)-min_num($pel,$el));
  }
  $pel = $el;
 }
} 
if(abs($c3[0]-$c3[1])>2000000){$diffele=0;}
if(($elejp[0]==1)&&($elejp[1]==1)&&($diffele==1)){return(1);} #if both markers belongs to another block
else{return(0);}


}

# --- sub blockDist (original lines 1524-1538) ---
sub blockDist {

 my (@c)= @_;
 my($crd,$pcrd)="";
 my($dist)=0;
 foreach $crd(@c)
 {
  if($pcrd ne "")
  {   
   $dist += (max_num($pcrd,$crd)-min_num($pcrd,$crd));
  }
  $pcrd = $crd;
 }
 return ($dist);
}

# --- sub make_ref_array (original lines 1602-1729) ---
sub make_ref_array{
$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
$f_row_done = 0; #first row 
$newnum = 1000; @coords = (); @names=(); $num_changed =0;
@chrs=(); @chrs=();@chrs=(); %num_hash=();$v=0; @ref=();

###Add two empty coords in the begining
my @sref=();
my @cords=(0,1); my @chrms=(92,64); my @mnames=();
$sref[0]= \@cords;
$sref[1] = \@chrms;
$sref[2] = \@mnames;
$ref[$v]= \@sref; $v++;
my @sref=();
my @cords=(0,1); my @chrms=(87,51); my @mnames=();
$sref[0]= \@cords;
$sref[1] = \@chrms;
$sref[2] = \@mnames;
$ref[$v]= \@sref; $v++;

while($i_newnm < $len)
{ 
 $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
 $cstart = $info[$m_st]; $cnum = $info[$i_num];

 if(($cnum != $pnum)&&($f_row_done ==1)) # num changed
 { # check if there are more coords of this block   
   $jtemp = 7; #$i_newnm; 
   my @coordstempUp =();   my @namestempUp =();
   while($jtemp<$i_newnm)
   {
    $cnumtemp=$info[$jtemp-2]; $cstarttemp=$info[$jtemp-4];
    if($cnumtemp == $pnum)
    {
      push(@coordstempUp, $cstarttemp) if((!($cstarttemp =~ /\s+/))&&($cstarttemp ne ""));
      push(@namestempUp, $info[$jtemp-7]) if((!($cstarttemp =~ /\s+/))&&($cstarttemp ne ""));
    } #if
    $jtemp +=8;
   } #while
   #print "Before:@coordstempUp\n";
   @coordstempUp = rem_coords(\@coordstempUp,\@coords);
   @namestempUp = rem_coords(\@namestempUp,\@names);
   #print "After:@coordstempUp\n";
   
   $jtemp = $i_newnm; 
   my @coordstempDn =();    my @namestempDn =();
   while($jtemp<$len)
   {
    $cnumtemp=$info[$jtemp-2]; $cstarttemp=$info[$jtemp-4];
    if($cnumtemp == $pnum)
    {
      push(@coordstempDn, $cstarttemp) if((!($cstarttemp =~ /\s+/))&&($cstarttemp ne ""));
      push(@namestempDn, $info[$jtemp-7]) if((!($cstarttemp =~ /\s+/))&&($cstarttemp ne ""));
    } #if
    $jtemp +=8;
   } #while
   $n_C_up=@coordstempUp; $n_C_dn=@coordstempDn; $n_C = @coords;
  
   # This tries to find one of the following conditions. 1) singleton comes before big block
   # 2) bigblock comes before singleton 3) singleton before and after the big block 4) No singletons before or after the big block
   if(  ($n_C_dn <1 and $n_C_up>=1 and $n_C_up<$n_C) ||   
        ($n_C_dn >=1 and $n_C_up<1 and $n_C_dn<$n_C) ||
        ($n_C_dn >=1 and $n_C_up >=1 and $n_C_dn<$n_C and $n_C_up<$n_C) ||
        ($n_C_dn <1 and $n_C_up<1)
     )   
   {
    # implement ref section here
    my @temp_ref = (); push(@temp_ref,@coordstempUp,@coords,@coordstempDn);
    my @temp_names = (); push(@temp_names,@namestempUp,@names,@namestempDn);
    my @chrms = ($pb_chr,$ph_chr);
    my @cords = @temp_ref; #print "Coords=@cords\n\n"; 
    my @mnames = @temp_names; #print "Coords=@cords\n\n"; 
    my @sref=();   #print "ref: @cords\n";
    $sref[0]= \@cords;
    $sref[1] = \@chrms;
    $sref[2] = \@mnames;
    $ref[$v]= \@sref;
    $v++; # to store next coord info at diff location
    @coords=(); @names=();
   } #if 
   else{@coords=(); @names=(); }
   
  
 } #cnum!=pnum


 $f_row_done = 1;
 push(@coords, $cstart) if((!($cstart =~ /\s+/))&&($cstart ne "")); #if($cstart==34882952){print "Coords=@coords\n\n";}
 push(@names, $info[$q_bchr-1]) if((!($cstart =~ /\s+/))&&($cstart ne "")); #if($cstart==34882952){print "Coords=@coords\n\n";}
 #print "cstart=$cstart\t";
 $pb_chr = $cb_chr; $ph_chr = $ch_chr;
 $pstart = $cstart; $pnum = $cnum;
 
 $p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm+=8;

} #while

### for the last set

my @chrms = ($pb_chr,$ph_chr);
my @cords = @coords;
my @mnames = @names;
my @sref=();
#print "ref: @cords\n";
$sref[0]= \@cords;
$sref[1] = \@chrms;
$sref[2] = \@mnames;
$ref[$v]= \@sref;
#$tempnumele = @ref; print "numbl:$tempnumele\n";

###Add two empty blocks in the end
my @sref=();
my @cords=(0,1); my @chrms=(40,50); my @mnames=();
$sref[0]= \@cords;
$sref[1] = \@chrms;
$sref[2] = \@mnames;
$v++;
$ref[$v]= \@sref; $v++;
my @sref=();
my @cords=(0,1); my @chrms=(60,70); my @mnames=();
$sref[0]= \@cords;
$sref[1] = \@chrms;
$sref[2] = \@mnames;
$ref[$v]= \@sref; $v++;
#$tempnumele = @ref; print "After numbl:$tempnumele\n";

} # sub

# --- sub rem_coords (original lines 1732-1746) ---
sub rem_coords
{ 
 my($ref1,$ref2)=@_;
 my(@crds1)=@$ref1;  my(@crds2)=@$ref2; 
 my %hash_temp=();
 foreach my $ele (@crds2) {  $hash_temp{$ele}=1; } #write to a hashmap
 my $i=0; my $len = @crds1;   my $ele2 = 0;
 for(;$i<$len;$i++) 
 {
  $ele2=$crds1[$i];
  if($hash_temp{$ele2}){  splice(@crds1,$i,1); $i--; $len--;  }
 } #foreach
 return(@crds1);

} #sub rem_coords

# --- sub rem_names (original lines 1749-1763) ---
sub rem_names
{ 
 my($ref1,$ref2)=@_;
 my(@crds1)=@$ref1;  my(@crds2)=@$ref2; 
 my %hash_temp=();
 foreach my $ele (@crds2) {  $hash_temp{$ele}=1; } #write to a hashmap
 my $i=0; my $len = @crds1;   my $ele2 = 0;
 for(;$i<$len;$i++) 
 {
  $ele2=$crds1[$i];
  if($hash_temp{$ele2}){  splice(@crds1,$i,1); $i--; $len--;  }
 } #foreach
 return(@crds1);

} #sub rem_coords

# --- sub merge_nors (original lines 1814-1985) ---
sub merge_nors{
$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before Nor:$tempnumele\n";    
while($xNr < $numelesNr)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Nr = $ref[$wNr]->[0]; $rchrms1Nr = $ref[$wNr]->[1]; $rnam1Nr = $ref[$wNr]->[2];
 $rcoords2Nr = $ref[$xNr]->[0]; $rchrms2Nr = $ref[$xNr]->[1]; $rnam2Nr = $ref[$xNr]->[2];
 $rcoords3Nr = $ref[$yNr]->[0]; $rchrms3Nr = $ref[$yNr]->[1]; $rnam3Nr = $ref[$yNr]->[2];

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



 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 
 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);

 # print "Nors: @$rnam1Nr\n@$rnam2Nr\n@$rnam3Nr\nc1: @coords1Nr\nc2: @coords2Nr\nc3: @coords3Nr\n $wNr $xNr $yNr $orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\n\n";
# print WR2 "Data is being analyzed1\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
    #&& (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
   
#  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
#  {    
	#print "$chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]\n";
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
  	splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
#  }
#  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
#  {
#  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
#  }

 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")
    #&& ($endANr<$startBNr) 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between
   # && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
  	splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  

  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
  
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    #&& ($endANr>$startBNr)
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
   # && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
  	splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  

  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
  # &&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 
   #&& ($endBNr<$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; 
  }
 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
  # &&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; 

  }

 } 

 $wNr +=1; $xNr +=1; $yNr +=1;
} #while
#$rcoords2Nr = $ref[$xNr]->[0]; $rchrms2Nr = $ref[$xNr]->[1]; $rnam2Nr = $ref[$xNr]->[2]; @coords2Nr = @$rcoords2Nr;
#print "xNr:  @coords2Nr";
#$tempnumele = @ref; print "$xNr end Nor:$tempnumele\n";

} #sub

# --- sub closerBl (original lines 1987-2003) ---
sub closerBl
{
 my($startANr_sb,$endANr_sb,$startBNr_sb,$endBNr_sb,$startCNr_sb,$endCNr_sb,$chrRA_sb,$chrRB_sb,$chrRC_sb,$chrA_sb,$chrB_sb,$chrC_sb)=@_;
 $dist12 = abs($endANr_sb-$startBNr_sb);
 $dist23 = abs($endBNr_sb-$startCNr_sb);
 if($chrA_sb eq $chrB_sb and $chrB_sb eq $chrC_sb and $chrRA_sb eq $chrRB_sb and $chrRB_sb eq $chrRC_sb )
 {
 	if($dist12<$dist23){return(12);} # return a message what distance is small
 	elsif($dist12>$dist23){return(23);}
 }
 elsif($chrA_sb eq $chrB_sb and $chrRA_sb eq $chrRB_sb)
 {return(12);}
 elsif($chrB_sb eq $chrC_sb and $chrRB_sb eq $chrRC_sb)
 {return(23);}
 else {return(0);}
  
} #sub

# --- sub can_pick (original lines 2006-2019) ---
sub can_pick
{
	my ($c_rd, $rpick) = @_;
	my @temp = @$rpick;

	foreach my $ele (@temp)
	{
		if(abs($ele-$c_rd)<$distBnMrks) # checks whether the current marker is <1mbp apart with any other selected marker
		{
			return(0);
		}
	}
	return(1);
} #sub

# --- sub selec_mrks (original lines 2021-2039) ---
sub selec_mrks
{
 my @rep_crds = @_;
 my $ind = pop(@rep_crds); my $num_ds =@rep_crds;
 my @temp_d=(); my $i_e =0;
 push(@temp_d,$rep_crds[$i_e+$ind]); #take a coord
 my $pick = $rep_crds[$i_e+$ind];
 #$i_e++;
 while($i_e<$num_ds)
 {
	if(can_pick($rep_crds[$i_e],\@temp_d))
	{
		 push(@temp_d,$rep_crds[$i_e]); #pick this coord
 		 $pick = $rep_crds[$i_e];
	}	
	$i_e++;
 }
 return(@temp_d);
} #sub

# --- sub getOrien (original lines 2041-2124) ---
sub getOrien
{
 my(@crds) = @_;
 @rep_crds = repair_crds(@crds); $num_ds = @rep_crds;
 @crds_copy = @rep_crds; 

 my(@sorted_crds) = sort{$a <=> $b}(@rep_crds); #print "s crds = @sorted_crds\n";
 $mn = $sorted_crds[0]; $mn2 = $sorted_crds[1];
 $mx = pop(@sorted_crds); $mx2 = pop(@sorted_crds);

my @temp_d = selec_mrks(@rep_crds,0);
my $num_td = @temp_d;
# if($num_td<3 and $num_ds>2) # then repeat the same thing as above by first picking second coord of the block. This is to account for the case of a flip
# {
#	@temp_d = selec_mrks(@rep_crds,1);
# }

 #now rep_crds does n't have original coords
 @rep_crds = @temp_d; $num_td = @temp_d;  $num_ds = @rep_crds;  $first = $temp_d[0]; $last = $temp_d[-1];

 $ups1 = 0; $downs1 =0; $i_d=0; $j_d = ($num_ds-1)-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 {

  if($rep_crds[$i_d]<$rep_crds[$j_d]) {$ups1++;}
  elsif($rep_crds[$i_d]>$rep_crds[$j_d]) {$downs1++;}  
  $i_d++; $j_d=($num_ds-1)-$i_d; #updation

 } #for

  # find how many ups and downs are there using Denis's procedure
 @rep_crds = @crds_copy;   $num_ds = @rep_crds;
 my $ups2 = 0; my $downs2 =0; $i_d=0; $j_d = ($num_ds-1)-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 {
  #if ($rep_crds[0]==19861270){ print"i=$i_d j=$j_d\n"; }
  if($rep_crds[$i_d]<$rep_crds[$j_d]) {$ups2++;}
  elsif($rep_crds[$i_d]>$rep_crds[$j_d]) {$downs2++;}  
  $i_d++; $j_d=($num_ds-1)-$i_d; #updation
  #if ($rep_crds[0]==19861270){ print"AFTER: i=$i_d j=$j_d\n"; }
 } #for


 #if ($rep_crds[0]==36977048){ print "\n\n";} #print "ups1:$ups1 downs1:$downs1\n";}
 # find how many ups and downs are there
 $ups = 0; $downs =0; $pele=""; 
 foreach $ele(@rep_crds)
 {
  if($pele ne "")
  {
   if($pele<$ele) {$ups++;}
   elsif($pele>$ele){$downs++;}
  }
  $pele=$ele;
 }

 # Assign orientation depending on num of ups and downs
 if($ups1>$downs1){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif($ups1<$downs1){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}

 elsif(($ups1==$downs1)&&($ups2>$downs2)){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif(($ups1==$downs1)&&($ups2<$downs2)){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}

 elsif(($ups1==$downs1)&&($ups2==$downs2)&&($ups>$downs)){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif(($ups1==$downs1)&&($ups2==$downs2)&&($ups<$downs)){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}

 elsif(($ups1==$downs1)&&($ups2==$downs2)&&($ups==$downs)&&($first<$last))
 { 
  $dir = "Up";
  $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;
 }
 elsif(($ups1==$downs1)&&($ups2==$downs2)&&($ups==$downs)&&($first>$last))
 { 
  $dir = "Down";
  $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;
 }
 $num_org =@crds_copy;
 # check if this block is a Nor
 if($num_td<3) {$dir="Nor";} 
 if($num_org==2){$dir="Nor";}  #two marker block is a nor
 if($num_org==1){$dir="None";$st=$rep_crds[0];$ed=$rep_crds[0];$st2=$rep_crds[0];$ed2=$rep_crds[0];}
 
 return ($dir);
} #sub

# --- sub getOrien2 (original lines 2126-2180) ---
sub getOrien2
{
 my(@crds) = @_;
 #print "coords=@crds\n";
 @rep_crds = repair_crds(@crds); $num_ds = @rep_crds;
 @crds_copy = @rep_crds; $first = $crds_copy[0]; $last = pop(@crds_copy);

 my(@sorted_crds) = sort{$a <=> $b}(@rep_crds); #print "s crds = @sorted_crds\n";
 $mn = $sorted_crds[0]; $mn2 = $sorted_crds[1];
 $mx = pop(@sorted_crds); $mx2 = pop(@sorted_crds);

 # find how many ups and downs are there using Denis's procedure
 $ups1 = 0; $downs1 =0; $i_d=0; $j_d = ($num_ds-1)-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 {
  if($rep_crds[$i_d]<$rep_crds[$j_d]) {$ups1++;}
  elsif($rep_crds[$i_d]>$rep_crds[$j_d]) {$downs1++;}  
  $i_d++; $j_d=($num_ds-1)-$i_d; #updation
 } #for

 # find how many ups and downs are there
 $ups = 0; $downs =0; $pele=""; 
 foreach $ele(@rep_crds)
 {
  if($pele ne "")
  {
   if($pele<$ele) {$ups++;}
   elsif($pele>$ele){$downs++;}
  }
  $pele=$ele;
 }

 # Assign orientation depending on num of ups and downs
 if($ups1>$downs1){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif($ups1<$downs1){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}
 elsif(($ups1==$downs1)&&($ups>$downs)){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif(($ups1==$downs1)&&($ups<$downs)){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}
 elsif(($ups1==$downs1)&&($ups==$downs)&&($first<$last))
 { 
  $dir = "Up";
  $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;
 }
 elsif(($ups1==$downs1)&&($ups==$downs)&&($first>$last))
 { 
  $dir = "Down";
  $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;
 }
 
 # check if this block is a Nor
 if(Nor(@rep_crds)) {$dir="Nor";} 

 if($num_ds==1){$dir="None";$st=$rep_crds[0];$ed=$rep_crds[0];$st2=$rep_crds[0];$ed2=$rep_crds[0];}
 
 return ($dir);
} #sub

# --- sub Nor (original lines 2182-2192) ---
sub Nor
{
 @crds_sb = @_;
 # check if there is any 3-consc-same_order- markers with dist in b/n >=1Mbp
 # AND/OR if it is 2 marker block with <1Mbp dist in b/n the 2 markers
 #$temp_res= consc3mrksnew(@crds_sb); $temp_res2=small2mrk(@crds_sb);
 #if($coords2Nr[0]==31431348){print "consc 3 marks for consc3mrksnew(@crds_sb) = $temp_res, $temp_res2\n";}
 if( (!(consc3mrksnew(@crds_sb))) || (small2mrk(@crds_sb)) )
 {return(1);}
 else {return(0);}
} # sub

# --- sub consc3mrksnew (original lines 2195-2229) ---
sub consc3mrksnew
{
 my @crds_sb = @_; my $numele_sb=@crds_sb;
 # sort coordinates
 my @crds_sb_srt = sort{$a<=>$b}(@crds_sb); my $first1=0; my $second=0; my $third =0;
 if($numele_sb>=3)
 {
  #Make the first maker as 1)
  $first1 = $crds_sb_srt[0]; 
 
  # search for 2)
  # 2) is a marker which is > 1) and 2)-1) >= 1mb
  foreach $ele_sb(@crds_sb_srt)
  {
   if( ($ele_sb>$first1)&&(abs($first1-$ele_sb)>=$distBnMrks)&&($second==0) ){$second=$ele_sb;}
  } #foreach

  # search for 3)
  # 3) is a marker which is > 2) and 3)-2) >=1mb
  if($second !=0) # proceed only if second is found
  {
   foreach $ele_sb(@crds_sb_srt)
   {
    if( ($ele_sb>$second)&&(abs($second-$ele_sb)>=$distBnMrks)&&($third==0) ){$third=$ele_sb;}
   } #foreach
  }
 
  #if($coords2Nr[0]==32438403){print "@coords2Nr first:$first1,$second,$third\n";}
  if(($first1 !=0)&&($second !=0)&&($third !=0)){return(1);}
 } # if numele
 else{return(1);} # this means it is 2 marker block so dont need to send 0

 return(0);

} #sub

# --- sub consc3mrks (original lines 2231-2294) ---
sub consc3mrks
{
 @crds_sb = @_;

 # check if there are any 2 consecutive ups or downs
 $pOr="None";$pele=""; $count=0; @temp_mrks=();
 foreach $ele(@crds_sb)
 {  
  $count++; # counts markers
  if($pele ne "")
  {
   # gives current orientation
   if($pele<$ele) {$cOr = "Up"; }
   else{$cOr = "Down"; }

   # when a region(up or down) changes, process it
   if(($cOr ne $pOr)&&($count>=3))
   { 
    #if the temp block's orientation is Up do this else do the else part
    if($temp_mrks[0]<$temp_mrks[-1])
    {
     #checks if there r 3 consc markers with dist >1mbp in b/n
     $first1 = $temp_mrks[0]; $second = $first1 + 1000000; $third = $second + 1000000; @f_s_t=();push(@f_s_t,$third);
     if(grtequalFound(\@temp_mrks,$second,\@f_s_t))
     { @f_s_t=();if(grtequalFound(\@temp_mrks,$third,\@f_s_t)){
#if($coords2Nr[0]==128470135){print"tempBlock=@temp_mrks 1st = $first1 2nd=$second 3rd = $third\n";} 
return(1);}  } # if
    }

    else  # temp block orien is down
    {
     $first1 = $temp_mrks[0]; $second = $first1 - 1000000; $third = $second - 1000000; @f_s_t=();push(@f_s_t,$third);
     if(lessequalFound(\@temp_mrks,$second,\@f_s_t))
     { @f_s_t=(); if(lessequalFound(\@temp_mrks,$third,\@f_s_t)){return(1);}  } # if
    }
    $lastmrk = $temp_mrks[-1];
    @temp_mrks=(); push(@temp_mrks,$lastmrk);
   } #if 

   $pOr = $cOr; # updation
  }
  $pele=$ele;
  push(@temp_mrks,$pele);
 }  # foreach

 # for the last set 
 if($temp_mrks[0]<$temp_mrks[-1])
 {
  #checks if there r 3 consc markers with dist >1mbp in b/n
  $first1 = $temp_mrks[0]; $second = $first1 + 1000000; $third = $second + 1000000; @f_s_t=();push(@f_s_t,$third);
  if(grtequalFound(\@temp_mrks,$second,\@f_s_t))
  { @f_s_t=();if(grtequalFound(\@temp_mrks,$third,\@f_s_t)){return(1);}  } # if
 }
 else  # temp block orien is down
 {
  $first1 = $temp_mrks[0]; $second = $first1 - 1000000; $third = $second - 1000000; @f_s_t=();push(@f_s_t,$third);
  if(lessequalFound(\@temp_mrks,$second,\@f_s_t))
  { @f_s_t=(); if(lessequalFound(\@temp_mrks,$third,\@f_s_t)){return(1);}  } # if
 }
 

 return(0);  # Since it could not find 3 consc mrks
 
} #sub

# --- sub grtequalFound (original lines 2296-2309) ---
sub grtequalFound
{
 my($rcrds_gt,$thr_num,$rfst)=@_;
 @crds_gt = @$rcrds_gt; @fst = @$rfst;

 #search for a number greater than $thr_num in the array
 foreach $num_gt(@crds_gt)
 {
  if(($num_gt >= $thr_num)&&($num_gt<=$fst[0])) {
  #if($coords2Nr[0]==128470135){print"$num_gt $thr_num\n";}
  return(1);} # required number found
 }
 return(0); #could not find the req number in the previous steps
} #sub

# --- sub lessequalFound (original lines 2311-2322) ---
sub lessequalFound
{
 my($rcrds_ls,$thr_num,$rfst)=@_;
 @crds_ls = @$rcrds_ls; @fst = @$rfst;

 #search for a number less than $thr_num in the array
 foreach $num_ls(@crds_ls)
 {
  if(($num_ls <= $thr_num)&&($num_ls>=$fst[0])) {return(1);} # required number found
 }
 return(0); #could not find the req number in the previous steps
} #sub

# --- sub small2mrk (original lines 2325-2335) ---
sub small2mrk
{
 @crds_sb = @_;
 # get num of markers, dist b/n markers
 $numMrks = @crds_sb; $dist_bn = abs($crds_sb[0]-$crds_sb[1]);

 # check if it is a 2 marker Nor
 if($numMrks == 2)  {return(1); } #if it is a 2 marker block, it is a nor. Previously I thought the dist b/n 2 markers should be <1mb, which is wrong
 #if(($numMrks == 2) && ($dist_bn>=1000000)) {return(1); } #if
 else {return(0);}
} #sub

# --- sub presentIn (original lines 2337-2346) ---
sub presentIn
{
 my(@fst_sb)=@_;
 $num_gt_sb = pop(@fst_sb); # retrieve the number to be searched in the array @fst_sb
 foreach $ele_fst(@fst_sb)
 {
  if($num_gt_sb==$ele_fst){return(1);}
 } # foreach
 return(0); # as number was not found
} #sub

# --- sub merge_cons_blocks (original lines 2355-2454) ---
sub merge_cons_blocks {

$numeles = @ref; $w=0; $x=1; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($x < $numeles)
{ 
 $rcoords1 = $ref[$w]->[0]; $rchrms1 = $ref[$w]->[1]; $rnam1 = $ref[$w]->[2];
 $rcoords2 = $ref[$x]->[0]; $rchrms2 = $ref[$x]->[1]; $rnam2 = $ref[$x]->[2];
 $merged =0;
 
 @coords1 =@$rcoords1; @coords2 = @$rcoords2; 
 @coords1_srt = sort{$a<=>$b}(@coords1);  @coords2_srt = sort{$a<=>$b}(@coords2); # sort

 $num1_Unite = @coords1; $num2_Unite = @coords2;

 @coords1_srt_cpy = @coords1_srt;   @coords2_srt_cpy = @coords2_srt; # make a copy
 @chrs1 = @$rchrms1; @chrs2 = @$rchrms2;  #print "unitepart:@chrs1\n";
 $numc1=@coords1; $numc2=@coords2;
 $bchrA1 = $chrs1[0]; $bchrB1 = $chrs2[0]; 
 $hchrA1 = $chrs1[1]; $hchrB1 = $chrs2[1];
 $dirA1 = getOrien(@coords1); $dirB1 = getOrien(@coords2); 
  
 $segA1 = $w+1 ; $segB1 = $x+1; 
 $dist_Unite = $coords2[0]-$coords1[0];

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

 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1,\@coords2,$bchrA1,$hchrA1);

 #print "Unite:@$rnam1\n@$rnam2\ncoords1:@coords1\ncoords2:@coords2\ndirs: $dirA1 $dirB1 ends: $endA1  $endA21 starts: $startB1 $startB21\n\n";
# print WR2 "Data is being analyzed2\n";

 # Merge only if chr sequence is same and there are no sub blocks in between  
 if(($bchrA1 eq $bchrB1)&&($hchrA1 eq $hchrB1)&&( (!($subovpFound12)) ) )  
{
 #print "inside \n";
   if(($dirA1 eq "Down")&&($dirB1 eq "Down")&&(($startA1 >= $startB1)||($startA21 >= $startB21)))
   { 
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU;# make new small reference
    
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update        
    $merged=1; # to indicate that the blocks were merged
   }
   elsif(($dirA1 eq "Up")&&($dirB1 eq "Up")&&(($startA1 <= $startB1)||($startA21 <= $startB21)))
   {  
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords
    @tempnm =();push(@tempnm,@$rnam1,@$rnam2);  my @namesU=@tempnm; 
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; $srefU[2]=\@namesU; # make new small reference
    my $rsrefU= \@srefU; # make new reference    #$ref[$x]->[0]=\@coordsU; #assign new coords to the existing reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update  
    $merged=1; 
   }
   
 } #1st if 
 
 
   $x +=1;
   $w +=1;
 
} #while

} #sub merge_cons_blocks

# --- sub isSg_spl (original lines 2459-2474) ---
sub isSg_spl
{
 my($rcoords3) = $ref[$x+1]->[0];
 my(@coords3) = @$rcoords3;
 my($len1_sgspl)=abs($coords1[0]-$coords1[-1]); my($len3_sgspl)=abs($coords3[0]-$coords3[-1]);
 my($len2_sgspl)=abs($coords2[0]-$coords2[-1]);
 if($coords2[0]==7350362){print "$len1_sgspl $len3_sgspl\n";}
 if(($num2_Unite ==2) &&($len2_sgspl<=1000000) ) #means this is a 2 marker singleton
 {
  if( (($len1_sgspl<=2000000)||($len3_sgspl<=2000000)) && ($merged==0) ) { #if($coords2[0]==7350362){print "here in 1\n";} 
  return(1);}
  else{  #if($coords2[0]==7350362){print "here in 0\n";}
  return(0);}
 }#if
 else {return(1);}  
} #sub

# --- sub assign_numbers (original lines 2478-2531) ---
sub assign_numbers{
$numeles = @ref; $w=0; $y=0; %coords_hash=(); my %labeled=();
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrmsZ = $ref[$w]->[1]; $rnam = $ref[$w]->[2];
 @coords =@$rcoords;  @chrs = @$rchrmsZ; #print "$w.@chrs\n";
 $y++; 
 #print "$y. chrs=@chrs coords=@coords\n @$rnam\n\n";
 #put the above coords in a hashmap
 foreach $el(@$rnam){
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
   $info[$i_num] = $y; #print "$info[$q_bchr-1] $cstart\n\n";   
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
 if($cstart =~ /\s+/)
 {
  $info[$i_num] = $pnum; $cnum=$pnum;#print "here\t";
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

} #while

} #sub

# --- sub break_big_blocks (original lines 2552-2651) ---
sub break_big_blocks {
$numeles = @ref; $x=0;$newnum = 1000;$pnum=0; @coords=(); @chrs=(); @coord_all=(); #print "num of elements = $numeles\n";
while($x < $numeles)
{ 
 $rcoords = $ref[$x]->[0]; $rchrms = $ref[$x]->[1];
 @coords =@$rcoords;  @chrs = @$rchrms; $pb_chr = $chrs[0]; $ph_chr=$chrs[1];

 $pnum++; #print "coords= @coords\n";
 
 @out = find_coords(@coords); #print "pnum = $pnum \n";print "$out[0] $out[1] $out[2]\n";  
 push(@coord_all,$pb_chr,$ph_chr,$out[0],$out[1],$pnum,$out[2],$newnum);
 #print "$pb_chr,$ph_chr,$out[0],$out[1],$pnum,$out[2],$newnum\n";
 @coords = ();

 $x+=1;
} #while

@new_info = @info;


$len = @coord_all; #print "length: $len\n"; $counter =0;
 $q_bchr=0; $r_hchr=1; $m_st=2; $n_ed=3; $i_num=4; $j_fl=5; $i_newnm =6;

while($i_newnm < $len) # reads coords of each block i.e., block by block
{ #$counter++; print "i_newnm: $i_newnm\n"; print "here\n";
 $bchr = $coord_all[$q_bchr]; $hchr = $coord_all[$r_hchr];
 $begin = $coord_all[$m_st]; $end = $coord_all[$n_ed]; 
 $bl_num = $coord_all[$i_num]; $dir = $coord_all[$j_fl];
 
 @sub_block_coords = find_sub_blocks($bchr,$hchr,$begin,$end,$bl_num,$dir);
 @bigBlbk = get_coords($bl_num);
 @sub_block_coords = filter_subBlsJ(\@sub_block_coords,\@bigBlbk);
  
 # Dont break a big block using a single marker block
 @sub_block_coords = removeSingletons(@sub_block_coords); 


 @sub_block_coords = remove2mrkerSingls(@sub_block_coords);
@sub_block_coords = removeSensBlock2(@sub_block_coords);


 $len2 = @sub_block_coords;
 $m_sb_st=0; $n_sb_ed=1; $i_sb_num=2; $j_sb_fl=3;
 while($j_sb_fl < $len2) # reads each sub block
 { 
  $sub_st = $sub_block_coords[$m_sb_st]; $sub_ed = $sub_block_coords[$n_sb_ed];
  $sub_num = $sub_block_coords[$i_sb_num]; $sub_dir = $sub_block_coords[$j_sb_fl];
  
  #reads every marker of a big block # for every block find the sub_block location  
  $len3 = @info;
  $m_st_dis=3; $n_ed_dis=4; $i_num_dis=5; $j_fl_dis=6;$i_newnm_dis = 7;
  $pstart = " "; $pend = " "; #print "$i_newnm_dis < $len3\n";
  
  while($i_newnm_dis < $len3)
  { #  print WR2 "Data is being analyzed3\n"; #print "here\n";
   $cstart = $info[$m_st_dis]; $cend = $info[$n_ed_dis]; $cnum = $info[$i_num_dis]; #print "$pend $cstart\n";
   if($cnum == $bl_num){
   if( (!($pstart =~/\s+/))&&(!($pend =~/\s+/))&&(!($cstart =~/\s+/))&&(!($cend =~/\s+/)) )
   {  #print "$pend $cstart\n";    print "here\n";
    if( ( min_num($cstart,$pend) < min_num($sub_st,$sub_ed) )&&( max_num($cstart,$pend) > max_num($sub_st,$sub_ed) ) )
    { #bp location found
      #print "\nbp loc: $pend $cstart sub_sted:$sub_st $sub_ed\n";
      break_bigblock($bl_num,$cstart,$cend,$pstart,$pend);
    }
   }
   }
   if( (!($cstart =~/\s+/) )&&(!($cend =~/\s+/)) )
   {
    $pstart = $cstart; $pend = $cend; $pnum = $cnum;
   }
 
   $m_st_dis += 8; $n_ed_dis += 8; $i_num_dis += 8; $j_fl_dis += 8; $i_newnm_dis +=8;
  } # 3rdwhile
  
  $m_sb_st += 4; $n_sb_ed += 4; $i_sb_num += 4; $j_sb_fl += 4;
 } # 2nd while

 
 $q_bchr +=7; $r_hchr +=7; $m_st +=7; $n_ed +=7; $i_num +=7; $j_fl +=7; $i_newnm +=7;
#print "$n_ed i_newnm: $i_newnm\n";
} # 1st while
#print "counter: $counter\n";

# Correct numbers 
#print "breaking big blocks ";
$lenM = @new_info;$m_stM=3; $i_numM=5; $i_newnmM = 7;$index =1;$f_r_pM = 0;  
while($i_newnmM < $lenM)
{ 
 $cstartM = $new_info[$m_stM]; $cnumM = $new_info[$i_numM]; $cnewnmM = $new_info[$i_newnmM];
 #print "$cnumM $cstartM cnewnmM=$cnewnmM\n";
 #print "$cnewnm\n";
 if(($f_r_pM == 1)&&($cnewnmM != 10000))
 { #print "$cnumM $cstartM cnewnmM=$cnewnmM\n";
  div_ref($cnumM,$cstartM); #print "in the !10000 $cnum,$cstart here\n";
 } 
 $f_r_pM = 1;
 $m_stM +=8; $i_numM += 8;  $i_newnmM +=8;
}

} #sub break_big_blocks

# --- sub Remove_singletonSubblocks (original lines 2653-2680) ---
sub Remove_singletonSubblocks
{
 my(@sub_blocks_sb)=@_; my @singles_rem =();

 # Algorithm
 #Read each block in the array @sub_blocks_sb
 #Find if it is a single marker block
 #If yes, then dont include that in the new array, @singles_rem

 #Read each block in the array @sub_blocks_sb 
 $numsubbls_sb=@sub_blocks_sb; $i_sb=0;
 while($i_sb < $numsubbls_sb)
 {
  #Find if it is a single marker block
  $num_markers = get_numMrkrs($sub_blocks_sb[2]); #print "number of markers=$num_markers\n";
  $b_chr_rm = getBchr($sub_blocks_sb[2]); #print "b_chr = $b_chr_rm\n";
  
  # check if this single-marker block is part of any other big block
  if($num_markers==1){$winBlock = withinCheck($sub_blocks_sb[0],$b_chr_rm);} #print "withinBlockcheck= $winBlock\n";
 
  #If yes, then dont include that in the new array, @singles_rem
  if(($num_markers!=1)||(($num_markers==1)&&(!$winBlock)))
  {push(@singles_rem,$sub_blocks_sb[$i_sb],$sub_blocks_sb[$i_sb+1],$sub_blocks_sb[$i_sb+2],$sub_blocks_sb[$i_sb+3]); }

  $i_sb +=4;
 } #while
 return(@singles_rem);
} # sub

# --- sub withinCheck (original lines 2683-2703) ---
sub withinCheck
{
 my($mrkr,$bchr_rm)=@_;
 # Read each block and see whether this marker belongs to that block

 $numeles_wn = @ref; $x_wn=0; @coords_wn=(); @chrs_wn=(); 
 while($x_wn < $numeles_wn)
 { 
  $rcoords_wn = $ref[$x_wn]->[0];   @coords_wn =@$rcoords_wn;  # retrieve coords  
  $rchrms_wn = $ref[$x_wn]->[1]; @chrs_wn = @$rchrms_wn; $pb_chr_wn = $chrs_wn[0]; # retrieve chrms

  @coords_wn_srt = sort{$a<=>$b}(@coords_wn); # sort coords
  
  if(($mrkr>$coords_wn_srt[0])&&($mrkr<$coords_wn_srt[-1])&&($bchr_rm eq $pb_chr_wn)) # means within the block
  {return(1); }
  
  $x_wn +=1;
 } #while
 
 return(0);
} #sub

# --- sub get_numMrkrs (original lines 2705-2720) ---
sub get_numMrkrs
{
 my($blnum_nm)= @_; my (@tmpcrd_nm)=();

 $lensub_nm = @info;
 $isub_nm=3;
 while($isub_nm < $lensub_nm)
 {
  $cstart_nm = $info[$isub_nm]; $cnum_nm = $info[$isub_nm+2];
  if($blnum_nm==$cnum_nm){  push(@tmpcrd_nm,$cstart_nm);} #retrieves req coords
  $isub_nm +=8;
 } #while
 $num_mrkrs = @tmpcrd_nm;
 return($num_mrkrs);

} #sub

# --- sub getBchr (original lines 2722-2735) ---
sub getBchr
{
 my($blnum_nm)= @_; my (@tmpcrd_nm)=();

 $lensub_nm = @info;
 $isub_nm=3;
 while($isub_nm < $lensub_nm)
 {
  $cstart_nm = $info[$isub_nm]; $cnum_nm = $info[$isub_nm+2];
  if($blnum_nm==$cnum_nm){  return($info[$isub_nm-2]);} #return bchr if the req block found
  $isub_nm +=8;
 } #while

} # sub

# --- sub get_coords (original lines 2737-2751) ---
sub get_coords{
my($blnumsub)= @_; my (@tmpcrdsbk)=();
#if($begin==47784306) { print "bl_num=$blnumsub\n";}
$lensubbk = @info;
$isubbk=3;
while($isubbk < $lensubbk)
{
 $cstartbk = $info[$isubbk]; $cnumbk = $info[$isubbk+2];
 if($blnumsub==$cnumbk){       #if($begin==47784306) { print"$cstartbk ";}
 push(@tmpcrdsbk,$cstartbk);} #retrieves req coords
 $isubbk +=8;
} #while
#print "inside get_coords:@tmpcrdsbk\n";
return(@tmpcrdsbk);
} # sub

# --- sub div_ref (original lines 2753-2795) ---
sub div_ref{

my($num,$start) = @_;
my($cond1)=0; my(@coords1,@coords2)=(); my(@names1,@names2)=();
$rcoords = $ref[$num-1]->[0]; $rchrms = $ref[$num-1]->[1]; $rnam = $ref[$num-1]->[2];
@coords =@$rcoords;  @chrs = @$rchrms; @chrs2 = @chrs; #print "\nCHRS=@chrs\n"; 
#print "\nCoords:@coords\n\n";
my $i=0;
foreach $el(@coords)
{
 if(($start==$el)&&($cond1!=1)&&(!($cstart =~ /\s+/))) { $cond1=1; } #print "$start=$el\n";
 if($cond1==0) { push(@coords1,$el); push (@names1,$$rnam[$i]);}
 elsif($cond1==1) { push(@coords2,$el);push (@names2,$$rnam[$i]); }
 $i++;
} #foreach

#Make sref for these 2 @coords
my @chrms1 = @chrs;
my @cords1 = @coords1;
my @mnames1 = @names1;
my @sref1=();
$sref1[0]= \@cords1;
$sref1[1] = \@chrms1;
$sref1[2] = \@mnames1;
my $rsref1= \@sref1;

my @chrms2 = @chrs;
my @cords2 = @coords2; #print "\n@cords1\n\n";print "\n@chrms1\n";print "\n@cords2\n";print "\n@chrms2\n";
my @mnames2 = @names2;
#print "\ncords1:@cords1\n\n"; print "\n\ncords2:@cords2\n\n";
my @sref2=();
$sref2[0]= \@cords2;
$sref2[1] = \@chrms2;
$sref2[2] = \@mnames2;
my $rsref2= \@sref2;

#insert these 2 @srefs into @ref
splice (@ref, ($num-1), 1,$rsref1,$rsref2);

# assign new numbers to @new_info with information in updated @ref
update_nums();

} #sub

# --- sub update_nums (original lines 2799-2852) ---
sub update_nums{

$numeles = @ref; $w=0; $y=0; %coords_hash=();
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrms = $ref[$w]->[1]; $rnam = $ref[$w]->[2];
 @coords =@$rcoords;  @chrs = @$rchrms; #print "@chrs\n";
 $y++; 
 
 #put the above coords in a hashmap
 foreach $el(@$rnam){
 $coords_hash{$el}=1;
 }
 
 $len = @new_info;
 $q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7;
 while($i_newnm < $len)
 {
  $cb_chr = $new_info[$q_bchr]; $ch_chr = $new_info[$r_hchr];
  $cstart = $new_info[$m_st]; $cnum = $new_info[$i_num];
  #print "$cb_chr=$chrs[0] $ch_chr=$chrs[1]\t";  print "$coords_hash{$cstart}\t";
  if((($coords_hash{$new_info[$q_bchr]-1}==1)||($cstart=~/\s+/))&&($cb_chr eq $chrs[0])&&($ch_chr eq $chrs[1]))
  {
   $new_info[$i_num] = $y; #if($y==15){print "$info[$m_st] $info[$i_num]\n";}#if($y==15){print "here\t";}
  }
  
  $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

 } #while

 %coords_hash=(); # make hashmap available for next set of coords
 $w+=1;
} #outer while

#=for
 # change numbers of microsatellites
$len = @new_info; 
$q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7; $pnum=1;
while($i_newnm < $len)
{
 $cb_chr = $new_info[$q_bchr]; $ch_chr = $new_info[$r_hchr];
 $cstart = $new_info[$m_st]; $cnum = $new_info[$i_num];

 if($cstart =~ /\s+/)
 {
  $new_info[$i_num] = $pnum; $cnum=$pnum;#print "here\t";
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;
} #while

} # sub update_nums

# --- sub merge_nors_sep_by_sing (original lines 2870-3031) ---
sub merge_nors_sep_by_sing {

$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
#($wNr,$xNr,$yNr)=iterate2($wNr,$xNr,$yNr,$numelesNr);
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

 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 

 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
  #print "Nors sep singls: @$rnam1Nr\n@$rnam2Nr\n@$rnam3Nr\nc1: @coords1Nr\nc2: @coords2Nr\nc3: @coords3Nr\n$orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\nCHR: $chrs1Nr[1] $chrs2Nr[1] $chrs3Nr[1]\n\n";

 #print WR2 "Data is being analyzed5\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
   # && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")

    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
  
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  

  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;    	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 

   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 } 

  $wNr= $xNr;  
  $xNr= $yNr;
  $yNr= $xNr+1;

  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; #print "$yNr $numCNr @coords3Nr\n";
  while( isSg(@coords3Nr) and $yNr<$numelesNr)
  { #print "$numCNr\t";
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }

} #while
}

# --- sub merge_nors_sep_small_blocks (original lines 3038-3199) ---
sub merge_nors_sep_small_blocks{

$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
#($wNr,$xNr,$yNr)=iterate2($wNr,$xNr,$yNr,$numelesNr);
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

 #print "c1: $coords1Nr[0] c2: $coords2Nr[0] c3: $coords3Nr[0] \n";
 #print "begin\n";
 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 
 #print WR2 "Data is being analyzed7\n";
 #print "end\n"; 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);

  # print "Nors sep sm: @$rnam1Nr\n@$rnam2Nr\n@$rnam3Nr\nc1: @coords1Nr\nc2: @coords2Nr\nc3: @coords3Nr\n$orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\n\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 
 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")
    #&& ($endANr<$startBNr) 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between

    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    

   }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
  
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    #&& ($endANr>$startBNr)
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  
  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 } 

  $wNr= $xNr;  
  $xNr= $yNr;
  $yNr= $xNr+1;

  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; 
  while(isSmall(@coords3Nr) and $yNr<$numelesNr)
  { #print "$numCNr\t";
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }


 #print "received: $wNr,$xNr,$yNr\n\n";
} #while
} #sub

# --- sub iterate (original lines 3201-3243) ---
sub iterate
{
 my ($wt,$xt,$yt, $numelest)=@_;

 my $rcoords1Nr_t = $ref[$wt]->[0]; 
 my $rcoords2Nr_t = $ref[$xt]->[0]; 
 my $rcoords3Nr_t = $ref[$yt]->[0]; 

 my @coords1Nr_t =@$rcoords1Nr_t; my @coords2Nr_t = @$rcoords2Nr_t; my @coords3Nr_t = @$rcoords3Nr_t;

 my $sig1=0;  my $sig2=0;  my $sig3=0;
  $sig1 = isSmall(@coords1Nr_t);
  $sig2 = isSmall(@coords2Nr_t);
  $sig3 = isSmall(@coords3Nr_t);

 # this while loop iterates until it finds 3 blocks that are not singletons, 2 mrk singletons
 while(     ( ($sig1!=0) || ($sig2!=0) || ($sig3!=0) ) # if any block is singleton or 2 mrk singleton
        && ($wt<$numelest and $xt<$numelest and $yt<$numelest)
      ) 
 {
  #print "here\n";
  
  if($sig1)              {   $wt++; $xt++; $yt++;  } 

  elsif($sig2)  { $xt++; $yt++;  }

  elsif($sig3) # else should do the same work
  { $yt++;  }  

  $rcoords1Nr_t = $ref[$wt]->[0]; 
  $rcoords2Nr_t = $ref[$xt]->[0]; 
  $rcoords3Nr_t = $ref[$yt]->[0]; 

  @coords1Nr_t =@$rcoords1Nr_t; @coords2Nr_t = @$rcoords2Nr_t; @coords3Nr_t = @$rcoords3Nr_t;

  $sig1 = isSmall(@coords1Nr_t);
  $sig2 = isSmall(@coords2Nr_t);
  $sig3 = isSmall(@coords3Nr_t); 
 }#while 

 return ($wt,$xt,$yt);

} #sub

# --- sub iterate2 (original lines 3244-3288) ---
sub iterate2   # this sub routine skips only singletons during the iteration
{
 my ($wt,$xt,$yt, $numelest)=@_;

 my $rcoords1Nr_t = $ref[$wt]->[0]; 
 my $rcoords2Nr_t = $ref[$xt]->[0]; 
 my $rcoords3Nr_t = $ref[$yt]->[0]; 

 my @coords1Nr_t =@$rcoords1Nr_t; my @coords2Nr_t = @$rcoords2Nr_t; my @coords3Nr_t = @$rcoords3Nr_t;
   # print "c1:@coords1Nr_t\nc2:@coords2Nr_t\nc3:@coords3Nr_t\n";
  my $sig1 = isSg2(@coords1Nr_t);
  my $sig2 = isSg2(@coords2Nr_t);
  my $sig3 = isSg2(@coords3Nr_t);
 #print "sigs: $sig1,$sig2,$sig3\n";

 # this while loop iterates until it finds 3 blocks that are not singletons

 while(     ( ($sig1!=0) || ($sig2!=0) || ($sig3!=0) ) # if any block is singleton or 2 mrk singleton
        && ($wt<$numelest and $xt<$numelest and $yt<$numelest)
      ) 
 {
  
  if($sig1)              {   $wt++; $xt++; $yt++;  } 

  elsif($sig2)  { $xt++; $yt++;  }

  elsif($sig3) # else should do the same work
  { $yt++;  }  

  $rcoords1Nr_t = $ref[$wt]->[0]; 
  $rcoords2Nr_t = $ref[$xt]->[0]; 
  $rcoords3Nr_t = $ref[$yt]->[0]; 

  @coords1Nr_t =@$rcoords1Nr_t; @coords2Nr_t = @$rcoords2Nr_t; @coords3Nr_t = @$rcoords3Nr_t;

  $sig1 = isSg2(@coords1Nr_t);
  $sig2 = isSg2(@coords2Nr_t);
  $sig3 = isSg2(@coords3Nr_t);
  #print "inside c1:@coords1Nr_t\nc2:@coords2Nr_t\nc3:@coords3Nr_t\n";  print "inside: $wt,$xt,$yt\n";  print "inside sigs: $sig1,$sig2,$sig3\n";

 }#while 
 #print "sub: $wt,$xt,$yt\n";
 return ($wt,$xt,$yt);

} #sub

# --- sub iterate3 (original lines 3291-3348) ---
sub iterate3
{
 my ($wt,$xt,$yt, $numelest)=@_;

 my $rcoords1Nr_t = $ref[$wt]->[0]; 
 my $rcoords2Nr_t = $ref[$xt]->[0]; 
 my $rcoords3Nr_t = $ref[$yt]->[0]; 

 my @coords1Nr_t =@$rcoords1Nr_t; my @coords2Nr_t = @$rcoords2Nr_t; my @coords3Nr_t = @$rcoords3Nr_t;
   # print "c1:@coords1Nr_t\nc2:@coords2Nr_t\nc3:@coords3Nr_t\n";
 my $sig1=0;  my $sig2=0;  my $sig3=0;
 if($block_size==0)
 {
  $sig1 = isSg(@coords1Nr_t);
  $sig2 = isSg(@coords2Nr_t);
  $sig3 = isSg(@coords3Nr_t);
 }
 else
 {
  $sig1 = isSmall(@coords1Nr_t);
  $sig2 = isSmall(@coords2Nr_t);
  $sig3 = isSmall(@coords3Nr_t);
 }
 # this while loop iterates until it finds 3 blocks that are not singletons, 2 mrk singletons

 while(    # ( ($sig1!=1) &&($sig2==0) && ($sig3!=0) ) # if either 1st or 3rd is singleton or 2 mrk singleton
         ($wt<$numelest and $xt<$numelest and $yt<$numelest)
      ) 
 {
  #print "here\n";
  if(($sig1!=1)&&($sig2==0)&&($sig3!=1)){ return ($wt,$xt,$yt);}
  
  if(($sig1!=1)&&($sig2==0)&&($sig3==0))
  { $yt++;}  
  else{ $wt++; $xt++; $yt++;  } 

  $rcoords1Nr_t = $ref[$wt]->[0]; 
  $rcoords2Nr_t = $ref[$xt]->[0]; 
  $rcoords3Nr_t = $ref[$yt]->[0]; 

  @coords1Nr_t =@$rcoords1Nr_t; @coords2Nr_t = @$rcoords2Nr_t; @coords3Nr_t = @$rcoords3Nr_t;

 if($block_size==0)
 {
  $sig1 = isSg(@coords1Nr_t);
  $sig2 = isSg(@coords2Nr_t);
  $sig3 = isSg(@coords3Nr_t);
 }
 else
 {
  $sig1 = isSmall(@coords1Nr_t);
  $sig2 = isSmall(@coords2Nr_t);
  $sig3 = isSmall(@coords3Nr_t); 
 }
 }#while 


} #sub

# --- sub isSmall (original lines 3354-3363) ---
sub isSmall
{
 my(@crd_ism)=@_;
 my @crd_ism_srt = sort{$a <=> $b} (@crd_ism);
 my $diff_ism = abs($crd_ism_srt[0]-$crd_ism_srt[-1]);

 if ($diff_ism<=$block_size){return(1);} 
 else{return(0);}

}

# --- sub break_blocks_with_subovp (original lines 3572-3749) ---
sub break_blocks_with_subovp{ #print "inside break blocks\n";
$numelesBr = @ref; $xBr=0;
while($xBr < $numelesBr)
{ 
 # get coords and chrs of a block from @ref(array of references)
 $rcoords1Br = $ref[$xBr]->[0]; $rchrms1Br = $ref[$xBr]->[1]; $rnam1Br = $ref[$xBr]->[2];
 my @coords1Br =@$rcoords1Br; my @chrs1Br = @$rchrms1Br; my @coords1Br_srt = sort{$a<=>$b}(@coords1Br);

 $num_Br=@coords1Br; #print WR2 "Data is being analyzed14\n"; #print "break bl with subovp: @$rnam1Br\n $num_Br c1: @coords1Br\n";
 for(my $ir=0; $ir<$num_Br; $ir++)          {   $mark_hash{$coords1Br[$ir]}=$$rnam1Br[$ir]; }

 # put array @coords1Br into hash map
 %tmpHashBr=();
 foreach $tmpelBr(@coords1Br){ $tmpHashBr{$tmpelBr}=1; } 

 #find ovp block
 $numelesLp = @ref; $xLp=0; #print "$coords1Br[0] $xLp < $numelesLp\n";
 while($xLp < $numelesLp)
 { 
  # get coords and chrs of a block from @ref(array of references)
  $rcoords1Lp = $ref[$xLp]->[0]; $rchrms1Lp = $ref[$xLp]->[1]; $rnam1Lp = $ref[$xLp]->[2];
  my @coords1Lp =@$rcoords1Lp; my @chrs1Lp = @$rchrms1Lp; my @coords1Lp_srt = sort{$a<=>$b}(@coords1Lp);
  $num_Lp=@coords1Lp;
  for(my $ir=0; $ir<$num_Lp; $ir++)          {   $mark_hash{$coords1Lp[$ir]}=$$rnam1Lp[$ir]; }
  
  # put array @coords1Lp into hash map
  %tmpHashLp=();
  foreach $tmpelLp(@coords1Lp){ $tmpHashLp{$tmpelLp}=1; }   

  $tm_LP= ovpBl(\@coords1Lp_srt,@chrs1Lp,\@coords1Br_srt,@chrs1Br); #print WR2 "Data is being analyzed15\n"; #print "Lp: $tm_LP @$rnam1Lp\n@coords1Lp\n\n";

  # See if this is the ovp block
  if((ovpBl(\@coords1Lp_srt,@chrs1Lp,\@coords1Br_srt,@chrs1Br)))
  { 
    #retrieve ovp region 
    my @ovpreg=(); my @ovpregf=(); my @ovpregs=(); @tmp_Lp_Br=();
    push(@tmp_Lp_Br,@coords1Lp_srt,@coords1Br_srt); @tmp_Lp_Br=sort{$a<=>$b}(@tmp_Lp_Br);
    
    if($tmpHashBr{$tmp_Lp_Br[0]}==1) # means first half of the big block contains Br block
    {
     $ovpStart=0; $ovpMid =0; $ovpStop=0; 
     foreach $LpBr(@tmp_Lp_Br)
     {
      if(($tmpHashLp{$LpBr}==1)&&($ovpStart==0)) {$ovpStart=1;} # means starting point of ovp region found
      if(($tmpHashBr{$LpBr}==1)&&($ovpStart==1)&&($ovpMid ==0)){$ovpMid =1;} # means mid point of ovp region reached
      if(($tmpHashLp{$LpBr}==1)&&($ovpStart==1)&&($ovpMid==1)&&($ovpStop==0 )){$ovpStop=1;} # means end of ovp region reached
      if(($ovpStart==1)&&($ovpStop==0)&&($ovpMid==0)){push(@ovpregf,$LpBr);} # retrieve first half of ovp region
      if(($ovpStart==1)&&($ovpStop==0)&&($ovpMid==1)){push(@ovpregs,$LpBr);} # retrieve first half of ovp region
     } #foreach
    } #if
    elsif($tmpHashLp{$tmp_Lp_Br[0]}==1) # means first half of the big block contains Lp block
    { #print "@tmp_Lp_Br\n";
     $ovpStart=0; $ovpMid =0; $ovpStop=0; 
     foreach $LpBr(@tmp_Lp_Br)
     { 
      if(($tmpHashBr{$LpBr}==1)&&($ovpStart==0)) {$ovpStart=1;} # means starting point of ovp region found
      elsif(($tmpHashLp{$LpBr}==1)&&($ovpStart==1)&&($ovpMid ==0)){$ovpMid =1;} # means mid point of ovp region reached
      elsif(($tmpHashBr{$LpBr}==1)&&($ovpStart==1)&&($ovpMid==1)&&($ovpStop==0 )){$ovpStop=1;} # means end of ovp region reached
      if(($ovpStart==1)&&($ovpStop==0)&&($ovpMid==0)){ #print "f:$LpBr\n";
      push(@ovpregf,$LpBr);} # retrieve first half of ovp region
      elsif(($ovpStart==1)&&($ovpStop==0)&&($ovpMid==1)){ #print "s:$LpBr\n"; 
      push(@ovpregs,$LpBr);} # retrieve second half of ovp region
    
     } #foreach
    } #elsif

    #Determine the number of blocks that could be formed, then break it

    # Make ovpregf contains coords of Br  and ovpregs contains coords of Lp
    if($tmpHashBr{$ovpregf[0]}){}
    elsif($tmpHashLp{$ovpregf[0]}){@tmp_s=@ovpregs; @ovpregs=@ovpregf;@ovpregf=@tmp_s;}

    my $isSg_f = isSg(@ovpregf);
    my $isSg_s = isSg(@ovpregs);

   
    #if singletons then delete them
    if(     ((isSg(@ovpregf))&& (isSg(@ovpregs))) # S and S
      )
    { 
     # for block coords1Br, @ovpregf
     foreach $tmp_f(@ovpregf)
     { $num_Br=@coords1Br;
      for($i_f=0;$i_f<$num_Br;$i_f++)
      {
       if($coords1Br[$i_f]==$tmp_f){splice(@coords1Br,$i_f,1); splice(@$rnam1Br,$i_f,1);$i_f--;$num_Br--; } # deletes req marker
      } #for
     } #foreach
     # for block coords1Lp, @ovpregs
     foreach $tmp_s(@ovpregs)
     { $num_Lp=@coords1Lp;
      for($i_s=0;$i_s<$num_Lp;$i_s++)
      {
     #  if($coords1Lp[$i_s]==$tmp_s){splice(@coords1Lp,$i_s,1); splice(@$rnam1Lp,$i_s,1);$i_s--;$num_Lp--; }
      } #for
     } #foreach
     my @srefBr = (); $srefBr[0]=\@coords1Br; $srefBr[1]=\@chrs1Br; my @names1Br=@$rnam1Br; $srefBr[2]=\@names1Br; # make new small reference for Br block coords
     my $rsrefBr= \@srefBr; # make new reference    
     splice(@ref,$xBr,1,$rsrefBr); # Replace contents at position $xBr

    # my @srefLp = (); $srefLp[0]=\@coords1Lp; $srefLp[1]=\@chrs1Lp; my @names1Lp=@$rnam1Lp; $srefLp[2]=\@names1Lp; # make new small reference for Lp block coords
    # my $rsrefLp= \@srefLp; # make new reference    
    # splice(@ref,$xLp,1,$rsrefLp); # Replace contents at position $xLp
    }
    elsif(($isSg_f==0)&& ($isSg_s!=0)) # NS and S
    { #print "s:@ovpregs\n";
     foreach $tmp_s(@ovpregs) # Delete the singleton
     { $num_Lp=@coords1Lp; #print "Before: No.$num_Lp\n";
      for($i_s=0;$i_s<$num_Lp;$i_s++)
      {
       if($coords1Lp[$i_s]==$tmp_s){ #print "$coords1Lp[$i_s]\n";
          splice(@coords1Lp,$i_s,1);splice(@$rnam1Lp,$i_s,1); $i_s--;$num_Lp--; $num_Lp=@coords1Lp; #print"Aft:@coords1Lp\n"; #print "After: No.$num_Lp\n";
         }
      } #for
     } #foreach
     my @srefLp = (); $srefLp[0]=\@coords1Lp; $srefLp[1]=\@chrs1Lp; my @names1Lp=@$rnam1Lp; $srefLp[2]=\@names1Lp; # make new small reference for Lp block coords
     my $rsrefLp= \@srefLp; # make new reference    
     splice(@ref,$xLp,1,$rsrefLp); # Replace contents at position $xLp
    } #elsif
    elsif(($isSg_f!=0)&&($isSg_s==0) ) # S and NS
    {
     # for block coords1Br, @ovpregf
     foreach $tmp_f(@ovpregf)
     { $num_Br=@coords1Br;
      for($i_f=0;$i_f<$num_Br;$i_f++)
      {
       if($coords1Br[$i_f]==$tmp_f){splice(@coords1Br,$i_f,1);splice(@$rnam1Br,$i_f,1); $i_f--;$num_Br--; } # deletes req marker
      } #for
     } #foreach
     my @srefBr = (); $srefBr[0]=\@coords1Br; $srefBr[1]=\@chrs1Br; my @names1Br=@$rnam1Br; $srefBr[2]=\@names1Br; # make new small reference for Br block coords
     my $rsrefBr= \@srefBr; # make new reference    
     splice(@ref,$xBr,1,$rsrefBr); # Replace contents at position $xBr
    }
    elsif( ($isSg_f==0)&&($isSg_s==0) ) # NS and NS
    {     
     # for block coords1Br, @ovpregf
     foreach $tmp_f(@ovpregf)
     { $num_Br=@coords1Br;
      for($i_f=0;$i_f<$num_Br;$i_f++)
      {
       if($coords1Br[$i_f]==$tmp_f){splice(@coords1Br,$i_f,1);splice(@$rnam1Br,$i_f,1); $i_f--;$num_Br--; } # deletes req marker
      } #for
     } #foreach
     # for block coords1Lp, @ovpregs
     foreach $tmp_s(@ovpregs)
     { $num_Lp=@coords1Lp;
      for($i_s=0;$i_s<$num_Lp;$i_s++)
      {
     #  if($coords1Lp[$i_s]==$tmp_s){splice(@coords1Lp,$i_s,1);splice(@$rnam1Lp,$i_s,1); $i_s--;$num_Lp--; }
      } #for
     } #foreach
     my @srefBr = (); $srefBr[0]=\@coords1Br; $srefBr[1]=\@chrs1Br; my @names1Br=@$rnam1Br; $srefBr[2]=\@names1Br; # make new small reference for Br block coords
     my $rsrefBr= \@srefBr; # make new reference    
     splice(@ref,$xBr,1,$rsrefBr); # Replace contents at position $xBr

    # my @srefLp = (); $srefLp[0]=\@coords1Lp; $srefLp[1]=\@chrs1Lp; my @names1Lp=@$rnam1Lp; $srefLp[2]=\@names1Lp; # make new small reference for Lp block coords
    # my $rsrefLp= \@srefLp; # make new reference    
    # splice(@ref,$xLp,1,$rsrefLp); # Replace contents at position $xLp

     my @srefBr = (); $srefBr[0]=\@ovpregf; $srefBr[1]=\@chrs1Br; my @namesf=getnames(@ovpregf); $srefBr[2]=\@namesf; # make new small reference for ovpregf block 
     my $rsrefBr= \@srefBr; # make new reference    
     push(@ref,$rsrefBr); $numelesBr++; $numelesLp++; # Add at the end of @ref

    # my @srefLp = (); $srefLp[0]=\@ovpregs; $srefLp[1]=\@chrs1Lp; my @namess=getnames(@ovpregs); $srefLp[2]=\@namess; # make new small reference for ovpregs block 
    # my $rsrefLp= \@srefLp; # make new reference    
    # push(@ref,$rsrefLp); $numelesBr++; $numelesLp++; # Add at the end of @ref
    }
  
    
  } #if

  $xLp++;
 } #inner while


 $xBr++;
} #while
} #sub

# --- sub getnames (original lines 3750-3758) ---
sub getnames
{
 my @cds = @_;
 my @tem =();
 my $elem =();
 foreach $elem (@cds)
 {push (@tem,$mark_hash{$elem});}
 return (@tem);
}

# --- sub subovpBl (original lines 3760-3784) ---
sub subovpBl
{
 my($r_Lp,$bcr_Lp,$hcr_Lp,$r_Br,$bcr_Br,$hcr_Br)=@_; #print "$bcr_Lp,$hcr_Lp,$bcr_Br,$hcr_Br\t";
 my(@coords1Lp_sb)=@$r_Lp; my(@coords1Br_sb)=@$r_Br; # sub block and main block respectively
 $num_Lp=@coords1Lp_sb; $num_Br=@coords1Br_sb;
 if(($num_Br>2)&&($num_Lp>2)&&($hcr_Lp eq $hcr_Br)&&($coords1Lp_sb[0]!=$coords1Br_sb[0]))
 {
  # bottom of sub block is overlapped on to top of the main block
  if(  ($coords1Lp_sb[-1]>$coords1Br_sb[0]) && ($coords1Lp_sb[-1]<$coords1Br_sb[-1]) && ($coords1Lp_sb[0]<$coords1Br_sb[0])
    )
  {
   #print "$num_Br $num_Lp 1.@coords1Lp_sb Br:@coords1Br_sb\n";
   return(1);
   } 
  # top of sub block is overlapped on to bottom of main block
  elsif( ($coords1Lp_sb[0]<$coords1Br_sb[-1])&&($coords1Lp_sb[0]>$coords1Br_sb[0])&&($coords1Lp_sb[-1]>$coords1Br_sb[-1])
       )
  {
   #print "$num_Br $num_Lp 2.@coords1Lp_sb Br:@coords1Br_sb\n";
   return(1);
  } 
  else{return(0);}
 }
 else{return(0);} 
} #sub

# --- sub ovpBl (original lines 3786-3810) ---
sub ovpBl
{
 my($r_Lp,$bcr_Lp,$hcr_Lp,$r_Br,$bcr_Br,$hcr_Br)=@_; #print "$bcr_Lp,$hcr_Lp,$bcr_Br,$hcr_Br\t";
 my(@coords1Lp_sb)=@$r_Lp; my(@coords1Br_sb)=@$r_Br; # sub block and main block respectively
 $num_Lp=@coords1Lp_sb; $num_Br=@coords1Br_sb;
 if(($num_Br>2)&&($num_Lp>2)&&($hcr_Lp eq $hcr_Br)&&($coords1Lp_sb[0]!=$coords1Br_sb[0]))
 {
  # bottom of sub block is overlapped on to top of the main block
  if(  ($coords1Lp_sb[-1]>$coords1Br_sb[0]) && ($coords1Lp_sb[-1]<$coords1Br_sb[-1]) && ($coords1Lp_sb[0]<$coords1Br_sb[0])
    )
  {
   #print "$num_Br $num_Lp 1.@coords1Lp_sb Br:@coords1Br_sb\n";
   return(1);
   } 
  # top of sub block is overlapped on to bottom of main block
  elsif( ($coords1Lp_sb[0]<$coords1Br_sb[-1])&&($coords1Lp_sb[0]>$coords1Br_sb[0])&&($coords1Lp_sb[-1]>$coords1Br_sb[-1])
       )
  {
   #print "$num_Br $num_Lp 2.@coords1Lp_sb Br:@coords1Br_sb\n";
   return(1);
  } 
  else{return(0);}
 }
 else{return(0);} 
} #sub

# --- sub subBl (original lines 3812-3828) ---
sub subBl
{
 my($r_Lp,$bcr_Lp,$hcr_Lp,$r_Br,$bcr_Br,$hcr_Br)=@_; #print "$bcr_Lp,$hcr_Lp,$bcr_Br,$hcr_Br\t";
 my(@coords1Lp_sb)=@$r_Lp; my(@coords1Br_sb)=@$r_Br; # sub block and main block respectively
 $num_Lp=@coords1Lp_sb; $num_Br=@coords1Br_sb;
 if(($num_Br>2)&&($num_Lp>2)&&($hcr_Lp eq $hcr_Br)&&($coords1Lp_sb[0]!=$coords1Br_sb[0]))
 {    
   if(  ($coords1Lp_sb[-1]>$coords1Br_sb[0]) && ($coords1Lp_sb[-1]<$coords1Br_sb[-1]) && ($coords1Lp_sb[0]>$coords1Br_sb[0]) && ($coords1Lp_sb[0]<$coords1Br_sb[-1]) 
    )
   {
   #print "$num_Br $num_Lp 1.@coords1Lp_sb Br:@coords1Br_sb\n";
   return(1);
   }
   else{return(0);}
 }
 else{return(0);} 
} #sub

# --- sub isSg2 (original lines 3831-3838) ---
sub isSg2{ # This doesn't check 2 marker singletons
my(@crd_isg)=@_;
$num_isg = @crd_isg;

if ($num_isg==1){return(1);} # checks for 1 marker singleton
else{return(0);}

} # sub

# --- sub merge_blocks_sep_by_singl (original lines 3845-3965) ---
sub merge_blocks_sep_by_singl{
$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    

 $rcoords1Nr = $ref[$wNr]->[0]; $rchrms1Nr = $ref[$wNr]->[1];  $rnam1Nr = $ref[$wNr]->[2];
 $rcoords2Nr = $ref[$xNr]->[0]; $rchrms2Nr = $ref[$xNr]->[1];  $rnam2Nr = $ref[$xNr]->[2];
 $rcoords3Nr = $ref[$yNr]->[0]; $rchrms3Nr = $ref[$yNr]->[1];  $rnam3Nr = $ref[$yNr]->[2];

 @coords1Nr =@$rcoords1Nr; @coords2Nr = @$rcoords2Nr; @coords3Nr = @$rcoords3Nr;

 #print "crds1:@coords1Nr\ncrds2:@coords2Nr\ncrds3:@coords3Nr\n";




  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; #print "$yNr $numCNr @coords3Nr\n";
  while(isSg(@coords3Nr) and $yNr<$numelesNr)
  { #print "$numCNr\t";
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }

#($wNr,$xNr,$yNr)=iterate2($wNr,$xNr,$yNr,$numelesNr);
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

 if($orB eq "Up"){ @coords2Nr_srt = sort{$a <=> $b}(@coords2Nr);}
 elsif($orB eq "Down"){@coords2Nr_srt = sort{$b <=> $a}(@coords2Nr);}
 else{@coords2Nr_srt = @coords2Nr;}

 if($orC eq "Up"){ @coords3Nr_srt = sort{$a <=> $b}(@coords3Nr);}
 elsif($orC eq "Down"){@coords3Nr_srt = sort{$b <=> $a}(@coords3Nr);}
 else{@coords3Nr_srt = @coords3Nr;}

 #get start and end of blocks 1 and 3
 $startANr = $coords1Nr_srt[0]; $endANr = $coords1Nr_srt[-1];
 $startBNr = $coords2Nr_srt[0]; $endBNr = $coords2Nr_srt[-1];
 $startCNr = $coords3Nr_srt[0]; $endCNr = $coords3Nr_srt[-1];

# print "@$rnam1Nr\n c1: @coords1Nr \nc2: $coords2Nr[0] c3: $coords3Nr[0] \n";
 #print WR2 "Data is being analyzed16\n";
 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 

 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
  #print "bls sep SINGLS: crds1:@$rnam1Nr\ncrds2:@$rnam2Nr\ncrds3:@$rnam3Nr\n";
  #print "crds1:@coords1Nr\ncrds2:@coords2Nr\ncrds3:@coords3Nr\n";
  #print "$orA\t$orB\t$orC $subovpFound12 $subovpFound23 $endANr<$startBNr $endBNr<$startCNr\n\n";

 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Down")&&($orA eq "Down") &&($startANr>=$startBNr)    
    && (!($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 } #if nors 
 elsif( ($orB eq "Up")&&($orA eq "Up") &&($startANr<=$startBNr)   
    &&( !($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 }
   # conditions b/n B and C starts here
 elsif(   ($orB eq "Down")&&($orC eq "Down") &&($startBNr>=$startCNr)    
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  
 }
 elsif(($orB eq "Up")&&($orC eq "Up") &&($startBNr<=$startCNr)    
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
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

  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; #print "$yNr $numCNr @coords3Nr\n";
  while(isSg(@coords3Nr) and $yNr<$numelesNr)
  { #print "$numCNr\t";
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }
} #while

}

# --- sub merge_blocks_with_sing_sep_by_singl (original lines 3969-4139) ---
sub merge_blocks_with_sing_sep_by_singl{

$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
($wNr,$xNr,$yNr)=iterate2($wNr,$xNr,$yNr,$numelesNr);
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

 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 

 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
 #print WR2 "Data is being analyzed17\n";
 #print "Merge 2mrk singls: @$rnam1Nr\n@$rnam2Nr\n@$rnam3Nr\nc1: @coords1Nr\nc2: @coords2Nr\nc3: @coords3Nr\n$orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\n\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
   # && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")

    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
  
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  

  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;    	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 

   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 } 
  
  if(sing2mrk($xNr)) # ((@$ref[$xNr]->[0])==2) and $ref[$xNr]->[0] )
  { 
   $wNr= $wNr;  
   $xNr= $yNr;
   $yNr= $xNr+1;
  }
  else
  {
   $wNr= $xNr;  
   $xNr= $yNr;
   $yNr= $xNr+1;
  }

  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; #print "$yNr $numCNr @coords3Nr\n";
  while( (isSg(@coords3Nr))==1 and $yNr<$numelesNr)
  { #print "$numCNr\t";
   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
  }

} #while
}

# --- sub sing2mrk (original lines 4141-4153) ---
sub sing2mrk
{
 my ($Nr) = @_;
 my $rcd = $ref[$Nr]->[0];
 my @cd = @$rcd; 

 my $num_isg = @cd;

 # checks 2 marker singleton
 if($num_isg==2){if((distbn($crd_isg[0],$crd_isg[1]))<$distBnMrks) {return(1);}else{return(0);} }

 
}

# --- sub merge_blocks_sep_by_smal (original lines 4157-4380) ---
sub merge_blocks_sep_by_smal{
$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
#($wNr,$xNr,$yNr)=iterate2($wNr,$xNr,$yNr,$numelesNr);
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

 if($orB eq "Up"){ @coords2Nr_srt = sort{$a <=> $b}(@coords2Nr);}
 elsif($orB eq "Down"){@coords2Nr_srt = sort{$b <=> $a}(@coords2Nr);}
 else{@coords2Nr_srt = @coords2Nr;}

 if($orC eq "Up"){ @coords3Nr_srt = sort{$a <=> $b}(@coords3Nr);}
 elsif($orC eq "Down"){@coords3Nr_srt = sort{$b <=> $a}(@coords3Nr);}
 else{@coords3Nr_srt = @coords3Nr;}

 #get start and end of blocks 1 and 3
 $startANr = $coords1Nr_srt[0]; $endANr = $coords1Nr_srt[-1];
 $startBNr = $coords2Nr_srt[0]; $endBNr = $coords2Nr_srt[-1];
 $startCNr = $coords3Nr_srt[0]; $endCNr = $coords3Nr_srt[-1];    

 #print "@$rnam1Nr\n c1: @coords1Nr \nc2: $coords2Nr[0] c3: $coords3Nr[0] \n";
 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 
 #print "end\n"; 
 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
 #print WR2 "Data is being analyzed18\n";
 #print "merge sm: @$rnam1Nr\n@$rnam2Nr\n@$rnam3Nr\nc1: @coords1Nr\nc2: @coords2Nr\nc3: @coords3Nr\n$orA $orB $orC $subovpFound12 $subovpFound23 $tmp_nor\n\n";
 #print "crds1:@coords1Nr\ncrds2:@coords2Nr\ncrds3:@coords3Nr\n";
 #print "$orA\t$orB\t$orC $subovpFound12 $subovpFound23 $endANr<$startBNr $endBNr<$startCNr\n\n";
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Down")&&($orA eq "Down") &&($endANr>=$startBNr)    
    && (!($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update     
 } #if nors 
 elsif( ($orB eq "Up")&&($orA eq "Up") &&($endANr<=$startBNr)   
    &&( !($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	@tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; 
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update     
 }
   # conditions b/n B and C starts here
 elsif(   ($orB eq "Down")&&($orC eq "Down") &&($endBNr>=$startCNr)    
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif(($orB eq "Up")&&($orC eq "Up") &&($endBNr<=$startCNr)    
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; @srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
   # && (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")

    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
  
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm;
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr;# make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update    
  

  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; @tempnm =();push(@tempnm,@$rnam1Nr,@$rnam2Nr);  my @namesUNr=@tempnm; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;    	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; 	splice(@ref,$wNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {

  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 

   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm; 
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; $srefUNr[2]=\@namesUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; # replace and update  

  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; @tempnm =();push(@tempnm,@$rnam2Nr,@$rnam3Nr);  my @namesUNr=@tempnm;  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr;$srefUNr[2]=\@namesUNr;  my $rsrefUNr= \@srefUNr; 	splice(@ref,$yNr,1,$rsrefUNr); splice(@ref,$xNr,1);  $numelesNr--; $xNr= $wNr; $yNr= $yNr-1; 
  }
 }


  $rcoords2Nr = $ref[$xNr]->[0];  @coords2Nr = @$rcoords2Nr;  #if($coords2Nr[0]== 27267828 ) { 
	#print "inside: crds1:@coords1Nr\ncrds2:@coords2Nr\ncrds3:@coords3Nr\n"; #}

  if(isSmall(@coords2Nr)) # ((@$ref[$xNr]->[0])==2) and $ref[$xNr]->[0] )
  { 
   $wNr= $wNr;  
   $xNr= $yNr;
   $yNr= $xNr+1;
  }
  else
  {
   $wNr= $xNr;  
   $xNr= $yNr;
   $yNr= $xNr+1;
  }
#  $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr; #print "$yNr $numCNr @coords3Nr\n";
#  while(isSmall(@coords3Nr) and $yNr<$numelesNr)
#  { #print "$numCNr\t";
#   $yNr++;   $rcoords3Nr = $ref[$yNr]->[0];  @coords3Nr = @$rcoords3Nr; $numCNr= @coords3Nr;
#  }
} #while

}

# --- sub part_of_diffBlock (original lines 4620-4650) ---
sub part_of_diffBlock{

my(@coords_chrms_Cy)=@_;
my($hchr_Cy)= pop(@coords_chrms_Cy); my($bchr_Cy)= pop(@coords_chrms_Cy); # gets chr info
my(@coords_sb)=@coords_chrms_Cy; # gets coords of singleton
my @coords_sb_srt = sort (@coords_sb);
my @coordsPr=();  my @coordsPr_srt =();

# Read all coords and check if the singleton can be part of any block
$numelesPr = @ref; $wPr=0; 
while($wPr < $numelesPr)
{ 
 # get coords and chrs of a block from @ref(array of references)
 $rcoordsPr = $ref[$wPr]->[0]; $rchrmsPr = $ref[$wPr]->[1]; 
 @coordsPr =@$rcoordsPr; @chrsPr = @$rchrmsPr; 
 @coordsPr_srt = sort{$a <=> $b}(@coordsPr);

 if($coords_sb_srt[-1]!=$coordsPr_srt[-1]) # means both arrays are not same
 {
  #if($coords_sb_srt[0]==191667099 or $coords_sb_srt[0]==191781622) {print "@coordsPr\npart of diff: $coords_sb_srt[0]>=$coordsPr_srt[0] and $coords_sb_srt[0]<=$coordsPr_srt[-1] and $chrsPr[0]==$bchr_Cy and $chrsPr[1]==$hchr_Cy\n";}
#  if($coords_sb_srt[0]==156742388 or $coords_sb_srt[0]==200277045) {print "@coordsPr\npart of diff: $coords_sb_srt[0]>=$coordsPr_srt[0] and $coords_sb_srt[0]<=$coordsPr_srt[-1] and $chrsPr[0]==$bchr_Cy and $chrsPr[1]==$hchr_Cy\n";}
  #print "$coords_sb_srt[0]>$coordsPr_srt[0] and $coords_sb_srt[0]<$coordsPr_srt[-1]\n\n";
  if($coords_sb_srt[0]>=$coordsPr_srt[0] and $coords_sb_srt[0]<=$coordsPr_srt[-1] and $chrsPr[1] eq $hchr_Cy)
  #if( (inside(\@coords_sb,$bchr_Cy,$hchr_Cy,\@coordsPr,$chrsPr[0],$chrsPr[1])) #||
  #  )
  {return(1);} #if
 }
 $wPr +=1; #increments the index of the array @ref
} #while
return(0); # comes here when there are no blocks the singleton could go in
} #sub

# --- sub top (original lines 4652-4668) ---
sub top {
my(@coords_inf)=@_;
# coords and chrms of singleton
my($rcoords_sg)=$coords_inf[0];my($bchr_sg)=$coords_inf[1]; my($hchr_sg)=$coords_inf[2]; 
my(@coords_sg)=@$rcoords_sg;
# coords and chrms of diff block
my($rcoords_df)=$coords_inf[3];my($bchr_df)=$coords_inf[4]; my($hchr_df)=$coords_inf[5]; 
my(@coords_df)=@$rcoords_df;

if(($bchr_sg eq $bchr_df)&&($hchr_sg eq $hchr_df))
{
 if(!(subovp_blocksM_found(\$coords_sg[0],\$coords_df[0],$bchr_sg,$hchr_sg)))
 {return(1);} #inner if
 else{return(0);}
} #if

} #sub

# --- sub bottom (original lines 4670-4688) ---
sub bottom {
my(@coords_inf)=@_;
# coords and chrms of singleton
my($rcoords_sg)=$coords_inf[0];my($bchr_sg)=$coords_inf[1]; my($hchr_sg)=$coords_inf[2]; 
my(@coords_sg)=@$rcoords_sg;
# coords and chrms of diff block
my($rcoords_df)=$coords_inf[3];my($bchr_df)=$coords_inf[4]; my($hchr_df)=$coords_inf[5]; 
my(@coords_df)=@$rcoords_df;
$num_df = @coords_df; $lastele_df= $num_df-1;

if(($bchr_sg eq $bchr_df)&&($hchr_sg eq $hchr_df)&&($num_df !=0)) #num_df!=0 prevents checking blocks with ZERO markers
#if(($bchr_sg==$bchr_df)&&($hchr_sg==$hchr_df))
{
 if(!(subovp_blocksM_found(\$coords_df[-1],\$coords_sg[0],$bchr_sg,$hchr_sg))) # The only part that is different from top
 {return(1);} #inner if
 else{return(0);}
} #if

} #sub

# --- sub inside (original lines 4690-4714) ---
sub inside {
my(@coords_inf)=@_;
# coords and chrms of singleton
my($rcoords_sg)=$coords_inf[0];my($bchr_sg)=$coords_inf[1]; my($hchr_sg)=$coords_inf[2]; 
my(@coords_sg)=@$rcoords_sg; 
# coords and chrms of diff block
my($rcoords_df)=$coords_inf[3];my($bchr_df)=$coords_inf[4]; my($hchr_df)=$coords_inf[5]; 
my(@coords_df)=@$rcoords_df; @coords_df_srt = sort{$a<=>$b}(@coords_df);
#if($coords_sg[0]==32298191){print "Bls Checked: $coords_df[0]\t";}if($coords_sg[0]==32298191){print "singleton hchr: $hchr_sg bl hchr:$hchr_df\n";}
if($hchr_sg eq $hchr_df) # only human chrs should be same
{ 
 $pele_ins =0; #if($coords_sg[0]==32298191){print "Bls Checked: $coords_df[0]\t";}
 foreach $ele_ins(@coords_df_srt)
 {
  if($pele_ins != 0)
  { #if(($coords_sg[0]==31989920)&&($coords_df[0]==62718410)) {print "$pele_ins $ele_ins\n";}
   if(($coords_sg[0]>$pele_ins)&&($coords_sg[0]<$ele_ins)) # checks if marker is in b/n
   {return(1);}
  } #if
  $pele_ins = $ele_ins;
 } #foreach
 
} #if
 return(0);
} #sub

# --- sub indp (original lines 4812-4834) ---
sub indp
{
	my @nams2mrk = @_; my $rnames=(); my @names=(); my $begin=0; my $end=0; my $ins =0; my @first=(); my @second =(); my %names_hash =(); my @tp_first=(); my $len = @info; my $put=0;
	for my $x (0..$#ref) # foreach block check if the 2 marker singletons are present inside
	{
	 	$rnames = $ref[$x]->[2]; @names = @$rnames; $begin=0; $end=0; %names_hash =(); @tp_first=(); $put =0; #print WR2 "Data is being analyzed24a\n"; #print "@names\n\n";
		foreach my $el(@names){ $names_hash{$el}=1; }#print WR2 "Data is being analyzed24b\n";}
		if($names[0] ne $nams2mrk[0])
		{
			for (my $i=0;$i<$len;$i=$i+8) 
			{      # print WR2 "Data is being analyzed24c\n";
				if($names_hash{$info[$i]} and $begin==0) {$begin=1;}
				if($names[-1] eq $info[$i]){$end=1;}
				if($begin==1 and $end==0 and $ins==0 and ($info[$i] eq $nams2mrk[0] or $info[$i] eq $nams2mrk[1])){$ins=1; $put =1; push(@tp_first,$info[$i+3]); @first=@tp_first; } #if($nams2mrk[0] eq "CT109528") {print "$info[$i] first:@first\n";} }
				if($begin==1 and $end==0 and $put==1 and $names_hash{$info[$i]}){push(@second,$info[$i+3]);}
				if($begin==1 and $end==0 and $ins==0 and $names_hash{$info[$i]}){push(@tp_first,$info[$i+3]);} # print "@tp_first\n@names\n\n"; }
			}
		}
	}
	if($ins==1 and ((blockDist(@first))<$jumping_dist or (blockDist(@second))<$jumping_dist)){return(2);} #the 2 marker singleton is inside an HSB and it can exit
	if($ins==1){return(0);} # the 2 marker singleton is inside an HSB
	else{	return(1);} # The 2 marker block is not inside any other foreign HSB. This means it is an independent block.
}

# --- sub subovp_blocksM_found (original lines 4836-4852) ---
sub subovp_blocksM_found{
my(@big_block_crds)=@_; my @subovp_block_coords =(); #print "coords=@big_block_crds\n";
$hchr_sbovp = pop(@big_block_crds); $bchr_sbovp = pop(@big_block_crds);
my $rcrds2_M = pop(@big_block_crds); my $rcrds1_M = pop(@big_block_crds);
@subovp_block_coords = find_subRovp_blocks($rcrds1_M, $rcrds2_M,$bchr_sbovp,$hchr_sbovp);

@subovp_block_coords = Remove_singletonSubblocks2(@subovp_block_coords);
if($block_size==0)
{                 
 @subovp_block_coords = remove2mrkerSingls2(@subovp_block_coords);
}
else {@subovp_block_coords = removeSensBlock(@subovp_block_coords);}

$num_blks = @subovp_block_coords; 
 #if($big_block_crds[-1]==41463181){ print "big:@big_block_crds\n $subovp_block_coords @subovp_block_coords number of blocks = $num_blks\n"; }
if($num_blks>=1){return(1);}else{return(0);}
} #sub

# --- sub subovp_blocksM_found2 (original lines 4856-4876) ---
sub subovp_blocksM_found2{
my(@big_block_crds)=@_; #print "coords=@big_block_crds\n";
$hchr_sbovp = pop(@big_block_crds); $bchr_sbovp = pop(@big_block_crds);
my $rcrds2_M2 = pop(@big_block_crds); my $rcrds1_M2 = pop(@big_block_crds);
#my @crds1_M = $rcrds1_M; my @crds2_M = $rcrds2_M;
#print "big block = @big_block_crds\n";
 #if($big_block_crds[0]==1247065){print "Big block coords = @big_block_crds\n"; }
@subovp_block_coords = find_subRovp_blocks($rcrds1_M2, $rcrds2_M2, $bchr_sbovp,$hchr_sbovp);
#print "sub:@subovp_block_coords\n";
@subovp_block_coords = Remove_singletonSubblocks2(@subovp_block_coords);
#print "sub:@subovp_block_coords\n";
if($block_size==0)
{ 
  @subovp_block_coords = remove2mrkerSingls2(@subovp_block_coords);
}
else
{ @subovp_block_coords = removeSensBlock(@subovp_block_coords); }
#print "sub:@subovp_block_coords\n";
$num_blks = @subovp_block_coords; 
if($num_blks>=1){return(1);}else{return(0);}
} #sub

# --- sub removeSensBlock (original lines 4878-4891) ---
sub removeSensBlock {
my(@sbovp_bl_crds)=@_; my @sbovp_bl_crds2=();

foreach $tmpovp(@sbovp_bl_crds){
my @coords_rmsg= @$tmpovp; @coords_rmsg= sort{$a <=> $b}(@coords_rmsg); 

$num_rmsg = @coords_rmsg;
#print "bl:$block_size @coords_rmsg\n";
if( ($num_rmsg>=1)&&(abs($coords_rmsg[0]-$coords_rmsg[-1])<=$block_size) ) 
{ } #outer if
else {push(@sbovp_bl_crds2,$tmpovp);} # adds info of the blocks only which are NOT sensitive blocks
} # foreach
return(@sbovp_bl_crds2);
} #sub

# --- sub removeSensBlock2 (original lines 4893-4914) ---
sub removeSensBlock2 {

my(@subBls_sb)=@_; 
my $len_sb = @subBls_sb;
for($c_sb=2;$c_sb<$len_sb;$c_sb += 4)
{ 
 my @coords_2mrk = get_coords($subBls_sb[2]); # gets coords of a sub block

 #print "@subBls_sb coords of sub:@coords_2mrk\n";
 my $num_2mrk = @coords_2mrk; #gets num of markers
 @coords_2mrk = sort{$a <=> $b}(@coords_2mrk);
 
  if(abs($coords_2mrk[0]-$coords_2mrk[-1])<$block_size) # check if the dist b/n is <1Mbp
  {
   # delete that info from the @subBls_sb
   splice(@subBls_sb,($c_sb - 2),4); # removes 4 elements starting at index $c_sb-3
  } # if
 
} #for
return(@subBls_sb);

} #sub

# --- sub Remove_singletonSubblocks2 (original lines 4917-4926) ---
sub Remove_singletonSubblocks2 {

my(@sbovp_bl_crds)=@_; my @sbovp_bl_crds2=();
# adds info of the blocks with more than 1 marker only
foreach $tmpovp(@sbovp_bl_crds){
@coords_rmsg= @$tmpovp; $num_rmsg = @coords_rmsg;
if($num_rmsg!=1){push(@sbovp_bl_crds2,$tmpovp);}
} # foreach
return(@sbovp_bl_crds2);
} #sub

# --- sub remove2mrkerSingls2 (original lines 4928-4938) ---
sub remove2mrkerSingls2 {
my(@sbovp_bl_crds)=@_; my @sbovp_bl_crds2=();

foreach $tmpovp(@sbovp_bl_crds){
@coords_rmsg= @$tmpovp; $num_rmsg = @coords_rmsg;
if( ($num_rmsg==2)&&(abs($coords_rmsg[0]-$coords_rmsg[1])<1000000) ) # if it is a 2 marker block # check if the dist b/n is <1Mbp
{ } #outer if
else {push(@sbovp_bl_crds2,$tmpovp);} # adds info of the blocks only which are NOT 2 marker singletons
} # foreach
return(@sbovp_bl_crds2);
} #sub

# --- sub find_subRovp_blocks (original lines 4940-4988) ---
sub find_subRovp_blocks {


my(@big_block_crds)=@_; my %tmpHashovp = (); my @sub_crds_sbovp=(); my @crds1_R =(); my @crds2_R =();   my $rcrds1_R=(); my $rcrds2_R=();

 #if($big_block_crds[0]==78040290){print "Big block coords = @big_block_crds\n"; }
$hchr_sbovp = pop(@big_block_crds); $bchr_sbovp = pop(@big_block_crds); $rcrds2_R = pop(@big_block_crds); $rcrds1_R = pop(@big_block_crds);
@crds1_R = @$rcrds1_R;  @crds2_R = @$rcrds2_R;

@crds1_R = sort{$a<=>$b}(@crds1_R); @crds2_R = sort{$a<=>$b}(@crds2_R);

# put arrays @crds1_R, @crds2_R into hash map
foreach $tmpovp(@crds1_R){ $tmpHashovp{$tmpovp}=1; } 
foreach $tmpovp(@crds2_R){ $tmpHashovp{$tmpovp}=1; } 

$numeles_sbovp = @ref; $x_sbovp=0; 
while($x_sbovp < $numeles_sbovp)
{ 
 # retrieve coords and chrms of one block
 $rcoords1_sbovp = $ref[$x_sbovp]->[0]; $rchrms1_sbovp = $ref[$x_sbovp]->[1];
 @coords1_sbovp =@$rcoords1_sbovp; @chrs1_sbovp = @$rchrms1_sbovp; 
 @crds_ov_srt = sort{$a<=>$b}(@coords1_sbovp); $num_crds_ovp = @coords1_sbovp;
 if($chrs1_sbovp[1] eq $hchr_sbovp) # if hchr of main and sub blocks are same
 { 
  if( ($tmpHashovp{$coords1_sbovp[0]}!=1) || ($tmpHashovp{$coords1_sbovp[-1]}!=1) ) #if the current sub block is not the big block
  { 
    
    # checks whether first two coords and last two coords of sub block is within the big block
    if($num_crds_ovp>=2)
    {
	   if($crds1_R[0]<$crds2_R[0]) ### means crds1_R comes before crds2_R
	   {    # detects both sub and ovp blocks
		if(($crds_ov_srt[0]>$crds1_R[-1] and $crds_ov_srt[0]<$crds2_R[0]) or ($crds_ov_srt[-1]>$crds1_R[-1] and $crds_ov_srt[-1]<$crds2_R[0]) or ($crds_ov_srt[0]<$crds1_R[-1] and $crds_ov_srt[-1]>$crds2_R[0]) ) {  push(@sub_crds_sbovp,$rcoords1_sbovp);}
	   }
	elsif($crds2_R[0]<$crds1_R[0]) ### means crds2_R comes before crds1_R
	   {
		if(($crds_ov_srt[0]>$crds2_R[-1] and $crds_ov_srt[0]<$crds1_R[0]) or ($crds_ov_srt[-1]>$crds2_R[-1] and $crds_ov_srt[-1]<$crds1_R[0]) or ($crds_ov_srt[0]<$crds2_R[-1] and $crds_ov_srt[-1]>$crds1_R[0]) ) { push(@sub_crds_sbovp,$rcoords1_sbovp);}
	   }        
      
    }
    
  } #if
 } # if

 $x_sbovp +=1; 
} #while
 return(@sub_crds_sbovp);

} #sub 

# --- sub find_subRovp_blocks_old (original lines 4992-5054) ---
sub find_subRovp_blocks_old {


my(@big_block_crds)=@_; my %tmpHashovp = (); my @sub_crds_sbovp=();

 #if($big_block_crds[0]==78040290){print "Big block coords = @big_block_crds\n"; }
$hchr_sbovp = pop(@big_block_crds); $bchr_sbovp = pop(@big_block_crds);
@bg_bl_srt = sort{$a<=>$b}(@big_block_crds);

# put array @big_block_crds into hash map
foreach $tmpovp(@big_block_crds){ $tmpHashovp{$tmpovp}=1; } 

$numeles_sbovp = @ref; $x_sbovp=0; 
while($x_sbovp < $numeles_sbovp)
{ 
 # retrieve coords and chrms of one block
 $rcoords1_sbovp = $ref[$x_sbovp]->[0]; $rchrms1_sbovp = $ref[$x_sbovp]->[1];
 @coords1_sbovp =@$rcoords1_sbovp; @chrs1_sbovp = @$rchrms1_sbovp; 
 @crds_ov_srt = sort{$a<=>$b}(@coords1_sbovp); $num_crds_ovp = @coords1_sbovp;
 if($chrs1_sbovp[1] eq $hchr_sbovp) # if hchr of main and sub blocks are same
 { 
  if( ($tmpHashovp{$coords1_sbovp[0]}!=1) || ($tmpHashovp{$coords1_sbovp[-1]}!=1) ) #if the current sub block is not the big block
  { 
    if( ( (($crds_ov_srt[0]>$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && # to detect sub block
           ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]<$bg_bl_srt[-1])) ||
          (($crds_ov_srt[0]<$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && # to detect overlap block
           ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]<$bg_bl_srt[-1])) ||
          (($crds_ov_srt[0]>$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && # to detect overlap block
           ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]>$bg_bl_srt[-1])) 
        ) && 
        ($num_crds_ovp==1)
      )
    {
     
     push(@sub_crds_sbovp,$rcoords1_sbovp);
    }
    # checks whether first two coords and last two coords of sub block is within the big block
    elsif($num_crds_ovp>=2)
    {
        
      if( ( ($crds_ov_srt[0]>$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]<$bg_bl_srt[-1]) && # to detect sub block
            ($crds_ov_srt[1]>$bg_bl_srt[0])&&($crds_ov_srt[1]<$bg_bl_srt[-1]) && ($crds_ov_srt[-2]>$bg_bl_srt[0])&&($crds_ov_srt[-2]<$bg_bl_srt[-1]) 
               ) ||
          ( ($crds_ov_srt[0]<$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]<$bg_bl_srt[-1]) && # to detect overlap block
            ($crds_ov_srt[1]<$bg_bl_srt[0])&&($crds_ov_srt[1]<$bg_bl_srt[-1]) && ($crds_ov_srt[-2]>$bg_bl_srt[0])&&($crds_ov_srt[-2]<$bg_bl_srt[-1])
               ) ||
          ( ($crds_ov_srt[0]>$bg_bl_srt[0])&&($crds_ov_srt[0]<$bg_bl_srt[-1]) && ($crds_ov_srt[-1]>$bg_bl_srt[0])&&($crds_ov_srt[-1]>$bg_bl_srt[-1]) && # to detect overlap block
            ($crds_ov_srt[1]>$bg_bl_srt[0])&&($crds_ov_srt[1]<$bg_bl_srt[-1]) && ($crds_ov_srt[-2]>$bg_bl_srt[0])&&($crds_ov_srt[-2]>$bg_bl_srt[-1])
               )                       
        )
      {
             push(@sub_crds_sbovp,$rcoords1_sbovp);
      }
    }
    
  } #if
 } # if

 $x_sbovp +=1; 
} #while
return(@sub_crds_sbovp);

} #sub 

# --- sub remove_empty_cells (original lines 5157-5169) ---
sub remove_empty_cells
{
	my(@array) =@_;
	my @array2;
	foreach my $el (@array)
	{
		if($el=~/\s/)
		{}
		else
		{push(@array2, $el);}
	}
	return(@array2);
}

# --- sub get_sp_coords (original lines 5225-5243) ---
sub get_sp_coords
{
 my(@h_coords)=@_;
 my($sp_chr)= pop(@h_coords);
 my($h_chr) = pop(@h_coords);
 
 my(@sp_coords) =();

 foreach my $crd (@h_coords)
 {
 # my $rq_id = $h_chr._.$crd;
  my $rq_line = $lines_hash{$crd};
  my @temp = split(/\s+/,$rq_line);
  my $mstart =$temp[7]; my $mend=$temp[8];
  push (@sp_coords,$mstart,$mend);
 } #foreach
 return(@sp_coords);
 
} #sub

# --- sub get_h_coords (original lines 5245-5263) ---
sub get_h_coords
{
 my(@h_coords)=@_;
 my($sp_chr)= pop(@h_coords);
 my($h_chr) = pop(@h_coords);
 
 my(@sp_coords) =();

 foreach my $crd (@h_coords)
 {
 # my $rq_id = $h_chr._.$crd;
  my $rq_line = $lines_hash{$crd};
  my @temp = split(/\s+/,$rq_line);
  my $mstart =$temp[1]; my $mend=$temp[2];
  push (@sp_coords,$mstart,$mend);
 } #foreach
 return(@sp_coords);
 
} #sub

# --- sub get_h_coords_ends (original lines 5266-5284) ---
sub get_h_coords_ends
{
 my(@h_coords)=@_;
 my($sp_chr)= pop(@h_coords);
 my($h_chr) = pop(@h_coords);
 
 my(@h_coords_eds) =();

 foreach my $crd (@h_coords)
 {
#  my $rq_id = $h_chr._.$crd;
  my $rq_line = $lines_hash{$crd};
  my @temp = split(/\s+/,$rq_line);
  my $hend =$temp[2]; 
  push (@h_coords_eds,$hend);
 } #foreach
 return(@h_coords_eds);
 
} #sub

# --- sub filter_subBlsS (original lines 5287-5300) ---
sub filter_subBlsS {
my (@subblcrds) = @_; my %tmpHash=(); my @subcrds_flt=();
# put array tmpBigbl into hash map
foreach $tmpel(@tmpBigbl){ $tmpHash{$tmpel}=1; } 

$numsubblcrds=@subblcrds; $xsub=0;
while($xsub < $numsubblcrds)
{
 if( $tmpHash{$subblcrds[$xsub]}!=1 ) # if sub block coords does n't belongs to the original big block
 {push(@subcrds_flt,$subblcrds[$xsub],$subblcrds[$xsub+1],$subblcrds[$xsub+2],$subblcrds[$xsub+3]); }
 $xsub +=4;
} #while
return(@subcrds_flt);
} #sub

# --- sub assign_nums (original lines 5302-5359) ---
sub assign_nums{

#assign numbers to @info with information in @ref
#print "in the assign nums\n";  #print "Bigblfinal= @Bigblfinal\n"; #print "num=$numConsSingls\n";
$numeles = @ref; $w=0; $y=0; %coords_hash=();
while($w < $numeles)
{ 
 #Take coords of a segment/block
 $rcoords = $ref[$w]->[0]; $rchrms = $ref[$w]->[1];
 @coords =@$rcoords;  @chrs = @$rchrms; #print "@chrs\n";
 $y++;  #print "($y)coords=@coords\n";

 #put the above coords in a hashmap
 foreach $el(@coords){
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
  if((($coords_hash{$cstart}==1)||($cstart=~/\s+/))&&($cb_chr eq $chrs[0])&&($ch_chr eq $chrs[1]))
  {
   $info[$i_num] = $y; #print "here\t";
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
 if($cstart =~ /\s+/)
 {
  $info[$i_num] = $pnum; $cnum=$pnum;#print "here\t";
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;

} #while


} # sub

# --- sub break_bigblock (original lines 5363-5395) ---
sub break_bigblock{

my($bl_num,$cst,$ced,$pst,$ped) = @_;

#print "inside breakbl\n";
$len4 = @new_info;
$m_st_m=3; $n_ed_m=4; $i_num_m=5; $j_fl_m=6; $i_newnm_m = 7; $seg = 10000;
  $pmst = " "; $pmed = " ";
  $index = $bl_num; #print "l = $l j_fl_m = $j_fl_m\n";
  while($j_fl_m < $len4)
  {   #print "inside while\n";
   $cmst = $new_info[$m_st_m]; $cmed = $new_info[$n_ed_m]; $cnm = $new_info[$i_num_m];
   
   if($bl_num == $cnm)
   {
    if( (!($pmst =~/\s+/))&&(!($pmed =~/\s+/))&&(!($cmst =~/\s+/))&&(!($cmed =~/\s+/)) )
    { #print "inside\n";
      if(($cst == $cmst)&&($ced==$cmed)&&($pst==$pmst)&&($ped==$pmed))
      { #print "number changed at :$cmst \n";  
        $seg++;$new_info[$i_newnm_m]=$seg; #print "$new_info[$i_newnm_m]\n";
      }
    }
   }
    if($bl_num == $cnm){
    if( (!($cmst =~/\s+/))&&(!($cmed =~/\s+/)) )
    {
     $pmst = $cmst; $pmed = $cmed; $pnm = $cnm;
    }
    
    }
   $m_st_m += 8; $n_ed_m += 8; $i_num_m += 8; $j_fl_m += 8; $i_newnm_m += 8;
  }
} #sub

# --- sub find_sub_blocks (original lines 5398-5419) ---
sub find_sub_blocks {

 my($bl_bchr,$bl_hchr,$bl_st,$bl_ed,$bl_num,$bl_dir) = @_;

 $len2 = @coord_all; @info_sub_blocks = ();
 $q_bchr2=0; $r_hchr2=1; $m_st2=2; $n_ed2=3; $i_num2=4; $j_fl2=5; $i_newnm2=6;
 while($i_newnm2 < $len2)
 {
  $sub_bchr = $coord_all[$q_bchr2]; $sub_hchr = $coord_all[$r_hchr2];
  $sub_st = $coord_all[$m_st2]; $sub_ed = $coord_all[$n_ed2]; 
  $sub_num = $coord_all[$i_num2]; $sub_dir = $coord_all[$j_fl2];
 
  if( ( min_num($sub_st,$sub_ed) > min_num($bl_st,$bl_ed))&&( max_num($sub_st,$sub_ed)<max_num($bl_st,$bl_ed))&&($bl_hchr eq $sub_hchr) )
  { 
       push(@info_sub_blocks,$sub_st,$sub_ed,$sub_num,$sub_dir); #} # adds info of the blocks only which are NOT sensitive blocks 
      
  }   
  $q_bchr2 +=7; $r_hchr2 +=7; $m_st2 +=7; $n_ed2 +=7; $i_num2 +=7; $j_fl2 +=7; $i_newnm2 +=7;
 }

 return (@info_sub_blocks);
}

# --- sub make_coord_all (original lines 5421-5458) ---
sub make_coord_all
{

$len9 = @info;
$p_mname9=0; $q_bchr9=1; $r_hchr9=2; $m_st9=3; $n_ed9=4; $i_num9=5; $j_fl9=6; $i_newnm9 = 7;
$f_row_done9 = 0; #first row 
$newnum9 = 1000;
@coord_all = (); # make new list 
@coords9 =();

while($i_newnm9 < $len9)
{
 $cmarker_name9 = $info[$p_mname9]; $cb_chr9 = $info[$q_bchr9]; $ch_chr9 = $info[$r_hchr9];
 $cstart9 = $info[$m_st9];$cstart9 =~ s/\s+//g; $cend9 = $info[$n_ed9]; $cend9 =~ s/\s+//g;$cnum9 = $info[$i_num9];
 $cflow9 = $info[$j_fl9];
 
 if(($cnum9 != $pnum9)&&($f_row_done9 ==1)) # num changed
 {  #print "@coords9\n";
  @out9 = find_coords(@coords9); 
  push(@coord_all,$pb_chr9,$ph_chr9,$out9[0],$out9[1],$pnum9,$out9[2],$newnum9);
  @coords9 = ();
 }
 push(@coords9, $cstart9) if((!($cstart9 =~ /\s+/))&&($cstart9 ne ""));
 $f_row_done9 = 1; 

 $pmarker_name9 = $cmarker_name9; $pb_chr9 = $cb_chr9; $ph_chr9 = $ch_chr9;
 $pstart9 = $cstart9; $pend9 = $cend9; $pnum9 = $cnum9; $pflow9 = $cflow9;
 
 $p_mname9 += 8;$q_bchr9 += 8;$r_hchr9 += 8; $m_st9 += 8; $n_ed9 += 8; $i_num9 += 8; $j_fl9 += 8; $i_newnm9 +=8;

} #while
# for the last block
#print "@coords9\n";
@out9 = find_coords(@coords9); #print"pnum = $pnum cnum = $cnum\n";print "$out[0] $out[1] $out[2]\n";  
push(@coord_all,$pb_chr9,$ph_chr9,$out9[0],$out9[1],$pnum9,$out9[2],$newnum9);


} #sub

# --- sub find_sub_blocks2 (original lines 5460-5488) ---
sub find_sub_blocks2 { # this method also looks for overlapped segments

 my($bl_bchr7,$bl_hchr7,$bl_st7,$bl_ed7) = @_;
 #if(($bl_st7==26307727)&&($bl_ed7==27941086)){ print "$bl_bchr7,$bl_hchr7,$bl_st7,$bl_ed7\n";}
 make_coord_all();

 $len7 = @coord_all; @info_sub_blocks7 = ();
 $q_bchr7=0; $r_hchr7=1; $m_st7=2; $n_ed7=3; $i_num7=4; $j_fl7=5; $i_newnm7=6;
 while($i_newnm7 < $len7)
 {
  $sub_bchr7 = $coord_all[$q_bchr7]; $sub_hchr7 = $coord_all[$r_hchr7];
  $sub_st7 = $coord_all[$m_st7]; $sub_ed7 = $coord_all[$n_ed7]; 
  my $tmp_=0;
  if($sub_st7>$sub_ed7){$tmp_=$sub_st7;$sub_st7=$sub_ed7; $sub_ed7=$tmp_;} # swapping done to get min number in sub_st7
  $sub_num7 = $coord_all[$i_num7]; $sub_dir7 = $coord_all[$j_fl7];

  # checks whether either of the sub block coords falls b/n start and end of big block
  if( ( ( $sub_st7 > min_num($bl_st7,$bl_ed7))&&( $sub_st7<max_num($bl_st7,$bl_ed7))&&($bl_hchr7 eq $sub_hchr7) ) ||
( ( $sub_ed7 > min_num($bl_st7,$bl_ed7))&&( $sub_ed7 <max_num($bl_st7,$bl_ed7))&&($bl_hchr7 eq $sub_hchr7) ) )
  {
   push(@info_sub_blocks7,$sub_st7,$sub_ed7,$sub_num7,$sub_dir7); #} # adds info of the blocks only which are NOT sensitive blocks 
   
  }   
  
  $q_bchr7 +=7; $r_hchr7 +=7; $m_st7 +=7; $n_ed7 +=7; $i_num7 +=7; $j_fl7 +=7; $i_newnm7 +=7;
 }

 return (@info_sub_blocks7);
}

# --- sub find_coords (original lines 5491-5542) ---
sub find_coords{
my(@crds) = @_;

@rep_crds = repair_crds(@crds); $num_crds = @rep_crds;
@crds_copy = @rep_crds; $first = $crds_copy[0]; $last = pop(@crds_copy);

my(@sorted_crds) = sort{$a <=> $b}(@rep_crds); #print "s crds = @sorted_crds\n";
$mn = $sorted_crds[0]; $mn2 = $sorted_crds[1];
$mx = pop(@sorted_crds); $mx2 = pop(@sorted_crds);
# find how many ups and downs are there using Denis's procedure
 $ups1 = 0; $downs1 =0; $i_d=0; $j_d = $num_crds-$i_d; # $i_d iterates from top while $j_d from the bottom
 while($i_d<$j_d) 
 {
  #if ($rep_crds[0]==33100937){ print"i=$i_d j=$j_d          @rep_crds\n"; }
  if($rep_crds[$i_d]<$rep_crds[$j_d]) { $ups1++;}
  elsif($rep_crds[$i_d]>$rep_crds[$j_d]) {$downs1++;}  
  $i_d++; $j_d=$num_crds-$i_d; #updation
  #if ($rep_crds[0]==33100937){ print"AFTER: i=$i_d j=$j_d\n"; }
 } #while

$ups = 0; $downs =0; $pele=""; 
foreach $ele(@rep_crds)
{
 if($pele ne "")
 {
  if($pele<$ele) {$ups++;}
  elsif($pele>$ele){$downs++;}
 }
$pele=$ele;
}

if($ups1>$downs1){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
elsif($ups1<$downs1){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}
 elsif(($ups1==$downs1)&&($ups>$downs)){$dir = "Up"; $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;}
 elsif(($ups1==$downs1)&&($ups<$downs)){$dir = "Down"; $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;}
 elsif(($ups1==$downs1)&&($ups==$downs)&&($first<$last))
{ 
 $dir = "Up";
 $st = $mn; $ed = $mx; $st2=$mn2; $ed2=$mx2;  
}
elsif(($ups1==$downs1)&&($ups==$downs)&&($first>$last))
{
 $dir = "Down";
 $st = $mx; $ed = $mn; $st2 = $mx2; $ed2 = $mn2;
}
#if($rep_crds[0]==33100937){print "$ups $downs 1: $ups1 $downs1 $first $last\n";}
if($num_crds==1){$dir="None";$st=$rep_crds[0];$ed=$rep_crds[0];$st2=$rep_crds[0];$ed2=$rep_crds[0];}

@ot = ($st,$ed,$dir,$st2,$ed2);

return (@ot);
}

# --- sub repair_crds (original lines 5545-5556) ---
sub repair_crds{

my(@cds) = @_; $num = 108;
@new_cds = ();
foreach $element(@cds){

$num = $element if(!($element=~/[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/)); # to skip blanks
push(@new_cds, $num);

}
return(@new_cds);
}

# --- sub invMrks (original lines 5558-5574) ---
sub invMrks {
my(@crds) = @_;
my (@sorted_crds) = sort{$a <=> $b}(@crds);
my($cnt) = @crds;
$pelement = 0; $c3 = 1;
foreach $celement(@sorted_crds){

if($pelement != 0){
$c3 = 0 if((($celement - $pelement)>= 1000000) && ($c3!=0));
}

$pelement = $celement;
} #foreach

return(1) if(($cnt<=3)&&($c3==1));
return(0);
} # sub

# --- sub max_num (original lines 5577-5584) ---
sub max_num {
   
    my($one,$two) = @_;
    if ($one > $two)
    {return ($one);}
    else {return ($two);}

}

# --- sub min_num (original lines 5586-5593) ---
sub min_num {

    my($one,$two) = @_;
    if ($one < $two)
    {return ($one);}
    else {return ($two);}

}

# --- sub max (original lines 5597-5614) ---
sub max {

my($first,$second) = @_;
    my($max) = shift(@_);
    

    foreach $temp (@_) { 

        $max = $temp if $temp > $max;

    }
#print "first = $first second = $second max = $max \n";
    if ($max == $first)
    { return("first"); }
    else
    { return("second"); }    

}

# --- sub all_conds_sat (original lines 5616-5681) ---
sub all_conds_sat{

my($sgA,$sgB,$drA,$drB)= @_;
my($condition4)=0;
#get BlockA info
$length = @info;
($cb_chr,$ch_chr,$cstart,$cend,$cnum,$pb_chr,$ph_chr,$pstart,$pend,$pnum) = (0,0,0,0,0,0,0,0,0,0);
$qbchr=1; $rhchr=2; $mst=3; $ned=4; $inum=5; $inewnm = 7; $countA=0;$cond1A =0;$cond3A =1;
#print "$inewnm $length \n";
while($inewnm < $length)
{ #print "in the while \n\n";
 $cb_chr = $info[$qbchr]; $ch_chr = $info[$rhchr];
 $cstart = $info[$mst];$cend = $info[$ned];$cnum = $info[$inum]; 
 if($cnum == $sgA) # only BlockA
 { #print "cnum=$cnum sgA =$sgA\n";
  $countA++; $bchrA = $cb_chr; $hchrA = $ch_chr; #print "bchrA: $bchrA hchrA: $hchrA\n\n";
  if(($countA >=2)&&($tcstart ne "")&&($tpstart ne "")) # to prevent microsattelite markers 
  { 
    $cond3A = 0 if ( (max_num($cstart,$pend) - min_num($cstart,$pend)) >= 1000000 );
  }
     
 } 
 $pb_chr = $cb_chr; $ph_chr = $ch_chr;
 $pstart = $cstart; $pend = $cend; $pnum = $cnum; 
$qbchr += 8; $rhchr+= 8; $mst+= 8; $ned+= 8; $inum+= 8; $inewnm +=8;
} #while
$cond1A = 1 if ($countA==2); #if ($count<=3);
#get BlockB info
$length = @info;
($cb_chr,$ch_chr,$cstart,$cend,$cnum,$pb_chr,$ph_chr,$pstart,$pend,$pnum) = (0,0,0,0,0,0,0,0,0,0);
$qbchr=1; $rhchr=2; $mst=3; $ned=4; $inum=5; $inewnm = 7; $countB=0;$cond1B =0;$cond3B =1;
while($inewnm < $length)
{
 $cb_chr = $info[$qbchr]; $ch_chr = $info[$rhchr];
 $cstart = $info[$mst];$cend = $info[$ned];$cnum = $info[$inum];
 if($cnum == $sgB) # only BlockB
 {#print "cnum=$cnum sgB =$sgB\n";
  $countB++; $bchrB = $cb_chr; $hchrB = $ch_chr;#print "bchrB: $bchrB hchrB: $hchrB\n\n";
  if(($countB >=2)&&($tcstart ne "")&&($tpstart ne "")) # to prevent microsattelite markers 
  { 
    $cond3B = 0 if ( (max_num($cstart,$pend) - min_num($cstart,$pend)) >= 1000000 );
  }
     
 } 
 $pb_chr = $cb_chr; $ph_chr = $ch_chr;
 $pstart = $cstart; $pend = $cend; $pnum = $cnum; 
$qbchr += 8; $rhchr+= 8; $mst+= 8; $ned+= 8; $inum+= 8; $inewnm +=8;
} #while
$cond1B = 1 if ($countB==2); #if ($count<=3);
#$condition4=1;
if( (($drA eq "Down")&&($drB eq "Up"))|| (($drA eq "Up")&&($drB eq "Down")) ){$condition4=1; }
#check the conditions

if(($condition4==1)&&($countB==2)&&($countA>1)) 
{
#print "Upper part\n"; print "countA:$countA countB:$countB drA:$drA drB:$drB cond4:$condition4 cond1A:$cond1A cond1B:$cond1B\n";
return(1);
}
elsif(($condition4==1)&&($countA==2)&&($countB>1)){return(1);}
elsif(($countA==3)&&($cond3A==1)){return(1);} #looks for 2block inversion
elsif(($countB==3)&&($cond3B==1)){return(1);} #looks for 2block inversion
else {return (0);}



}

# --- sub merge_cons_blocks2 (original lines 5682-5770) ---
sub merge_cons_blocks2 {

$numeles = @ref; $w=0; $x=1; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($x < $numeles)
{ 
 $rcoords1 = $ref[$w]->[0]; $rchrms1 = $ref[$w]->[1];
 $rcoords2 = $ref[$x]->[0]; $rchrms2 = $ref[$x]->[1];
 $merged =0;
 
 @coords1 =@$rcoords1; @coords2 = @$rcoords2; 
 @coords1_srt = sort{$a<=>$b}(@coords1);  @coords2_srt = sort{$a<=>$b}(@coords2); # sort

 $num1_Unite = @coords1; $num2_Unite = @coords2;

 @coords1_srt_cpy = @coords1_srt;   @coords2_srt_cpy = @coords2_srt; # make a copy
 @chrs1 = @$rchrms1; @chrs2 = @$rchrms2;  #print "unitepart:@chrs1\n";
 
 @out1 = find_coords2(\@coords1,\@coords2); $numc1=@coords1; $numc2=@coords2;
 $bchrA1 = $chrs1[0]; $bchrB1 = $chrs2[0]; 
 $hchrA1 = $chrs1[1]; $hchrB1 = $chrs2[1];
 $startA1 = $out1[0] ; $startB1 = $out1[0+5]; 
 $endA1 = $out1[1]; $endB1 =$out1[1+5];
 $startA21 = $out1[3] ; $startB21 = $out1[3+5]; 
 $endA21 = $out1[4]; $endB21 =$out1[4+5]; 
 $segA1 = $w+1 ; $segB1 = $x+1; 
 $dirA1 = $out1[2] ;$dirB1 = $out1[2+5]; 

 $dist_Unite = $coords2[0]-$coords1[0];

 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1,\@coords2,$bchrA1,$hchrA1);

 # Merge only if chr sequence is same and there are no sub blocks in between  
 if(($bchrA1 eq $bchrB1)&&($hchrA1 eq $hchrB1)&&(!(isSg2(@coords1)))&&(!(isSg2(@coords2)))&&( (!($subovpFound12)) ) )  
{
 #print "inside \n";
   if(($dirA1 eq "Down")&&($dirB1 eq "Down")&&(($endA1 > $startB1)||($endA21 > $startB21)))
   { 
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords       print "\n@coordsU\n";
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; # make new small reference
    
    my $rsrefU= \@srefU; # make new reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update     
    #$tempnumele = @ref; print "After:$tempnumele\n";    
    $merged=1; # to indicate that the blocks were merged
   }
   elsif(($dirA1 eq "Up")&&($dirB1 eq "Up")&&(($endA1 < $startB1)||($endA21 < $startB21)))
   {  
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords
    #print "merged coords: @coordsU\n";
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; # make new small reference
    #$tempRefchrs = $srefU[1];  print "$w.chrs= @$tempRefchrs @coordsU\n\n";
    my $rsrefU= \@srefU; # make new reference    #$ref[$x]->[0]=\@coordsU; #assign new coords to the existing reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update  
    $merged=1; 
   }
   elsif(($dirA1 =~/None/)&&($dirB1 =~ /None/ ))
   {
    @temp =();push(@temp,@coords1,@coords2);  my @coordsU=@temp; my @chrsU = @chrs1; #combine coords
    my @srefU = (); $srefU[0]=\@coordsU; $srefU[1]=\@chrsU; # make new small reference
    my $rsrefU= \@srefU; # make new reference    #$ref[$x]->[0]=\@coordsU; #assign new coords to the existing reference
    splice(@ref,$x,1,$rsrefU); # Replace contents at position x
    splice(@ref,$w,1); # Delete contents at position w
    $numeles--; $w--; $x--; # replace and update  
    $merged=1;
   }
   
 } #1st if

 $condition_block_size3 =0;
 if($block_size==0) 
 {$condition_block_size3 =1; } #This makes the script merge ONLY blocks seperated by SINGLETONS     
 
 if( (!(isSg(@coords1))) && (isSg(@coords2)) && (isSg_spl(@coords2) &&($condition_block_size3==1))
   )
   { $x +=1;
   } #if
 else{ 
       # bring the other iterator just above $x
       $w= $x-1;
       $w+=1; $x+=1;
     }
} #while

} #sub merge_cons_blocks

# --- sub isSg_spl (original lines 5775-5790) ---
sub isSg_spl
{
 my($rcoords3) = $ref[$x+1]->[0];
 my(@coords3) = @$rcoords3;
 my($len1_sgspl)=abs($coords1[0]-$coords1[-1]); my($len3_sgspl)=abs($coords3[0]-$coords3[-1]);
 my($len2_sgspl)=abs($coords2[0]-$coords2[-1]);
 if($coords2[0]==7350362){print "$len1_sgspl $len3_sgspl\n";}
 if(($num2_Unite ==2) &&($len2_sgspl<=1000000) ) #means this is a 2 marker singleton
 {
  if( (($len1_sgspl<=2000000)||($len3_sgspl<=2000000)) && ($merged==0) ) { #if($coords2[0]==7350362){print "here in 1\n";} 
  return(1);}
  else{  #if($coords2[0]==7350362){print "here in 0\n";}
  return(0);}
 }#if
 else {return(1);}  
} #sub

# --- sub merge_blocks_sep_by_singl2 (original lines 5792-5937) ---
sub merge_blocks_sep_by_singl2{

$numelesAl = @ref; $wAl=0; $xAl=1; $yAl=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($xAl < $numelesAl)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Al = $ref[$wAl]->[0]; $rchrms1Al = $ref[$wAl]->[1];
 $rcoords2Al = $ref[$xAl]->[0]; $rchrms2Al = $ref[$xAl]->[1];
 $rcoords3Al = $ref[$yAl]->[0]; $rchrms3Al = $ref[$yAl]->[1];

 @coords1Al =@$rcoords1Al; @coords2Al = @$rcoords2Al; @coords3Al = @$rcoords3Al;
 @chrs1Al = @$rchrms1Al; @chrs2Al = @$rchrms2Al;  @chrs3Al = @$rchrms3Al;


 # get the orientations of the 3 blocks
 $orA = getOrien(@coords1Al); $orB = getOrien(@coords2Al); $orC = getOrien(@coords3Al);

@coords1Al_srt = sort{$a <=> $b}(@coords1Al); @coords2Al_srt = sort{$a <=> $b}(@coords2Al); @coords3Al_srt = sort{$a <=> $b}(@coords3Al);

 $len_bl1 = abs($coords1Al_srt[0]- $coords1Al_srt[-1]);
 $len_bl2 = abs($coords2Al_srt[0]- $coords2Al_srt[-1]);
 $len_bl3 = abs($coords3Al_srt[0]- $coords3Al_srt[-1]);

 
 #get start and end of blocks 1 and 3
 $startAAl = $coords1Al_srt[0]; $endAAl = $coords1Al_srt[-1];
 $startBAl = $coords2Al[0];     $endBAl = $coords2Al[-1];
 $startCAl = $coords3Al_srt[0]; $endCAl = $coords3Al_srt[-1];

 $numMrkrsB = @coords2Al; # num of markers in the middle block

  $tmp_res_isg = subovp_blocksM_found(\@coords1Al,\@coords3Al,$chrs1Al[0],$chrs1Al[1]);
  $tmp1_isg = isSg(@coords1Al) ; $tmp2_isg =isSg(@coords2Al); $tmp3_isg = isSg(@coords3Al);
  $tmp4_isg = subovp_blocksM_found(\@coords1Al,\@coords3Al,$chrs1Al[0],$chrs1Al[1]);
  $tmp5_isg = isSg2_spl(@coords2Al);
  #block1 is Not a sensblock, block2 is a sensblock and block3 is Not a sensblock
  $condition_block_size =0;
  if($block_size==0) 
  {$condition_block_size=0; } #This makes the script merge ONLY blocks seperated by SINGLETONS
  # so, if the user wants to merge only blocks seperated by singletons, assign $block_size=0
  elsif( ($len_bl1!=0) && ($len_bl2<=$block_size) && ($len_bl3!=0) )
  {$condition_block_size=1; }
  else {$condition_block_size=2; }
  

 # And if block2 is a 2mrker singleton, then either block1 or block2 is <=2mbp in length
 if(  (  ( (!(isSg(@coords1Al))) && (isSg(@coords2Al)) && (!(isSg(@coords3Al))) && (isSg2_spl(@coords2Al)) ) 
    ||   ( ($condition_block_size==1) ) 
      ) &&
     ($condition_block_size !=2)   &&
     ($chrs1Al[0] eq $chrs3Al[0])&&($chrs1Al[1] eq $chrs3Al[1]) && 
     #(special_condition_2mrkSingleton(\@coords1Al,\@coords2Al,\@coords3Al)) &&
     (!(subovp_blocksM_found(\@coords1Al,\@coords3Al,$chrs1Al[0],$chrs1Al[1])))     
   )
 { #print "inside merge singles\n";
  if(   ($orA eq "Nor")&&($orC eq "Nor") 
    && (abs($coords3Al[0]-$coords1Al[-1])<abs($coords3Al[0]-$coords1Al[0])) #means nearest end of block1 is closest
    && ($chrs1Al[0] eq $chrs3Al[0])&&($chrs1Al[1] eq $chrs3Al[1]) )
  { if ($coords2Al[0]==31285662){print "inside Nor\n";}
   @temp =();push(@temp,@coords1Al,@coords3Al);  my @coordsUAl=@temp; my @chrsUAl = @chrs1Al; #combine coords
   my @srefUAl = (); $srefUAl[0]=\@coordsUAl; $srefUAl[1]=\@chrsUAl; # make new small reference for the merged coords
   my $rsrefUAl= \@srefUAl; # make new reference    
   splice(@ref,$yAl,1,$rsrefUAl); # Replace contents at position yA1
   splice(@ref,$wAl,1); # Delete contents at position wAl
   $numelesAl--; $wAl--; $xAl--; $yAl--; # replace and update 
   
  }
  elsif(  ( (($orA eq "Nor")&&($orC eq "Up"))||(($orA eq "Up")&&($orC eq "Nor"))||(($orA eq "Up")&&($orC eq "Up")) )
    && (abs($coords3Al[0]-$coords1Al[-1])<abs($coords3Al[0]-$coords1Al[0])) #means nearest end of block1 is closest
    && ($endAAl<$startCAl) 
    && ($chrs1Al[0] eq $chrs3Al[0])&&($chrs1Al[1] eq $chrs3Al[1]) )
  { #if ($coords2Al[0]==31285662){print "inside Up\n";}
   @temp =();push(@temp,@coords1Al,@coords3Al);  my @coordsUAl=@temp; my @chrsUAl = @chrs1Al; #combine coords
   my @srefUAl = (); $srefUAl[0]=\@coordsUAl; $srefUAl[1]=\@chrsUAl; # make new small reference for the merged coords
   my $rsrefUAl= \@srefUAl; # make new reference    
   splice(@ref,$yAl,1,$rsrefUAl);
   splice(@ref,$wAl,1); # Delete contents at position yAl
   $numelesAl--; $wAl--; $xAl--; $yAl--; # replace and update 
  }
  elsif(  ( (($orA eq "Nor")&&($orC eq "Down"))||
            (($orA eq "Down")&&($orC eq "Nor"))||
            (($orA eq "Down")&&($orC eq "Down")) 
          )
    && (abs($coords3Al[0]-$coords1Al[-1])<abs($coords3Al[0]-$coords1Al[0])) #means nearest end of block1 is closest
    && ($endAAl>$startCAl) 
    && ($chrs1Al[0] eq $chrs3Al[0])&&($chrs1Al[1] eq $chrs3Al[1]) )
  { #if ($coords2Al[0]==73745068){ 
    #print "inside down\n";#}
   @temp =();push(@temp,@coords1Al,@coords3Al);  my @coordsUAl=@temp; my @chrsUAl = @chrs1Al; #combine coords
   #if ($coords2Al[0]==31285662){print "@coordsUAl\n";}
   my @srefUAl = (); $srefUAl[0]=\@coordsUAl; $srefUAl[1]=\@chrsUAl; # make new small reference for the merged coords
   my $rsrefUAl= \@srefUAl; # make new reference    
   #if ($coords2Al[0]==31285662){$tp_num=@ref; print "Before: Num of blocks=$tp_num\n";}
   splice(@ref,$yAl,1,$rsrefUAl); 
   splice(@ref,$wAl,1); # Delete contents at position yAl
   $numelesAl--; $wAl--; $xAl--; $yAl--; # replace and update 

  }

 } #if


# get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Al = $ref[$wAl]->[0]; $rchrms1Al = $ref[$wAl]->[1];
 $rcoords2Al = $ref[$xAl]->[0]; $rchrms2Al = $ref[$xAl]->[1];
 $rcoords3Al = $ref[$yAl]->[0]; $rchrms3Al = $ref[$yAl]->[1];

 @coords1Al =@$rcoords1Al; @coords2Al = @$rcoords2Al; @coords3Al = @$rcoords3Al;
 @chrs1Al = @$rchrms1Al; @chrs2Al = @$rchrms2Al;  @chrs3Al = @$rchrms3Al; 

 @coords1Al_srt = sort{$a <=> $b}(@coords1Al); @coords2Al_srt = sort{$a <=> $b}(@coords2Al); @coords3Al_srt = sort{$a <=> $b}(@coords3Al);

 $len_bl1 = abs($coords1Al_srt[0]- $coords1Al_srt[-1]);
 $len_bl2 = abs($coords2Al_srt[0]- $coords2Al_srt[-1]);
 $len_bl3 = abs($coords3Al_srt[0]- $coords3Al_srt[-1]);


 #if block1 is Not a sensblock, block2 is a sensblock and block3 is a sensblock
 # move ahead until you find a block which is not a sensBlock 
 $condition_block_size2 =0;
 if($block_size==0) 
 {$condition_block_size2=0; } #This makes the script merge ONLY blocks seperated by SINGLETONS
 # so, if the user wants to merge only blocks seperated by singletons, assign $block_size=0
 elsif( ($len_bl1>$block_size)&& ($len_bl2<=$block_size) && ($len_bl3<=$block_size) )
 {$condition_block_size2=1; }
 else{$condition_block_size2=2; }
  
 # if the 1st block is Not a singleton and if both 2nd and 3rd blocks are singletons, 
 # move ahead until you find a block which is not singleton 
 if( (    ( (!(isSg(@coords1Al))) && (isSg(@coords2Al)) && (isSg(@coords3Al)) )#&& (isSg2_spl(@coords2Al))
       || ($condition_block_size2==1)
     )
     && ($condition_block_size2 !=2) 
     &&
     ($wAl<$numelesAl and $xAl<$numelesAl and $yAl<$numelesAl)
   ) 
   { $yAl +=1;
   } #if
 else{ 
       $wAl= $yAl-2; $xAl= $yAl-1; # bring the other two iterators just above $yAl
       $wAl +=1; $xAl +=1; $yAl +=1;
     }

} #while
#print "finished merge singles\n";
} #sub

# --- sub isSg2_spl (original lines 5938-5948) ---
sub isSg2_spl
{
 $num2_sg2spl = @coords2Al;
 my($len1_sg2spl)=abs($coords1Al[0]-$coords1Al[-1]); my($len3_sg2spl)=abs($coords3Al[0]-$coords3Al[-1]); 
 if($num2_sg2spl==2)
 {
  if(($len1_sg2spl<=2000000)||($len3_sg2spl<=2000000)){return(1);}
  else{return(0);}
 }#if
 else {return(1);}  
} #sub

# --- sub special_condition_2mrkSingleton (original lines 5953-5968) ---
sub special_condition_2mrkSingleton
{   
 my($ref1,$ref2,$ref3)=@_;
 my(@crd1_spl)=@$ref1;  my(@crd2_spl)=@$ref2;  my(@crd3_spl)=@$ref3;
 my($len1_spl)=abs($crd1_spl[0]-$crd1_spl[-1]); my($len3_spl)=abs($crd3_spl[0]-$crd3_spl[-1]);
 #my($or1_spl)=getOrien(@crd1_spl);  my($or3_spl)=getOrien(@crd3_spl);
 #print "coords1=@crd1_spl\ncoords2=@crd2_spl\ncoords3=@crd3_spl\n\n";
 my($num2_spl)=@crd2_spl;   #if($crd2_spl[0]==7350362){print "$num2_spl $len1_spl $len3_spl\n";}
 if($num2_spl==2)
 {  #if($crd2_spl[0]==7350362){print "$len1_spl $len3_spl\n";}
  if(($len1_spl<=2000000)||($len3_spl<=2000000)){return(1);}
  else{return(0);}
 }
 else {return(1);} # because we are trying to check only 2mrker singletons
 
} # sub

# --- sub isSg (original lines 5970-5979) ---
sub isSg{
my(@crd_isg)=@_;
my $num_isg = @crd_isg;

if ($num_isg==1){return(1);} # checks for 1 marker singleton
# checks 2 marker singleton
elsif($num_isg==2){if((distbn($crd_isg[0],$crd_isg[1]))<$block_size) {return(2);}else{return(0);} }
else{return(0);}

} # sub

# --- sub merge_nors_sep_small_blocks2 (original lines 5982-6140) ---
sub merge_nors_sep_small_blocks2 {

$numelesNr = @ref; $wNr=0; $xNr=1; $yNr=2; #$tempnumele = @ref; print "Before:$tempnumele\n";    
while($xNr < $numelesNr)
{ 
 # get coords and chrs of 3 blocks from @ref(array of references)
 $rcoords1Nr = $ref[$wNr]->[0]; $rchrms1Nr = $ref[$wNr]->[1];
 $rcoords2Nr = $ref[$xNr]->[0]; $rchrms2Nr = $ref[$xNr]->[1];
 $rcoords3Nr = $ref[$yNr]->[0]; $rchrms3Nr = $ref[$yNr]->[1];

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

 # to check presence of sub/overlap blocks b/n 1st and 2nd block
 $subovpFound12 = subovp_blocksM_found2(\@coords1Nr,\@coords2Nr,$chrs1Nr[0],$chrs1Nr[1]); 

 # to check presence of sub/overlap blocks b/n 2nd and 3rd block
 $subovpFound23 = subovp_blocksM_found2(\@coords2Nr,\@coords3Nr,$chrs2Nr[0],$chrs2Nr[1]); 
 $tmp_nor= closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]);
 #if the middle(2nd) block is Nor and the closer block has same chr seq and has orien up/down, then Merge with it

 if(   ($orB eq "Nor")&&($orA eq "Nor") 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    && (!($subovpFound12))   # if no sub blocks in between
    #&& (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  @temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
 } #if nors 
 elsif(   ($orB eq "Nor")&&($orA eq "Up")
    #&& ($endANr<$startBNr) 
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12))   # if no sub blocks in between
    #&& (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 { 
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
  	splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
 elsif(   ($orB eq "Nor")&&($orA eq "Down") 
    #&& ($endANr>$startBNr)
    && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==12)
    &&( !($subovpFound12) )   # if no sub blocks in between
    #&& (abs($startBNr-$endANr)<abs($startBNr-$startANr)) #means nearest end of block1 is closest
    && ($chrs1Nr[0] eq $chrs2Nr[0])&&($chrs1Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords1Nr[-1]-$coords2Nr[0])<abs($coords1Nr[0]-$coords2Nr[0])) || (abs($coords1Nr[-1]-$coords2Nr[-1])<abs($coords1Nr[0]-$coords2Nr[-1]))   )
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; #combine coords
  	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
  	my $rsrefUNr= \@srefUNr; # make new reference    
  	splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
  }
  elsif(abs($coords1Nr_srt[-1]-$coords1Nr_srt[0])<$block_length_nor)
  {
  	@temp =();push(@temp,@coords1Nr,@coords2Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs1Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$wNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--;  
  }
 }
   # conditions b/n B and C starts here
 elsif( ($orB eq "Nor")&&($orC eq "Nor") 
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  @temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
  my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
  my $rsrefUNr= \@srefUNr; # make new reference    
  splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
 }
 elsif( ($orB eq "Nor")&&($orC eq "Up") 
   #&& ($endBNr<$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; 
  }

 }  
 elsif( ($orB eq "Nor")&&($orC eq "Down") 
   #&& ($endBNr>$startCNr)
   && ((closerBl($startANr,$endANr,$startBNr,$endBNr,$startCNr,$endCNr,$chrs1Nr[0],$chrs2Nr[0],$chrs3Nr[0],$chrs1Nr[1],$chrs2Nr[1],$chrs3Nr[1]))==23)
   &&( !($subovpFound23) )   # if no sub blocks in between
   #&&  (abs($endBNr-$startCNr)<abs($endBNr-$endCNr)) #means nearest end of block2 is closest
   &&   ($chrs3Nr[0] eq $chrs2Nr[0])&&($chrs3Nr[1] eq $chrs2Nr[1]))
 {
  if ( (abs($coords3Nr[0]-$coords2Nr[-1])<abs($coords3Nr[-1]-$coords2Nr[-1])) ||  (abs($coords3Nr[0]-$coords2Nr[0])<abs($coords3Nr[-1]-$coords2Nr[0]))   )
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; #combine coords
	my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; # make new small reference for the merged coords
	my $rsrefUNr= \@srefUNr; # make new reference    
	splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; # replace and update  
  }
  elsif((abs($coords3Nr_srt[-1]-$coords3Nr_srt[0])<$block_length_nor)) #check how far is the farthest end
  {
  	@temp =();push(@temp,@coords2Nr,@coords3Nr);  my @coordsUNr=@temp; my @chrsUNr = @chrs3Nr; my @srefUNr = (); $srefUNr[0]=\@coordsUNr; $srefUNr[1]=\@chrsUNr; my $rsrefUNr= \@srefUNr; splice(@ref,$xNr,2,$rsrefUNr); $numelesNr--; $wNr--; $xNr--; $yNr--; 
  }
 } 

 # bring the other iterators just above $y if there is a gap between two iterators else just do ++
 if(($xNr != $yNr-1) ||($wNr != $xNr-1))
 {
  $xNr= $yNr-1;
  $wNr= $xNr-1;  
 }
 else
 {$wNr +=1; $xNr +=1; $yNr +=1;}
 #elsif($wNr != $xNr-1)
 #{
 # $wNr= $xNr-1;
 #}
                               

 #print "Before: $wNr,$xNr,$yNr\n";
 ($wNr,$xNr,$yNr)=iterate($wNr,$xNr,$yNr,$numelesNr);

 #print "received: $wNr,$xNr,$yNr\n\n";
} #while

} #sub merge     


1;
