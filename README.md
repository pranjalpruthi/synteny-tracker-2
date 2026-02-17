# SyntenyTracker v2.0

<img width="602" height="100" alt="ascii-art-text" src="https://github.com/user-attachments/assets/154df9bd-8598-4aea-9a96-442f7fb5559b" />


**Modernized Modular Synteny Pipeline**

  💪Empowered by [BioinformaticsOnLine](https://bioinformaticsonline.com)

  ✨Open source bioinformatics community ✨
  

SyntenyTracker v2.0 is a comprehensive bioinformatics tool designed for comparative genomics, enabling users to identify and visualize syntenic regions between genomes. ## 📄 License & Commercial Use

## 📄 License & Commercial Use

**SyntenyTracker v2.0** is released under a **Custom Non-Commercial License**.

✅ **Academic & Non-Profit Use:** Usage for academic research and non-profit organizations is free and permitted.
❌ **Commercial Use Prohibited:** You may **NOT** use this software for paid purposes, proprietary bioinformatics pipelines, internal company tools, or distribute it within private companies without explicit permission.
🔒 **Permission Required:** For commercial use, you MUST obtain written permission from the authors (Donthu et al. and Jitendra Lab).

Original SyntenyTracker logic is derived from Donthu et al. (2009), modernized by [BioinformaticsOnLine](https://bioinformaticsonline.com).

This project is licensed under a custom Non-Commercial License - see the [LICENSE](LICENSE) file for details.umaSynteny**, providing advanced whole-genome alignment capabilities alongside traditional synteny analysis.

This version is a modernization of the original SyntenyTracker by Donthu et al. (2009), developed by the **Jitendra Lab of Bioinformatics and Big Data** at CSIR-Institute of Genomics & Integrative Biology (CSIR-IGIB).

## 🚀 Key Features

*   **Modular Architecture**: Fully modularized pipeline for better maintainability and extensibility.
*   **CLI Interface**: Robust command-line interface with job management.
*   **Satsuma Integration**: Direct support for raw Satsuma output with auto-preprocessing.
*   **Conda Distribution**: Easy installation via the `jitendralab` Conda channel.
*   **Job Management**: Automatic job ID generation and organized output directories.

## 🛠️ Installation

### Via Conda (Recommended)

```bash
conda install -c jitendralab syntenytracker2
```

### Manual Installation

Clone the repository and ensure you have Perl installed with the required modules.

```bash
git clone https://github.com/pranjalpruthi/synteny-tracker-2.git
cd synteny-tracker-2
# Ensure Perl is installed and accessible
perl -v
```

**Prerequisites:**
*   Perl 5.x
*   Core modules: `FindBin`, `File::Path`, `File::Basename`, `File::Copy`, `POSIX`, `Getopt::Long`, `Cwd`.

## 🚀 Usage

Run the pipeline using the `syntenytracker2` command (installed via Conda):

```bash
syntenytracker2 Adineta_vaga Adineta_ricciae 100000 30000 ./sample/Adineta_ricciae.txt -s -k
```

### Manual Usage

If you cloned the repository directly (without Conda), use:

```bash
perl run_synteny.pl <ref_name> <tar_name> <block_size> <distBnMrks> <infile> [options]
```

### Arguments

*   `ref_name`: Reference genome name (e.g., `Adineta_vaga`).
*   `tar_name`: Target genome name (e.g., `Adineta_ricciae`).
*   `block_size`: Block size in base pairs (e.g., `100000`).
*   `distBnMrks`: Distance between markers in base pairs (e.g., `30000`).
*   `infile`: Input file path.

### Options

| Option | Description | Default |
| :--- | :--- | :--- |
| `-j, --job-name=NAME` | Custom job name | Auto-generated timestamp |
| `-o, --output-dir=DIR` | Custom output directory | `./jobs/<job_name>` |
| `-k` | Keep intermediate files | Removed after run |
| `-s, --satsuma` | Input is raw Satsuma output | Auto-preprocess enabled |
| `-h, --help` | Show help message | - |

## 📄 Input Formats

### Default (SyntenyTracker Format)
A 9-column tab-separated file:
1.  Target Chromosome
2.  Target Start
3.  Target End
4.  Marker ID
5.  Marker ID (duplicate)
6.  Marker ID (duplicate)
7.  Reference Chromosome
8.  Reference Start
9.  Reference End

### Satsuma Output (`-s` flag)
Raw 8-column Satsuma synteny output:
1.  Target Chromosome
2.  Target Start
3.  Target End
4.  Reference Chromosome
5.  Reference Start
6.  Reference End
7.  Score
8.  Sign (+/-)

## 📂 Output Organization

The pipeline creates a structured output directory for each job:

```
<output_dir>/
├── in/           # Input file (copied for reproducibility)
├── out/          # Main output files (including blocks_info)
└── out/.tmp/     # Intermediate files (testOut*) - only if -k is used
```

## 💡 Examples

**Basic usage with formatted input:**
```bash
perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 st_input.txt
```

**Process raw Satsuma output:**
```bash
perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 satsuma.out -s
```

**Custom job name and output directory:**
```bash
perl run_synteny.pl Adineta_vaga Adineta_ricciae 100000 30000 input.txt -j my_analysis -o /path/to/results
```

## 📜 Citation

If you use this tool, please cite the original SyntenyTracker paper:

> Donthu R, Lewin HA, Larkin DM. (2009)
> **SyntenyTracker: a tool for defining terrestrial vertebrate syntenic blocks.**
> *BMC Res Notes*. 2:148. [DOI: 10.1186/1756-0500-2-148](https://doi.org/10.1186/1756-0500-2-148)

## 🔗 Links

*   **GitHub**: [https://github.com/pranjalpruthi/synteny-tracker-2](https://github.com/pranjalpruthi/synteny-tracker-2)
*   **BioinformaticsOnLine**: [https://bioinformaticsonline.com](https://bioinformaticsonline.com)
*   **Conda Channel**: [https://anaconda.org/channels/jitendralab/](https://anaconda.org/channels/jitendralab/)

---

**Maintained by:** Pranjal Pruthi (Dev) & Dr. Jitendra Narayan (PI)
**Lab:** Jitendra Lab of Bioinformatics and Big Data, CSIR-IGIB
