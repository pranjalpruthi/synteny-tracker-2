# Module: 7_final_output.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 5061-5285, procedural code only)

#$tab_out2 = "/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/".$tab_out;
#open(WR,">$tab_out2");
#open(WR2,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut5');
my $testOut5_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut5" : "testOut5";
open(WR,">$testOut5_file");
$len = @info;
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
$ite=0;
print WR "HSB\t$tar_name\_chromosome\t$tar_name\_start\t$tar_name\_end\tMarker\_name1\tMarker\_name2\tMarker\_name3\t$ref_name\_chromosome\t$ref_name\_start\t$ref_name\_end\n";
#print WR2 "HSB\t$tar_name chr\t$tar_name start\t$tar_name end\tMarker name1\tMarker name2\tMarker name3\t$ref_name chr\t$ref_name start\t$ref_name end\n";
#print WR "Target_genome\tTarget_chromosome\tTarget_chr_start\tTarget_chr_end\tReference_chromosome\tReference_chr_start\tReference_chr_end\tReference_genome\tHSB\n";
#print WR "HSB\tHSA\thsa_start\thsa_end\tid1\tid2\tid3\tSpecies2_chr\tspecies2_start\tspecies2_end\n";
#print WR "marker_name\tCattle_chr\thuman_chr\tStart\tEnd\tnumber\tflow\n";
while($i_newnm < $len)
{
 #print WR "$info[$p_mname]\t$info[$q_bchr]\t$info[$r_hchr]\t$info[$m_st]\t$info[$n_ed]\t$info[$i_num]\t$info[$j_fl]\t$info[$i_newnm]\n";
 print WR "$info[$i_num]\t$lines[$ite]\n";
 #print WR2 "$info[$i_num]\t$lines[$ite]\n";

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
$ite++;
} #while
close WR;

#open(READ, "<$tab_out2") or die "cannot open the file";
my $testOut5_read = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut5" : "testOut5";
open(READ, "<$testOut5_read") or die "cannot open the file";
#$EH_out2 = "/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/".$EH_out;
#open(WR,">$EH_out2");
my $blocks_info_file = $::FINAL_OUTPUT_DIR ? "$::FINAL_OUTPUT_DIR/blocks_info" : "blocks_info";
open(WR,">$blocks_info_file");

my %hash_ft=();
my $line=<READ>; #ignores header
#print WR "Target_genome\tTarget_chromosome\tTarget_chr_start\tTarget_chr_end\tReference_chromosome\tReference_chr_start\tReference_chr_end\tReference_genome\tHSB\n";
print WR "Reference\_genome\t$ref_name\_chromosome\t$ref_name\_start\t$ref_name\_end\t$tar_name\_chromosome\t$tar_name\_start\t$tar_name\_end\tSign\tTarget\_genome\tHSB\tComments\n";
print WR "nominal\tnominal\tint\tint\tnominal\tint\tint\tint\tnominal\tint\tnominal\n";
#print WR "Reference_genome\tReference_chromosome\tReference_chr_start\tReference_chr_end\tTarget_chromosome\tTarget_chr_start\tTarget_chr_end\tSign\tTarget_genome\tHSB\n";
while ($line = <READ>)
{
	chomp($line);
	@arr_ft = split(/\s+/,$line);
	if($hash_ft{$arr_ft[0]}) # if key already exists
	{
		$hash_ft{$arr_ft[0]} = $hash_ft{$arr_ft[0]}."\n".$line; #print "$line\n";
	}
	else
	{
		$hash_ft{$arr_ft[0]} = $line; #print "$line\n";
	}
}

my @temp_ft=(); # All the lines of a HSB
my @temp2_ft=(); # All the elements of a line of HSB
my @target_ft_or=(); # contains target start coords for calc orien
my $or_ft=();
my $sign_ft=();


foreach my $key_ft (sort {$a<=>$b} keys %hash_ft) #reads HSB by HSB
{
	if($key_ft =~ /\d/)
	{
		@temp_ft= split(/\n/,$hash_ft{$key_ft}); #print "\n";
		@temp2_ft=(); @target_ft=();@target_ft_or=(); @ref_ft=(); $or_ft=(); $sign_ft=();
		foreach my $ele(@temp_ft) # read all the lines of one HSB
		{
			@temp2_ft = split(/\s+/,$ele);
			push(@target_ft_or,$temp2_ft[2]);
			push(@target_ft,$temp2_ft[2],$temp2_ft[3]);
			push(@ref_ft,$temp2_ft[8],$temp2_ft[9]);
		}
                @target_ft_or = remove_empty_cells(@target_ft_or); $or_ft = getOrien(@target_ft_or);
		if($or_ft eq "Up"){$sign_ft = "+";}elsif($or_ft eq "Down"){$sign_ft="-";}
		@target_ft = sort {$a<=>$b} (@target_ft); @target_ft = remove_empty_cells(@target_ft);
		@ref_ft = sort {$a<=>$b} (@ref_ft); @ref_ft = remove_empty_cells(@ref_ft);
#		print WR "$tar_name\t$temp2_ft[1]\t$target_ft[0]\t$target_ft[-1]\t$temp2_ft[7]\t$ref_ft[0]\t$ref_ft[-1]\t$ref_name\t$key_ft\n";
		print WR "$ref_name\t$temp2_ft[7]\t$ref_ft[0]\t$ref_ft[-1]\t$temp2_ft[1]\t$target_ft[0]\t$target_ft[-1]\t$sign_ft\t$tar_name\t$key_ft\n";
		#print WR2 "$key_ft\n@ref_ft\n@target_ft\n@temp2_ft\n\n\n";
	}
}


############## Get singletons informtion
$len = @info; my %singleton_coords=();
$p_mname=0; $q_bchr=1; $r_hchr=2; $m_st=3; $n_ed=4; $i_num=5; $j_fl=6; $i_newnm = 7;
$ite=0;
#print WR "HSB\tMarker_name\thuman_chr\tCattle_chr\tStart\tEnd\n";
while($i_newnm < $len)
{
    #print WR2 "Data is being analyzed25\n";
    if($info[$i_num] eq "Singleton"){$singleton_coords{ $info[$p_mname]}="Singleton";}
 elsif($info[$i_num] eq "out-of-place"){$singleton_coords{ $info[$p_mname]}="out-of-place";}

$p_mname += 8;$q_bchr += 8; $r_hchr+= 8; $m_st+= 8; $n_ed+= 8; $i_num+= 8; $j_fl+= 8; $i_newnm +=8;
$ite++;
} #while





#@info = @new_info; # to assign changes done in new_info to info

############## Make a file that contains information about the blocks
#$EH_out2 = "/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/".$EH_out;
#open(WR,">$EH_out2");
#print WR "Number\tCattle_chr\tHuman_chr\tStart\tEnd\n";
#open(WR,'>blocks_info');
#print WR "Target_genome\tTarget_chromosome\tTarget_chr_start\tTarget_chr_end\tReference_chromosome\tReference_chr_start\tReference_chr_end\tReference_genome\tHSB\n";
#print WR "Number\tCattle_chr\tHuman_chr\tStart\tEnd\n";
$numelesS = @ref; $xS=0; my @coordsS=(); @chrsS=(); $numConsSingls = 0; $thrsSingls=3; $index=1;
while($xS < $numelesS)
{ 
 $rcoordsS = $ref[$xS]->[0]; $rchrmsS = $ref[$xS]->[1];  $rnamsS = $ref[$xS]->[2];# get the references of the blocks & chromosomes
 @coordsS =@$rcoordsS;  @chrsS = @$rchrmsS; $pb_chrS = $chrsS[0]; $ph_chrS =$chrsS[1]; $numCrds=@coordsS;
  # print "@$rnamsS\n@coordsS\n";

 my @m_coords = get_sp_coords(@$rnamsS,$ph_chrS,$pb_chrS);
 my @m_coords_srt = sort{$a <=> $b}(@m_coords); # sort in the ascending order
 #print "mouse coords: @m_coords\n";

 my @h_coords = get_h_coords_ends(@$rnamsS,$ph_chrS,$pb_chrS);
 #print "human end coords: @h_coords\n\n";
# push(@coordsS,@h_coords_ends);
  #print "After coords:@coordsS\n\n";
 my @h_coords_srt = sort{$a <=> $b}(@h_coords); # sort in the ascending order


 $start = $h_coords_srt[0]; $end = $h_coords_srt[-1];
if ($start =~ /\d/)
 {
	if($singleton_coords{$$rnamsS[0]})
	{
		$index--;
	#	print WR "HSA35\t$ph_chrS\t$start\t$end\t$pb_chrS\t$m_coords_srt[0]\t$m_coords_srt[-1]\t\tcattle\t$\n";				
	}
	else	{	#print WR "$tar_name\t$ph_chrS\t$start\t$end\t$pb_chrS\t$m_coords_srt[0]\t$m_coords_srt[-1]\t$ref_name\t$index\n";
		}
 }
 else {$index--;}




# print WR "HSA35\t$ph_chrS\t$start\t$end\t$pb_chrS\t$m_coords_srt[0]\t$m_coords_srt[-1]\t\tmousek\t$index\n";

 @coordsS = (); @chrsS=(); # updation
 $xS +=1; $index++;
} #while


close WR;






1;
