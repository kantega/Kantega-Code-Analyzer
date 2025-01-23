import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import sys

# Load the CSV file into a DataFrame
input_csv_file = sys.argv[1]
df = pd.read_csv(input_csv_file)

output_png = sys.argv[2]

# Ensure the columns are as expected
if set(["module", "revisions", "code"]) <= set(df.columns):

    # Extract data
    N = 20  # Change this to the number of characters you want to show
    x_labels = [label[-N:] if len(label) > N else label for label in df["module"]]
    revisions = df["revisions"]
    code = df["code"]

    # Bar width and x positions
    bar_width = 0.4
    x_indexes = np.arange(len(x_labels))

    # Create the figure and axis objects
    fig, ax1 = plt.subplots(figsize=(12, 6))

    # First y-axis (left)
    ax1.bar(x_indexes - bar_width / 2, revisions, width=bar_width, color='blue', label='Revisions')
    ax1.set_ylabel('Revisions', color='blue')
    ax1.tick_params(axis='y', labelcolor='blue')

    # Second y-axis (right)
    ax2 = ax1.twinx()
    ax2.bar(x_indexes + bar_width / 2, code, width=bar_width, color='green', label='Code')
    ax2.set_ylabel('Code', color='green')
    ax2.tick_params(axis='y', labelcolor='green')

    # Common x-axis
    ax1.set_xlabel('Module')
    ax1.set_xticks(x_indexes)
    ax1.set_xticklabels(x_labels, rotation=45, ha='right')

    # Add a legend
    ax1.legend(loc='upper left')
    ax2.legend(loc='upper right')

    # Title and layout adjustments
    plt.title("Double Bar Chart of Revisions and Code by Module")
    plt.tight_layout()

    # Show the plot
    plt.savefig(output_png)
    plt.close()
else:
    print("The CSV file must contain the headers: 'module', 'revisions', and 'code'.")
