library(VariantAnnotation)

file_name = ""
genome_build = "hg38"

# Load VCF
vcf <- readVcf(file_name, genome_build)

# Get VEP Annotations
info_data <- info(vcf)
csq_data <- as.character(unlist(info_data$CSQ))
csq_list <- strsplit(csq_data, "\\|")

# Extract the header description for the CSQ field
vcf_header <- header(vcf)
csq_header <- info(vcf_header)["CSQ", "Description"]

# Parse the CSQ header to get column names
csq_columns <- strsplit(gsub(".*Format: ", "", csq_header), "\\|")[[1]]

# Bind the split CSQ list into a data frame
csq_df <- do.call(rbind, csq_list)
csq_df = as.data.frame(csq_df)
colnames(csq_df) <- csq_columns

# Clean up
rm(c(
    info_data,
    csq_data,
    csq_list,
    vcf_header,
    csq_header,
    csq_columns
))