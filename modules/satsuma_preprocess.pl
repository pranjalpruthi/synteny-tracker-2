# Module: satsuma_preprocess.pl
# Satsuma Synteny Output Preprocessing Pipeline
# 
# Converts raw Satsuma synteny output to SyntenyTracker-compatible format.
# This module replicates the exact behavior of the original submit_f_scripts.sh pipeline.
#
# The original pipeline runs filtering TWICE with change_reference in between:
#   Pass 1: sort -> sort1 -> filtera -> filter2a -> filter -> filter3 -> filter4new -> change_reference
#   Pass 2: sort -> sort1 -> filtera -> filter2a -> filter -> filter3 -> filter4new -> change_reference
#   Final:  sort -> sort1 -> st_format
#
# Input:  Satsuma output (target_chr, target_start, target_end, ref_chr, ref_start, ref_end, score, sign)
# Output: SyntenyTracker format (target_chr, target_start, target_end, marker_id, marker_id, marker_id, ref_chr, ref_start, ref_end)

use strict;
use warnings;

# Main preprocessing function
sub preprocess_satsuma {
    my ($infile, $outfile, $tmp_dir, $keep_tmp) = @_;
    
    die "Input file '$infile' not found\n" unless -e $infile;
    
    # Use system temp if not provided or not a directory
    $tmp_dir = "/tmp" unless defined $tmp_dir && -d $tmp_dir;
    
    my @tmp_files;
    my $current = $infile;
    
    # ========== PASS 1 ==========
    print STDERR "    Pass 1:\n";
    
    # S1: sort.pl
    print STDERR "      S1: sort\n";
    my $tmp1 = _tmp_file($tmp_dir, "s01_pass1_sort"); push @tmp_files, $tmp1;
    _sort_simple($current, $tmp1);
    $current = $tmp1;
    
    # S2: sort1.pl
    print STDERR "      S2: sort1\n";
    my $tmp2 = _tmp_file($tmp_dir, "s02_pass1_sort1"); push @tmp_files, $tmp2;
    _sort_by_coord($current, $tmp2);
    $current = $tmp2;
    
    # S3: filtera.pl
    print STDERR "      S3: filtera\n";
    my $tmp3 = _tmp_file($tmp_dir, "s03_pass1_filtera"); push @tmp_files, $tmp3;
    _filtera($current, $tmp3);
    $current = $tmp3;
    
    # S4: filter2a.pl
    print STDERR "      S4: filter2a\n";
    my $tmp4 = _tmp_file($tmp_dir, "s04_pass1_filter2a"); push @tmp_files, $tmp4;
    _filter2a($current, $tmp4);
    $current = $tmp4;
    
    # S5: filter.pl
    print STDERR "      S5: filter\n";
    my $tmp5 = _tmp_file($tmp_dir, "s05_pass1_filter"); push @tmp_files, $tmp5;
    _filter($current, $tmp5);
    # IMPORTANT: In Pass 1, output of filter.pl (tmp5) is IGNORED by subsequent step!
    # Original script: perl filter3.pl ${INDIR}/filter2a_result ...
    # So we do NOT update $current here.
    
    # S6: filter3.pl
    print STDERR "      S6: filter3\n";
    my $tmp6 = _tmp_file($tmp_dir, "s06_pass1_filter3"); push @tmp_files, $tmp6;
    _filter3($current, $tmp6); # Takes $current which is tmp4 (filter2a output)
    $current = $tmp6;
    
    # S7: filter4new.pl
    print STDERR "      S7: filter4new\n";
    my $tmp7 = _tmp_file($tmp_dir, "s07_pass1_filter4new"); push @tmp_files, $tmp7;
    _filter4new($current, $tmp7);
    $current = $tmp7;
    
    # S8: change_reference_1.pl
    print STDERR "      S8: change_reference\n";
    my $tmp8 = _tmp_file($tmp_dir, "s08_pass1_changeref"); push @tmp_files, $tmp8;
    _change_reference($current, $tmp8);
    $current = $tmp8;
    
    # ========== PASS 2 ==========
    print STDERR "    Pass 2:\n";
    
    # S9: sort.pl
    print STDERR "      S9: sort\n";
    my $tmp9 = _tmp_file($tmp_dir, "s09_pass2_sort"); push @tmp_files, $tmp9;
    _sort_simple($current, $tmp9);
    $current = $tmp9;
    
    # S10: sort1.pl
    print STDERR "      S10: sort1\n";
    my $tmp10 = _tmp_file($tmp_dir, "s10_pass2_sort1"); push @tmp_files, $tmp10;
    _sort_by_coord($current, $tmp10);
    $current = $tmp10;
    
    # S11: filtera.pl
    print STDERR "      S11: filtera\n";
    my $tmp11 = _tmp_file($tmp_dir, "s11_pass2_filtera"); push @tmp_files, $tmp11;
    _filtera($current, $tmp11);
    $current = $tmp11;
    
    # S12: filter2a.pl
    print STDERR "      S12: filter2a\n";
    my $tmp12 = _tmp_file($tmp_dir, "s12_pass2_filter2a"); push @tmp_files, $tmp12;
    _filter2a($current, $tmp12);
    $current = $tmp12;
    
    # S13: filter.pl
    print STDERR "      S13: filter\n";
    my $tmp13 = _tmp_file($tmp_dir, "s13_pass2_filter"); push @tmp_files, $tmp13;
    _filter($current, $tmp13);
    $current = $tmp13; 
    # IMPORTANT: In Pass 2, filter.pl output IS used.
    # Original script: perl filter3.pl ${INDIR}/chr_filter_result ...
    
    # S14: filter3.pl
    print STDERR "      S14: filter3\n";
    my $tmp14 = _tmp_file($tmp_dir, "s14_pass2_filter3"); push @tmp_files, $tmp14;
    _filter3($current, $tmp14);
    $current = $tmp14;
    
    # S15: filter4new.pl
    print STDERR "      S15: filter4new\n";
    my $tmp15 = _tmp_file($tmp_dir, "s15_pass2_filter4new"); push @tmp_files, $tmp15;
    _filter4new($current, $tmp15);
    $current = $tmp15;
    
    # S16: change_reference_1.pl
    print STDERR "      S16: change_reference\n";
    my $tmp16 = _tmp_file($tmp_dir, "s16_pass2_changeref"); push @tmp_files, $tmp16;
    _change_reference($current, $tmp16);
    $current = $tmp16;
    
    # ========== FINAL ==========
    print STDERR "    Final:\n";
    
    # S17: sort.pl
    print STDERR "      S17: sort\n";
    my $tmp17 = _tmp_file($tmp_dir, "s17_final_sort"); push @tmp_files, $tmp17;
    _sort_simple($current, $tmp17);
    $current = $tmp17;
    
    # S18: sort1.pl
    print STDERR "      S18: sort1\n";
    my $tmp18 = _tmp_file($tmp_dir, "s18_final_sort1"); push @tmp_files, $tmp18;
    _sort_by_coord($current, $tmp18);
    $current = $tmp18;
    
    # S19: st_format.pl
    print STDERR "      S19: st_format\n";
    _st_format($current, $outfile);
    
    # Cleanup
    unlink @tmp_files unless $keep_tmp;
    
    print STDERR "    Preprocessing complete: $outfile\n";
}

sub _tmp_file {
    my ($dir, $name) = @_;
    return "$dir/${name}.txt";
}

# sort.pl - simple alphabetical sort
sub _sort_simple {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    while (<$in>) { chomp; push @lines, $_; }
    close $in;
    @lines = sort @lines;
    print $out "$_\n" for @lines;
    close $out;
}

# sort1.pl - sort by first column, then by second column (coordinate)
# IMPORTANT: Prepends coordinate as new first column (like original sort1.pl)
sub _sort_by_coord {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my %data;
    my @contigs;
    my %seen;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        my $contig = $tmp[0] // '';
        my $coord = $tmp[1] + 0;
        # Store coord and line - we'll prepend coord to output
        push @{$data{$contig}}, [$coord, $line];
        push @contigs, $contig unless $seen{$contig}++;
    }
    close $in;
    for my $contig (sort @contigs) {
        my @sorted = sort { $a->[0] <=> $b->[0] } @{$data{$contig}};
        # Prepend coordinate as first column (like original sort1.pl)
        print $out "$_->[0]\t$_->[1]\n" for @sorted;
    }
    close $out;
}

# filtera.pl - filter by chromosome and coordinate ordering
# After sort1.pl prepends coord: col0=coord, col1=target_chr, col2=target_start, col3=target_end, col4=ref_chr, col5=ref_start, col6=ref_end, col7=score, col8=sign
sub _filtera {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    my @start;
    my @end;
    my @chr;
    my @chr1;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        push @lines, $line;
        push @start, $tmp[2] + 0;  # target_start (col2)
        push @end, $tmp[3] + 0;    # target_end (col3)
        push @chr, $tmp[1] // '';  # target_chr (col1)
        push @chr1, $tmp[4] // ''; # ref_chr (col4)
    }
    close $in;
    
    no warnings 'uninitialized';
    for my $x (0..$#chr) {
        if ($chr[$x] eq $chr[$x+1] && $end[$x] < $start[$x+1] && $chr1[$x] eq $chr1[$x+1]) {
            print $out "$lines[$x]\n";
        } elsif ($chr[$x] ne $chr[$x+1]) {
            print $out "$lines[$x]\n";
        }
    }
    use warnings;
    close $out;
}

# filter2a.pl - filter by sign consistency
# After sort1.pl prepends coord: col0=coord, col1=target_chr, col2=target_start, col3=target_end, col4=ref_chr, col5=ref_start, col6=ref_end, col7=score, col8=sign
sub _filter2a {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    my @start;
    my @end;
    my @chr;
    my @chr1;
    my @sign;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        push @lines, $line;
        push @start, $tmp[5] + 0;  # ref_start (col5)
        push @end, $tmp[6] + 0;    # ref_end (col6)
        push @chr, $tmp[1] // '';  # target_chr (col1)
        push @chr1, $tmp[4] // ''; # ref_chr (col4)
        push @sign, $tmp[8] // '+'; # sign (col8)
    }
    close $in;
    
    no warnings 'uninitialized';
    for my $x (0..$#chr) {
        if ($chr[$x] eq $chr[$x+1] && $end[$x] < $start[$x+1] && 
            $sign[$x] eq '+' && $sign[$x+1] eq '+' && $chr1[$x] eq $chr1[$x+1]) {
            print $out "$lines[$x]\n";
        }
        elsif ($chr[$x] eq $chr[$x+1] && $end[$x] > $start[$x+1] && 
               $sign[$x] eq '-' && $sign[$x+1] eq '-' && $chr1[$x] eq $chr1[$x+1]) {
            print $out "$lines[$x]\n";
        }
        elsif ($chr[$x] ne $chr[$x+1] || $sign[$x] ne $sign[$x+1]) {
            print $out "$lines[$x]\n";
        }
    }
    use warnings;
    close $out;
}

# filter.pl - filter by distance (<500000) and same chromosome
# After sort1.pl prepends coord: col0=coord, col1=target_chr, col2=target_start, col3=target_end, col4=ref_chr, col5=ref_start, col6=ref_end, col7=score, col8=sign
sub _filter {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    my @coord;
    my @chr;
    my %idd;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        push @lines, $line;
        push @coord, $tmp[5] + 0;  # ref_start (col5)
        push @chr, $tmp[1] // '';  # target_chr (col1)
    }
    close $in;
    
    no warnings 'uninitialized';
    for my $x (0..$#coord) {
        # Note: $x-1 implies circular check against last element for index 0, mimicking original Perl behavior
        if ((abs($coord[$x] - $coord[$x-1]) < 500000 && $chr[$x] eq $chr[$x-1] && !$idd{$lines[$x]}) ||
            (abs($coord[$x] - $coord[$x+1]) < 500000 && $chr[$x] eq $chr[$x+1] && !$idd{$lines[$x]})) {
            print $out "$lines[$x]\n";
            $idd{$lines[$x]} = 1;
        }
    }
    use warnings;
    close $out;
}

# filter3.pl - mark boundaries
# After sort1.pl prepends coord: col0=coord, col1=target_chr, col2=target_start, col3=target_end, col4=ref_chr, col5=ref_start, col6=ref_end, col7=score, col8=sign
sub _filter3 {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    my @coord;
    my @chr;
    my @chr1;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        push @lines, $line;
        push @coord, $tmp[5] + 0;  # ref_start (col5)
        push @chr, $tmp[4] // '';  # ref_chr (col4)
        push @chr1, $tmp[1] // ''; # target_chr (col1)
    }
    close $in;
    
    no warnings 'uninitialized';
    for my $x (0..$#coord) {
        if ((abs($coord[$x] - $coord[$x-1]) > 100000) ||
            (abs($coord[$x] - $coord[$x+1]) > 100000) ||
            ($chr[$x] ne $chr[$x-1]) ||
            ($chr[$x] ne $chr[$x+1]) ||
            ($chr1[$x] ne $chr1[$x-1]) ||
            ($chr1[$x] ne $chr1[$x+1])) {
            print $out "$lines[$x]\tBOUND\n";
        } else {
            print $out "$lines[$x]\tinter\n";
        }
    }
    use warnings;
    close $out;
}

# filter4new.pl - remove small blocks (<=50kb)
# After sort1 prepends coord: col0=coord, col1=target_chr, col2=target_start, col3=target_end, col4=ref_chr, col5=ref_start, col6=ref_end, col7=score, col8=sign
# After filter3 adds: col9=BOUND/inter
sub _filter4new {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my @lines;
    my @coord;
    my @status;
    my @chr;
    my %idd;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        push @lines, $line;
        push @coord, $tmp[2] + 0;   # target_start (col2)
        push @status, $tmp[9] // ''; # BOUND/inter (col9)
        push @chr, $tmp[1] // '';   # target_chr (col1)
    }
    close $in;
    
    my @array;
    my $dd = 0;
    
    no warnings 'uninitialized';
    for my $x (0..$#coord) {
        if ($status[$x] eq "BOUND" && $dd == 0) {
            push @array, $coord[$x];
            $dd = 1;
        }
        elsif ($dd == 1 && $status[$x] eq "inter") {
            push @array, $coord[$x];
        }
        elsif ($dd == 1 && $status[$x] eq "BOUND") {
            push @array, $coord[$x];
            $dd = 0;
            @array = sort {$a <=> $b} @array;
            if (@array > 0) {
                my $size = $array[-1] - $array[0];
                if ($size <= 50000) {
                    $idd{$_, $chr[$x]} = 1 for @array;
                }
            }
            @array = ();
        }
    }
    
    for my $x (0..$#coord) {
        if ($status[$x-1] eq "BOUND" && $status[$x] eq "BOUND" && $status[$x+1] eq "BOUND" &&
            $chr[$x-1] eq $chr[$x] && $chr[$x] eq $chr[$x+1]) {
            $idd{$coord[$x], $chr[$x]} = 1;
        }
    }
    use warnings;
    
    my $i = 1;
    for my $x (0..$#lines) {
        unless ($idd{$coord[$x], $chr[$x]}) {
            print $out "$lines[$x]\t$i\n";
            $i++;
        }
    }
    close $out;
}

# change_reference_1.pl - swap reference and target columns
sub _change_reference {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    while (my $line = <$in>) {
        $line =~ s/\r\n/\n/;
        chomp $line;
        my @tmp = split /\t/, $line;
        $tmp[4] =~ s/^Chr//i;
        $tmp[4] =~ s/^chr//i;
        # Swap: col4, col5, col6, col1, col2, col3, col7, col8
        print $out "$tmp[4]\t$tmp[5]\t$tmp[6]\t$tmp[1]\t$tmp[2]\t$tmp[3]\t$tmp[7]\t$tmp[8]\n";
    }
    close $in;
    close $out;
}

# st_format.pl - final format conversion
# After final sort1 prepends coord: col0=coord, col1=ref_chr, col2=ref_start, col3=ref_end, col4=target_chr, col5=target_start, col6=target_end, col7=score, col8=sign
sub _st_format {
    my ($infile, $outfile) = @_;
    open(my $in, '<', $infile) or die "Cannot open $infile: $!";
    open(my $out, '>', $outfile) or die "Cannot open $outfile: $!";
    my $i = 0;
    while (my $line = <$in>) {
        chomp $line;
        my @tmp = split /\t/, $line;
        $i++;
        
        my $chr0 = $tmp[4] // '';  # target_chr
        my $chr = $tmp[1] // '';   # ref_chr
        
        if ($chr0 =~ /\_/) {
            ($chr0) = $chr0 =~ /(.+)\_l/;
        }
        if ($chr0 =~ /scaffold_.+/) {
            ($chr0) = $chr0 =~ /scaffold_(.+)/;
        }
        
        if ($chr =~ /scaffold_.+/) {
            ($chr) = $chr =~ /scaffold_(.+)/;
        } elsif ($chr =~ /\_/) {
            ($chr) = $chr =~ /(.+)\_/;
        }
        
        my $marker = $i . ($tmp[8] // '+');
        # Output: chr0, target_start, target_end, marker, marker, marker, chr, ref_start, ref_end
        print $out "$chr0\t$tmp[5]\t$tmp[6]\t$marker\t$marker\t$marker\t$chr\t$tmp[2]\t$tmp[3]\n";
    }
    close $in;
    close $out;
}

# Run main if invoked directly
unless (caller) {
    die "Usage: perl satsuma_preprocess.pl <infile> <outfile>\n" unless @ARGV == 2;
    preprocess_satsuma($ARGV[0], $ARGV[1]);
}

1;