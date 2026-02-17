#!/usr/bin/env perl
# SyntenyTracker v2.0 - Modernized Modular Synteny Pipeline
# 
# Original SyntenyTracker by:
#   Ravikiran Donthu, Harris A. Lewin, and Denis M. Larkin (2009)
#   https://doi.org/10.1186/1756-0500-2-148
#
# v2.0 Modernization by:
#   Jitendra Lab of Bioinformatics and Big Data
#   CSIR-Institute of Genomics & Integrative Biology (CSIR-IGIB)
#   Lead Developer: Pranjal Pruthi | PI: Dr. Jitendra Narayan
#
# New Features in v2.0:
#   - Modularized pipeline architecture
#   - CLI interface with job management
#   - Conda package distribution
#   - Support for direct Satsuma synteny output
#
# GitHub: https://github.com/pranjalpruthi/getSYNTENY
# BioinformaticsOnLine: https://bioinformaticsonline.com
# Conda: https://anaconda.org/channels/jitendralab/
#
# Usage: perl run_synteny.pl <ref_name> <tar_name> <block_size> <distBnMrks> <infile> [options]
#
# Options:
#   -j, --job-name=NAME    Custom job name (default: auto-generated)
#   -o, --output-dir=DIR   Custom output directory (default: ./jobs/<job_name>)
#   -k                     Keep intermediate files (default: removed after run)
#   -s, --satsuma          Input is raw Satsuma output (auto-preprocess)
#   -h, --help             Show this help message
#
# Output organization:
#   <output_dir>/in/       - Input file (copied)
#   <output_dir>/out/      - Main output (blocks_info)
#   <output_dir>/out/.tmp/ - Intermediate files (testOut*) if -k

use strict;
use warnings;
use FindBin qw($Bin);
use File::Path qw(make_path remove_tree);
use File::Basename qw(basename dirname);
use File::Copy qw(copy);
use POSIX qw(strftime);
use Getopt::Long;
use Cwd qw(getcwd abs_path);

# ASCII Logo
my $ASCII_LOGO = <<'LOGO';
--      ____              _                  _____               _             
--     / ___| _   _ _ __ | |_ ___ _ __  _   |_   _| __ __ _  ___| | _____ _ __ 
--     \___ \| | | | '_ \| __/ _ \ '_ \| | | || || '__/ _` |/ __| |/ / _ \ '__|
--      ___) | |_| | | | | ||  __/ | | | |_| || || | | (_| | (__|   <  __/ |   
--     |____/ \__, |_| |_|\__\___|_| |_|\__, ||_||_|  \__,_|\___|_|\_\___|_|   
--            |___/                     |___/                                  v2.0

  Modernized Modular Synteny Pipeline
  Empowered by BioinformaticsOnLine
  Open source bioinformatics community
  https://bioinformaticsonline.com

  Jitendra Lab of Bioinformatics and Big Data
  CSIR-Institute of Genomics & Integrative Biology (CSIR-IGIB)
LOGO

# Help message
my $HELP_MSG = <<'HELP';
Usage: perl run_synteny.pl <ref_name> <tar_name> <block_size> <distBnMrks> <infile> [options]

Arguments:
  ref_name       Reference genome name (e.g., Adineta_vaga)
  tar_name       Target genome name (e.g., Adineta_ricciae)
  block_size     Block size in bp (e.g., 100000)
  distBnMrks     Distance between markers in bp (e.g., 30000)
  infile         Input file path (SyntenyTracker format or Satsuma output with -s)

Options:
  -j, --job-name=NAME    Custom job name (default: auto-generated timestamp)
  -o, --output-dir=DIR   Custom output directory (default: ./jobs/<job_name>)
  -k                     Keep intermediate files (default: removed after run)
  -s, --satsuma          Input is raw Satsuma output (auto-preprocess)
  -h, --help             Show this help message

Input Formats:
  Default:               SyntenyTracker format (9 columns)
                         target_chr, target_start, target_end, marker_id x3, ref_chr, ref_start, ref_end
  
  Satsuma (-s):          Raw Satsuma synteny output (8 columns)
                         target_chr, target_start, target_end, ref_chr, ref_start, ref_end, score, sign

Output:
  <output_dir>/in/           - Input file (copied)
  <output_dir>/out/          - Main output (blocks_info)
  <output_dir>/out/.tmp/     - Intermediate files (testOut*) if -k

Examples:
  # Basic usage with pre-formatted input
  perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 st_input.txt

  # Process raw Satsuma output
  perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 satsuma.out -s

  # Custom job name
  perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 input.txt -j my_analysis

  # Custom output directory
  perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 input.txt -o /path/to/results

  # Keep intermediate files for debugging
  perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 input.txt -k

Citation:
  Original SyntenyTracker: Donthu R, Lewin HA, Larkin DM. (2009)
  SyntenyTracker: a tool for defining terrestrial vertebrate syntenic blocks.
  BMC Res Notes. 2:148. https://doi.org/10.1186/1756-0500-2-148

For more information: https://github.com/pranjalpruthi/getSYNTENY
HELP

# Parse command line options
my $user_job_name = '';
my $user_output_dir = '';
my $keep_tmp = 0;
my $satsuma_mode = 0;
my $help = 0;

GetOptions(
    'j|job-name=s'   => \$user_job_name,
    'o|output-dir=s' => \$user_output_dir,
    'k'              => \$keep_tmp,
    's|satsuma'      => \$satsuma_mode,
    'h|help'         => \$help,
);

# Show help if requested
if ($help) {
    print STDERR $ASCII_LOGO . "\n";
    print STDERR $HELP_MSG;
    exit 0;
}

# Check required arguments
die $HELP_MSG unless @ARGV >= 5;

my ($ref_name, $tar_name, $block_size, $distBnMrks, $infile) = @ARGV;

# Validate input file exists
die "Error: Input file '$infile' does not exist\n" unless -e $infile;

# Generate job ID (shorter format)
my $job_id;
if ($user_job_name) {
    $job_id = $user_job_name;
} else {
    # Short job ID: YYMMDD_HHMMSS + 4 char random
    my @chars = ('a'..'z', '0'..'9');
    my $random = join '', map { $chars[rand @chars] } 1..4;
    my $timestamp = strftime("%y%m%d_%H%M%S", localtime);
    $job_id = "${timestamp}_${random}";
}

# Set up job directory structure
# Default to current working directory (not script location) for jobs
my $job_dir;
if ($user_output_dir) {
    $job_dir = $user_output_dir;
} else {
    my $cwd = getcwd();
    $job_dir = "$cwd/jobs/$job_id";
}

my $job_in_dir = "$job_dir/in";
my $job_out_dir = "$job_dir/out";
my $job_tmp_dir = "$job_out_dir/.tmp";

# Create directories
make_path($job_in_dir) or die "Cannot create $job_in_dir: $!";
make_path($job_tmp_dir) or die "Cannot create $job_tmp_dir: $!";

# Modules directory
my $modules_dir = "$Bin/modules";

# Print header
print STDERR $ASCII_LOGO . "\n";
print STDERR "=" x 55 . "\n";
print STDERR "Job ID:    $job_id\n";
print STDERR "Reference: $ref_name\n";
print STDERR "Target:    $tar_name\n";
print STDERR "Block:     $block_size | Distance: $distBnMrks\n";
print STDERR "Output:    $job_dir\n";
print STDERR "Mode:      " . ($satsuma_mode ? "Satsuma preprocessing" : "Direct input") . "\n";
print STDERR "=" x 55 . "\n\n";

# Handle Satsuma preprocessing
my $job_input;
if ($satsuma_mode) {
    print STDERR "  Preprocessing Satsuma output...\n";
    
    # Copy raw Satsuma input to job folder
    my $input_basename = basename($infile);
    my $raw_input = "$job_in_dir/${input_basename}.raw";
    copy($infile, $raw_input) or die "Cannot copy $infile: $!";
    
    # Output preprocessed file to same directory as input file
    my $input_dir = dirname(abs_path($infile));
    $job_input = "$input_dir/st_input";
    
    # Load and run preprocessing
    do "$modules_dir/satsuma_preprocess.pl" or die "Error loading satsuma_preprocess.pl: " . ($@ || $!) . "\n";
    preprocess_satsuma($infile, $job_input, $job_tmp_dir, $keep_tmp);
    
    # Also copy to job folder for reference
    copy($job_input, "$job_in_dir/st_input") or warn "Cannot copy st_input to job folder: $!";
} else {
    # Copy input file directly
    my $input_basename = basename($infile);
    $job_input = "$job_in_dir/$input_basename";
    copy($infile, $job_input) or die "Cannot copy $infile to $job_input: $!";
}

# Set global variables for modules to use (suppress "used only once" warnings)
our $OUTPUT_DIR = $job_tmp_dir;
our $FINAL_OUTPUT_DIR = $job_out_dir;
our $JOB_ID = $job_id;

# Also set the original ARGV variables that modules expect
$ARGV[0] = $ref_name;
$ARGV[1] = $tar_name;
$ARGV[2] = $block_size;
$ARGV[3] = $distBnMrks;
$ARGV[4] = $job_input;  # Use the copied input file

# Header printed above

# Load all subroutine definitions first
do "$modules_dir/0_subs.pl" or die "Error in 0_subs.pl: " . ($@ || $!) . "\n";

# Execute pipeline stages in order
my @stages = (
    "1_parse_and_flag.pl",
    "2_trend_change.pl",
    "3_jumping_logic.pl",
    "4_build_ref_and_merge.pl",
    "5_break_and_remerge.pl",
    "6_subovp_and_classify.pl",
    "7_final_output.pl",
);

my $start_time = time();
for my $stage (@stages) {
    print STDERR "  Stage: $stage\n";
    do "$modules_dir/$stage" or die "Error in $stage: " . ($@ || $!) . "\n";
}
my $elapsed = time() - $start_time;

print STDERR "\n" . "=" x 55 . "\n";
print STDERR "Pipeline complete! (${elapsed}s)\n";
print STDERR "Main output: $job_out_dir/blocks_info\n";

# Clean up intermediate files unless -k
if (!$keep_tmp) {
    remove_tree($job_tmp_dir);
    print STDERR "Intermediate files removed (use -k to keep)\n";
} else {
    print STDERR "Intermediate files: $job_tmp_dir/\n";
}

print STDERR "=" x 55 . "\n";

1;
