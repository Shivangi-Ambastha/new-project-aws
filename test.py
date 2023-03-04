import terrascan

# Initialize Terrascan
scanner = terrascan.Scanner()

# Define the directory to scan
directory = "./"

# Set the scan type to Terraform
scan_type = "terraform"

# Run the scan and capture the results
results = scanner.scan_dir(directory, scan_type)

# Print the results
print(results)
