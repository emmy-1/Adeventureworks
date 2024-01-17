def calculate_missing_percentage(dataset):
    total_rows = len(dataset)
    missing_rows = dataset.isnull().sum().sum()
    missing_percentage = (missing_rows / total_rows) * 100
    return missing_percentage

