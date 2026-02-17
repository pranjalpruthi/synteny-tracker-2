# Module: 3_jumping_logic.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 436-1599, procedural code only)

##########################Jump
$cmarker_name = ""; $cb_chr = ""; $ch_chr = ""; $cstart = ""; $cend = ""; $cnum = ""; $cflow = "";
$pmarker_name = ""; $pb_chr = ""; $ph_chr = ""; $pstart = ""; $pend = ""; $pnum = ""; $pflow = "";
@coords=();@coords1=();@coords2=();@coords3=();@coords4=();@coords5=(); $counter=0;

$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm =7;
$cond3 = 1; $cond1 = 0; $cond4=0; $f_b_st = 0; #first block not started
$tc_passed =0; $newnum = 1000; $bl_passed =0;$counter=0;
while($i_newnm < $len)
{ 
 $cmarker_name = $info[$p_mname]; $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
 $cstart = $info[$m_st]; $cend = $info[$n_ed]; $cnum = $info[$i_num];
 $cflow = $info[$j_fl];
 #print "outer while";
 # checks if block 1 started
 $f_b_st = 1 if (($cflow ne "")&&($f_b_st != 1));
 #$tc_passed++ if (($cflow =~ /TC/)&&($tc_passed <= 3));
 
 if($f_b_st ==1)
 { #print "coords:@coords\n";
  
  if($cnum != $pnum )
  {
   $bl_passed++ if($bl_passed <6); 
   if($bl_passed==1){@coords1=@coords;@chrms1=($pb_chr,$ph_chr);} 
   elsif($bl_passed==2){@coords2=@coords;@chrms2=($pb_chr,$ph_chr);}
   elsif($bl_passed==3){@coords3=@coords;@chrms3=($pb_chr,$ph_chr);}
   elsif($bl_passed==4){@coords4=@coords;@chrms4=($pb_chr,$ph_chr);}
   elsif($bl_passed==5){   
   @coords5=@coords;@chrms5=($pb_chr,$ph_chr);   
   } #elsif
   elsif($bl_passed==6){
   @coords1=@coords2;@coords2=@coords3; 
   @coords3=@coords4;@coords4=@coords5; #print "INS coords1=@coords1\n\n"; print "INS coords2=@coords2\n\n";
   @coords5=@coords;
   @chrms1=@chrms2;@chrms2=@chrms3; @chrms3=@chrms4;@chrms4=@chrms5;
   @chrms5=($pb_chr,$ph_chr);}
   
   @coords = ();
  }

  if( ($bl_passed>=5)&&($cnum != $pnum)  )  
  {                            
   @coords = ();
   $l3 = @coords3; 
   $dist_crds2 = abs($coords3[0] - $coords3[1]);

   if($l3==1)
   { $posJmp= jplocwnAll(\@coords1,\@coords2,\@coords3,\@coords4,\@coords5); #print "$coords3[0]\t";

    if(jplocIns(\@coords3,\@coords1,blockDist(@coords2)))
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     $bl_passed = 4;     
     }
    }
    elsif(jplocIns(\@coords3,\@coords2,0))
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     $bl_passed = 4;  
     }
    }
    elsif(jplocIns(\@coords3,\@coords4,0))
    {
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     $bl_passed = 4; 
     }
    }
    elsif(jplocIns(\@coords3,\@coords5,blockDist(@coords4)))
    {
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords5,\@chrms5,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;
     $bl_passed = 4;  
     }
    }
    elsif($posJmp==131) # 131 means block3 which is a singleton jumps to the top(1 and 2 for bottom) of block1
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;
     }
    }
    elsif($posJmp==231)
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,1);
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4; 
     }
    }
    elsif($posJmp==431)
    {
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4; 
     }
    }
    elsif($posJmp==531)
    {
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {
      change_numbers2(\@coords3,\@coords5,\@chrms5,1); 
      # add coords of 2 blocks
      @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;

      @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
      $bl_passed = 4; 
     }
    }
     elsif($posJmp==132)
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;
     }
    }
    elsif($posJmp==232)
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;  
     }
    }
    elsif($posJmp==432)
    {
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4; 
     }
    }
    elsif($posJmp==532)
    {
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {
      change_numbers2(\@coords3,\@coords5,\@chrms5,2); 
      # add coords of 2 blocks
      @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;
      @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
      $bl_passed = 4; 
     }
    }
             

   } #l3==1

   
   elsif(($l3==2)&&($dist_crds2<$distBnMrks))
   {  

    $posJmp2= find_jumplocwithin2(\@coords1,\@coords2,\@coords3,\@coords4,\@coords5); #if ($coords3[0]==36395957){print "Jump to: $posJmp2\n";}
    
    if($posJmp2==231)
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    }  
    elsif($posJmp2==431)
    { 
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif($posJmp2==131)
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif($posJmp2==531)
    { 
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords5,\@chrms5,1); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     } # chr seq
    } 
    elsif($posJmp2==232)
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    }  
    elsif($posJmp2==432)
    { 
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif($posJmp2==132)
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif($posJmp2==532)
    { 
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords5,\@chrms5,2); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     } # chr seq
    }
    elsif((find_jumploc(\@coords3,\@coords2,0) == 1) && ($l3!=3))
    { 
     if(($chrms3[0] eq $chrms2[0])&&($chrms3[1] eq $chrms2[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords2,\@chrms2,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords2,@coords3); @coords1=@coords1; @coords2=@temp;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    }
    elsif((find_jumploc(\@coords3,\@coords1,blockDist(@coords2)) == 1) && ($l3!=3))
    { 
     if(($chrms3[0] eq $chrms1[0])&&($chrms3[1] eq $chrms1[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords1,\@chrms1,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords1,@coords3); @coords1=@temp;@coords2=@coords2;@coords3=@coords4;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif((find_jumploc(\@coords3,\@coords4,0) == 1) && ($l3!=3))
    { 
     if(($chrms3[0] eq $chrms4[0])&&($chrms3[1] eq $chrms4[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords4,\@chrms4,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords4); @coords1=@coords1; @coords2=@coords2;@coords3=@temp;@coords4=@coords5;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     }
    } 
    elsif((find_jumploc(\@coords3,\@coords5,blockDist(@coords4)) == 1) && ($l3!=3))
    { 
     if(($chrms3[0] eq $chrms5[0])&&($chrms3[1] eq $chrms5[1])) #chr seq is same
     {change_numbers2(\@coords3,\@coords5,\@chrms5,0); 
     # add coords of 2 blocks
     @temp =(); push(@temp,@coords3,@coords5); @coords1=@coords1; @coords2=@coords2;@coords3=@coords4;@coords4=@temp;
     @chrms1=@chrms1;@chrms2=@chrms2; @chrms3=@chrms4; @chrms4=@chrms5; #update chrms
     $bl_passed = 4;     
     } # chr seq
    }
   } #l3==2
   
  } # cnum!=pnum

  
 } # if f_b_st
 if(!($cstart =~ /\s+/)){ push(@coords, $cstart);} 
 
 $pmarker_name = $cmarker_name; $pb_chr = $cb_chr; $ph_chr = $ch_chr;
 $pstart = $cstart; $pend = $cend; $pnum = $cnum; $pflow = $cflow;
 
 $p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm+=8;

} #while



# change numbers of microsatellites
$len = @info; 
$q_bchr=1; $r_hchr=2; $m_st=3;$i_num=5; $i_newnm = 7; $pnum=1;
while($i_newnm < $len)
{
 $cb_chr = $info[$q_bchr]; $ch_chr = $info[$r_hchr];
 $cstart = $info[$m_st]; $cnum = $info[$i_num];

 if($cstart =~ /\s+/)
 {
  $info[$i_num] = $pnum; $cnum=$pnum;#print "here\t";
 }
 
 $pnum = $cnum;
 $q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $i_num+= 8; $i_newnm+=8;
} #while



#This subroutine checks the following conditions and returns either 0 or 1
# 1.whether the single marker block added to a block which has more than 3 markers and with distance b/n
# first and last markers is >2mbp
# 2.Checks whether the last marker falls in between last but one marker and the added singleton.



















################end jump

#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut2aa');
my $testOut2aa_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut2aa" : "testOut2aa";
open(WR,">$testOut2aa_file");

$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;


######### adjust numbering

$len = @info;$i_num=5; $i_newnm = 7;$index =0; %oldnums =(); %corres_num=();
$pnum =0;
while($i_newnm < $len)
{
 $cnum = $info[$i_num]; # get the syn block number

 if($cnum != $pnum)
 {
  if($oldnums{$cnum}!=1)
  {
   $index++; # increments block number
   $oldnums{$cnum}=1; $corres_num{$cnum}=$index; # assigns values to the hashmaps
  }    
 } # cnum != pnum
 
 #check whether this number is present in oldnums hashmap
 if($oldnums{$cnum}==1)
 {
  $info[$i_num]=$corres_num{$cnum};   # assign the corresponding number   
 }
  
 $pnum = $cnum; 
 $i_num += 8;  $i_newnm +=8;
} #while


##end adjust

#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut2aaa');
my $testOut2aaa_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut2aaa" : "testOut2aaa";
open(WR,">$testOut2aaa_file");

$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;


1;
