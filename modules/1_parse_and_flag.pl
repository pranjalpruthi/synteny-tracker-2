# Module: 1_parse_and_flag.pl
# Auto-generated from synteny_assign_v3_80_genes.pl (lines 1-82, procedural code only)

#!/usr/bin/perl5.8.8


$ref_name= $ARGV[0];
$tar_name= $ARGV[1];
$infile = $ARGV[4];
$block_size = $ARGV[2]; #100000;
$jumping_dist = 0;
$distBnMrks =  $ARGV[3];#30000;
$flag = 3*$distBnMrks;
$block_length_nor = 0;


### Reads the input file into an array. While reading into an array it assigns a flag "TC"
#   at the current position where there is a gap >3mb b/n current marker and prev marker
open(READ, $infile) or die "cannot open the file";

$firstRow = 1;$pstart = ""; #$cnum =1;
@lines=(); %lines_hash=();
while($line = <READ>)
{
  @row = split(/\s+/,$line); $numele = @row; @row_copy = @row; $lastele=pop(@row_copy);
  #if (!($row[2] =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/)) # if it doesn't contain words
  #if($numele>=5)
  if($lastele!=10000)
  { #print "row3 = $row[3]\n";
   $m_name = $row[4];  # Marker name or Marker ID 
   $cstart = $row[1];  # chromosome start
   $cend = $row[2];    # chromosome end
   $cstart =~ s/,//g; $cend =~ s/,//g;
   $cb_chr = $row[6];  # Cattle chromosome
   $ch_chr = $row[0] ; # Human chromosome
   $cnum = 10000;   $newnm = 10000;
   #print "@row\n";
   #print "cb_chr = $cb_chr\n";

   if($pstart ne "")
   { #$t = max_num($cstart,$pstart); print "$cstart $pstart  max = $t\n";
    if( (max_num($cstart,$pstart) - min_num($cstart,$pstart)) >= $flag ) # if flag changes >3Mbp
    { $cflow = "TC $pstart"; #$cflow = "do"; 
    }
    else { $cflow = "do";}
    #print "cstart = $cstart pstart = $pstart cflow = $cflow max = $tem\n\n";
   }
  }
  else
  {
   $m_name = $row[0]; $cstart ="\t"; $cend="\t"; $cb_chr = $pb_chr; $ch_chr = $ph_chr;
   $cflow= "do"; $cnum = 10000; 
  }

  #if (!($row[2] =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/))
  #if($numele>=5)
  if($lastele!=10000)
  {
   $pstart = $cstart; $pend = $cend;
   $pb_chr = $cb_chr; $ph_chr = $ch_chr;
   $pflow = $cflow;
  }
 
 $id_ = $ch_chr."_".$cstart; #print "$id_\n";
 push (@info,$m_name,$cb_chr,$ch_chr,$cstart,$cend,$cnum,$cflow,$newnm); 
 chomp($line); push (@lines,$line);
# $lines_hash{$id_}=$line;
 $lines_hash{$m_name}=$line;
 $firstRow = 0; # to say that first row is finished
} #while

############Mark Trend changes##########

#open(WR,'>/var/www/html/labs/lewin/donthu/Synteny_assign/output_files/testOut');
my $testOut_file = $::OUTPUT_DIR ? "$::OUTPUT_DIR/testOut" : "testOut";
open(WR,">$testOut_file");
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
