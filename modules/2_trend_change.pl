# Module: 2_trend_change.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 83-435, procedural code only)

#=for
#print "after 1st step\n";
 ## This reads the array @info block by block(here block means blocks b/n flags)
# when each block is passed, 3 prev consecutive blocks are processed. It process one of the following conditions of blocks
# and unites them into a single block.
# 1.Middle block with 3 markers, dirs of top & bottom block are same also chr sequence of all blocks are same
#   and dist b/n markers <3mb
# 2.Middle block with 2 markers only, with dirs of top & bottom block are same also chr sequence of all blocks are same
#   This assumes that it is a flip.
# 3.When dirs of top and bottom blocks are different but chr seq is same, with middle block with 2 or 3 markers. 
#   There are 2 subconditions here.
#   a.distance b/n 1st block and 2nd block is less than dist b/n 2nd & 3rd block.   
#   b.distance b/n 2nd block and 3rd block is less than dist b/n 1st & 2nd block.
# 4.Middle block is a single marker block, with 2 subconditions same as the subconds of prev one. 
#   Chr seq is same under subconds
$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm =7;
$cond3 = 1; $cond1 = 0; $cond4=0;$index = 1; $f_b_st = 0; #first block not started
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
  if( (($cb_chr ne $pb_chr)||($ch_chr ne $ph_chr))&&($cflow =~/TC/))
  {
   $bl_passed++ if($bl_passed <4); 
   if($bl_passed==1){@coords1=@coords;@chrms1=($pb_chr,$ph_chr);} elsif($bl_passed==2){@coords2=@coords;@chrms2=($pb_chr,$ph_chr);}elsif($bl_passed==3){@coords3=@coords;@chrms3=($pb_chr,$ph_chr);}elsif($bl_passed==4){@coords1=@coords2;@coords2=@coords3;@coords3=@coords;@coords=();@chrms1=@chrms2;@chrms2=@chrms3;@chrms3=($pb_chr,$ph_chr);}
   @coords = ();
  }
  elsif( (($cb_chr ne $pb_chr)||($ch_chr ne $ph_chr))&&(!($cflow =~/TC/)))
  {
   $bl_passed++ if($bl_passed <4); 
   if($bl_passed==1){@coords1=@coords;@chrms1=($pb_chr,$ph_chr);} elsif($bl_passed==2){@coords2=@coords;@chrms2=($pb_chr,$ph_chr);}elsif($bl_passed==3){@coords3=@coords;@chrms3=($pb_chr,$ph_chr);}elsif($bl_passed==4){@coords1=@coords2;@coords2=@coords3;@coords3=@coords;@coords=();@chrms1=@chrms2;@chrms2=@chrms3;@chrms3=($pb_chr,$ph_chr);}
   @coords = ();
  }
  elsif($cflow =~ /TC/)
  {
   $bl_passed++ if($bl_passed <4); 
   if($bl_passed==1){@coords1=@coords;@chrms1=($pb_chr,$ph_chr);}
   elsif($bl_passed==2){@coords2=@coords;@chrms2=($pb_chr,$ph_chr);}
   elsif($bl_passed==3){@coords3=@coords;@chrms3=($pb_chr,$ph_chr);}
   elsif($bl_passed==4){@coords1=@coords2;@coords2=@coords3;@coords3=@coords;@coords=();@chrms1=@chrms2;@chrms2=@chrms3;@chrms3=($pb_chr,$ph_chr);}
   @coords = ();
  }

  if( ($bl_passed<3)&&( (($cb_chr ne $pb_chr)||($ch_chr ne $ph_chr)) || ($cflow=~/TC/) ) ){$index++;}
  elsif( ($bl_passed>=3)&&( (($cb_chr ne $pb_chr)||($ch_chr ne $ph_chr)) || ($cflow=~/TC/) ) )  
  {                         # to check one trend changed occured 
   @coords = ();
   $j_temp = $j_fl; $count =0;
   $j_temp -=8;
   $temp_flow = $info[$j_temp];  $temp_num = $info[$j_temp-1]; #print "tNUM:$temp_num\n";
   
   $bflow_1 = $info[$j_temp]; 
   $bflow_1 = ( split(/TC\s+/,$bflow_1) )[1]; #$bflow_1 =~ s/\s+//g;
   
   $cond1 = 1 if((($count-1) <= 3)&&(($count-1)>1));
   $cond3 = check_gapbnmrkers(@coords2);
   $cond4 = check_chrSeq123();
   $cond2 = check_bldir();
   $spcond = mrkConsis();

   $a=-1; $val1=$coords1[$a];$val1=~s/\s+//g; while($val1 eq ""){$a--; $val1=$coords1[$a];$val1 =~ s/\s+//g;}
   $a=-1; $val2=$coords2[$a]; $val2=~s/\s+//g; while($val2 eq ""){$a--; $val2=$coords2[$a];$val2 =~ s/\s+//g;}
   $a=0; $val3=$coords3[$a]; $val3=~s/\s+//g; while($val3 eq ""){$a++; $val3=$coords3[$a];$val3 =~ s/\s+//g;}
   $diff12 = abs($val1-$val2); 
   $diff23 = abs($val2-$val3);

   $a=0; $val2st=$coords2[$a]; $val2st=~s/\s+//g; while($val2st eq ""){$a++; $val2st=$coords2[$a];$val2st =~ s/\s+//g;}
   $a=-1; $val2ed=$coords2[$a]; $val2ed=~s/\s+//g; while($val2ed eq ""){$a--; $val2ed=$coords2[$a];$val2ed =~ s/\s+//g;}
   $diff12st= abs($val1-$val2st);   $diff2ed3= abs($val2ed-$val3);
      
   $cond3 = 1; $cond1 = 0; $cond4 =0;  
   $index++;
  } # if
  #elsif( ($cflow =~ /TC/)&&($tc_passed == 1) ) { $index++;}
  
 } # if f_b_st
 $info[$i_num] = $index; #print "segment: $info[$i_num]\n";
 
 #push(@coords, $cstart) if((!($cstart =~ /\s+/))&&($cstart ne ""));
 if(!($cstart =~ /\s+/)){ push(@coords, $cstart);} 
 
 $pmarker_name = $cmarker_name; $pb_chr = $cb_chr; $ph_chr = $ch_chr;
 $pstart = $cstart; $pend = $cend; $pnum = $cnum; $pflow = $cflow;
 
 $p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm+=8;

} #while













#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut2');
my $testOut2_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut2" : "testOut2";
open(WR,">$testOut2_file");
$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
} #while
close WR;




#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut2a');
my $testOut2a_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut2a" : "testOut2a";
open(WR,">$testOut2a_file");
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
